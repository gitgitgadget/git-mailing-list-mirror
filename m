From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 11:02:59 +0100
Organization: OPDS
Message-ID: <5E98A1684FFB4A7D93A17A609F92A1B3@PhilipOakley>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com><xmqqd2opu8hr.fsf@gitster.dls.corp.google.com><CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com><xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com><20130904081047.GB2582@serenity.lan><xmqqa9jso69u.fsf@gitster.dls.corp.google.com><7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley><xmqqr4d4jird.fsf@gitster.dls.corp.google.com><20130905080606.GE2582@serenity.lan><CAMP44s1Rb2WKGD-QfNh055099R+9FHv9W8TA8Gfjp=qZh_7p7Q@mail.gmail.com><8B7F235220624B259BB32B293BCB3E96@PhilipOakley><CAMP44s2pw2TZSZ6pL-kx_QQCkjKrprERyvddCT-HTeo7uRNENA@mail.gmail.com><01BEC88E9B724BA4986F2678A4D9F4E6@PhilipOakley> <CAMP44s1ZjtVdj1wys_7VkBrmvGAkh9cfOpZ_22aVONMH3GdcRg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "John Keeping" <john@keeping.me.uk>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Andreas Krey" <a.krey@gmx.de>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 12:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIbpm-0002AC-R8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 12:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab3IHKCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 06:02:55 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38476 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab3IHKCy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 06:02:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIMALBKLFJOl3GZ/2dsb2JhbABbgwc4g3uFPrkXBAQBgSIXdIIgBQEBBAEIAQEZFR4BASEFBgIDBQIBAxUBAgICBSECAhQBBAgSBgcXBhMIAgECAwGHXwMJCgi1cId3DYh7gSmLaYJugnA0gQADjw+GfY4ghS+DITs
X-IPAS-Result: AgIMALBKLFJOl3GZ/2dsb2JhbABbgwc4g3uFPrkXBAQBgSIXdIIgBQEBBAEIAQEZFR4BASEFBgIDBQIBAxUBAgICBSECAhQBBAgSBgcXBhMIAgECAwGHXwMJCgi1cId3DYh7gSmLaYJugnA0gQADjw+GfY4ghS+DITs
X-IronPort-AV: E=Sophos;i="4.90,863,1371078000"; 
   d="scan'208";a="440590607"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 08 Sep 2013 11:02:52 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234232>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Sunday, September 08, 2013 9:49 AM
> On Sun, Sep 8, 2013 at 3:42 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>
>> The 'problem' is (would be) that I don't yet know that I would need 
>> the
>> --onto pu until I discover (how?) that the default rebase would 
>> result in
>> conflicts.
>
> I don't see what that has to do with an invocation of 'git rebase'
> without arguments, and @{tail}.

>         There's absolutely no way Git can
> figure out for you which is the appropriate place for you to rebase
> onto.
.. which was my point. I may not have explained it that well.

Given that Git can't figure it out, we should stop trying in such cases.

>
> However, it shouldn't be too difficult to write a tool that checks
> multiple commits and tells you on top of which ones a rebase could
> work, but I don't think 'git rebase' is the right place.

That's an SOS approach (Success Oriented Script)[1] that presumes the 
user is already better than they are - The Kruger Dunning paper [2] 
offers some insight into capability misconceptions (at all levels).

--
regards

Philip
--
[1] in the original it was a "Success Oriented Schedule" - one of those 
plans that hopeful managers put together on late running projects that 
amount to wishful thinking that hopefully garners them enough time to 
make a little progress and update their 'success stories'.
[2] http://dx.doi.org/10.1111%2F1467-8721.01235 "Why People Fail to 
Recognize Their Own Incompetence". Though the corollaries (People fail 
to recognise their own skills, and hence they/we mishandle our 
communications) are just as (IMHO more) important. 
