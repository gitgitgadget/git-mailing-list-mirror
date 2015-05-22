From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule does not yield complete logs")
Date: Fri, 22 May 2015 18:40:36 +0100
Organization: OPDS
Message-ID: <64326DCF30A041379141BB51437E87A6@PhilipOakley>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com> <xmqq8ucghf2s.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Stefan Beller" <sbeller@google.com>,
	"Robert Dailey" <rcdailey.lists@gmail.com>,
	"Heiko Voigt" <hvoigt@hvoigt.net>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Jens Lehmann" <Jens.Lehmann@web.de>, "Git" <git@vger.kernel.org>,
	"Thomas Ferris Nicolaisen" <tfnico@gmail.com>,
	<emma@gitforteams.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Roberto Tyley" <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:40:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvqw3-0005hZ-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 19:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612AbbEVRkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 13:40:35 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:42073 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757599AbbEVRke (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 13:40:34 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CkEABVaV9VPJBLFlxSCoMQVF6HOr1HhW0EBAKBOk0BAQEBAQEHAQEBAUEkG0EDg1kGAQEECAEBHREeAQEWCwsCAwUCAQMVDBoLFAEECBIGBwMUBgESCAIBAgMBiAYDFgm2Upg8DYRyDAEbBIs6gT0BgQ+BVQYLAVGDHoEWBYwGhnx5gzyCT4F3OYMUjmmHAYI6JIE+PTGBDIE7AQEB
X-IPAS-Result: A2CkEABVaV9VPJBLFlxSCoMQVF6HOr1HhW0EBAKBOk0BAQEBAQEHAQEBAUEkG0EDg1kGAQEECAEBHREeAQEWCwsCAwUCAQMVDBoLFAEECBIGBwMUBgESCAIBAgMBiAYDFgm2Upg8DYRyDAEbBIs6gT0BgQ+BVQYLAVGDHoEWBYwGhnx5gzyCT4F3OYMUjmmHAYI6JIE+PTGBDIE7AQEB
X-IronPort-AV: E=Sophos;i="5.13,477,1427756400"; 
   d="scan'208";a="157567685"
Received: from host-92-22-75-144.as13285.net (HELO PhilipOakley) ([92.22.75.144])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 22 May 2015 18:40:32 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269743>

From: "Junio C Hamano" <gitster@pobox.com>
> Roberto Tyley <roberto.tyley@gmail.com> writes:
>
>> Hello, I'm stepping up to do that work :) Or at least, I'm 
>> implementing a
>> one-way GitHub PR -> Mailing list tool, called submitGit:
>>
>> https://submitgit.herokuapp.com/
>
> Yay ;-)
>
>> Here's what a user does:
>>
>> * create a PR on https://github.com/git/git
>> * logs into https://submitgit.herokuapp.com/ with GitHub auth
>> * selects their PR on https://submitgit.herokuapp.com/git/git/pulls
>
> Reasonable.
>
>> * gets submitGit to email the PR as patches to themselves, in order 
>> to
>> check it looks ok
>
> I can see you are trying to be careful by doing this, but I am not
> sure if this step would actually help. Those who are not familiar
> with Git development are not expected to know what is "ok" in their
> original commit, and if they find bad formatting done by submitGit
> (e.g. adds their PR message before the three-dash line instead of
> after it), they cannot do much about it anyway.

I still think this is valuable for the spotting of the dumb mistakes we 
all make, and notice after the fact when we see the email in the hard 
light of day. There will still be poor commit messages and the like, but 
at least the raw content is more likely to be as the author desired.

>
>> * when they're ready, get submitGit to send it to the mailing list on
>> their behalf
>
> Nice.
>
>> All discussion of the patch *stays* on the mailing list
>
> Can you identify a reroll of an earlier submission?  If you can use
> the in-reply-to and make it a follow-up to the previous round, that
> would be great.
> --
Philip 
