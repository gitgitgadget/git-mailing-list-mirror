From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 23:33:54 +0100
Organization: OPDS
Message-ID: <7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1368964449-2724-3-git-send-email-philipoakley@iee.org><20130519173924.GB3362@elie.Belkin><7v38thwn6l.fsf@alter.siamese.dyndns.org><BDA138F1A58247F4A4940B3436A94485@PhilipOakley><7v1u91uw95.fsf@alter.siamese.dyndns.org><08847FEAFB00489695F31AA651F5EA2E@PhilipOakley><7vfvxgqp3m.fsf@alter.siamese.dyndns.org> <CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"GitList" <git@vger.kernel.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 00:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uev7q-0007xC-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3EUWdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 18:33:42 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:11803 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604Ab3EUWdl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 18:33:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnoPAI31m1FOl3CI/2dsb2JhbABagwgwgzuFP7hlBAEDAYEKF3SCHgUBAQUIAQEZFR4BASELAgMFAgEDFQECAgIFIQICFAEECBIGBxcGARIIAgECAwGHagMTCKl+iQQNiF6BJosdgWMKaoJIMmEDjmiGaoMPinSFI4MQOw
X-IronPort-AV: E=Sophos;i="4.87,716,1363132800"; 
   d="scan'208";a="410418178"
Received: from host-78-151-112-136.as13285.net (HELO PhilipOakley) ([78.151.112.136])
  by out1.ip04ir2.opaltelecom.net with SMTP; 21 May 2013 23:33:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225087>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Tuesday, May 21, 2013 10:21 PM
> On Tue, May 21, 2013 at 11:23 AM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com>
>>> wrote:
>>>> Another trick is to use "git push":
>>>>         git push . $production_sha1:refs/heads/master
>>
>> It all falls out naturally from the "Git is distributed and no
>> repository is special" principle.  I think that word "trick" merely
>> refers to "those who do not realize that the local repository is not
>> all that special and merely is _a_ repository just like anybody
>> else's may not realize they can do this", nothing more.
>
> Nobody cares.

The value of the trick was acknowledged as now being in use
http://article.gmane.org/gmane.comp.version-control.git/223572
Not sure if that was the caring you were commenting on.

My patch was to make it better known and that it (the dot repository) 
isn't a 'trick'.

I'll refresh them after v1.8.3.

>
>>> Filipe gave 'git fetch .' in [PATCH 1/3] fetch: add --allow-local
>>> option, 16 May 2013
>>
>> That patch came from a mistaken suggestion from me that was
>> retracted with
>
> You say it's "mistaken", but you are not the arbiter of truth; the
> fact that you say it's so doesn't make it so. It's just rhetoric.
>
> You haven't shown that it's indeed mistaken.

An aside: in some domains (e.g. Human Error taxonomy) a 'mistake' is a 
planned action which later turns out to not be the action that would now 
have, in retrospect, been chosen. The intent was good, but is later 
classed (within the taxonomy) as a 'mistake'. (It is not related to 
'blame').

If I understand the extended thread correctly, the approach moved on and 
alternatives were found, so in that sense the intent was good.

>
> -- 
> Felipe Contreras
