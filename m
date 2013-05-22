From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Wed, 22 May 2013 23:09:00 +0100
Organization: OPDS
Message-ID: <6B51848E2F9A40078A2E42CE4BB499DA@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1368964449-2724-3-git-send-email-philipoakley@iee.org><20130519173924.GB3362@elie.Belkin><7v38thwn6l.fsf@alter.siamese.dyndns.org><BDA138F1A58247F4A4940B3436A94485@PhilipOakley><7v1u91uw95.fsf@alter.siamese.dyndns.org><08847FEAFB00489695F31AA651F5EA2E@PhilipOakley><7vfvxgqp3m.fsf@alter.siamese.dyndns.org><CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com><7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley> <CAMP44s3rpS==ANz_OEVyVeUWXFNBu7RZaxJ5k-b7N5k9WFFhVw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"GitList" <git@vger.kernel.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:09:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHDR-0002NA-25
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319Ab3EVWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:08:57 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:47403 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756513Ab3EVWI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 18:08:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AicPAPxAnVFOl3dE/2dsb2JhbABagwgwgzuFP7h1BAEDAYEGF3SCHgUBAQQBCAEBGQQREQUIAQEWCwsCAwUCAQMUAQECAgIFIQICFAEECBACBgcXBggLCAIBAgMBDASHWgMJCgipNohkDYh0gSaLIIFtaoJIMmEDjmiGaoMPinSFI4MQOw
X-IronPort-AV: E=Sophos;i="4.87,724,1363132800"; 
   d="scan'208";a="576200640"
Received: from host-78-151-119-68.as13285.net (HELO PhilipOakley) ([78.151.119.68])
  by out1.ip06ir2.opaltelecom.net with SMTP; 22 May 2013 23:08:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225195>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Wednesday, May 22, 2013 12:03 AM
> On Tue, May 21, 2013 at 5:33 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Felipe Contreras" <felipe.contreras@gmail.com>
>> Sent: Tuesday, May 21, 2013 10:21 PM
>>
>>> On Tue, May 21, 2013 at 11:23 AM, Junio C Hamano <gitster@pobox.com>
>>> wrote:
>>>>
>>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>
>>>>> On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder 
>>>>> <jrnieder@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> Another trick is to use "git push":
>>>>>>         git push . $production_sha1:refs/heads/master
>>>>
>>>>
>>>> It all falls out naturally from the "Git is distributed and no
>>>> repository is special" principle.  I think that word "trick" merely
>>>> refers to "those who do not realize that the local repository is 
>>>> not
>>>> all that special and merely is _a_ repository just like anybody
>>>> else's may not realize they can do this", nothing more.
>>>
>>> Nobody cares.
>>
>> The value of the trick was acknowledged as now being in use
>> http://article.gmane.org/gmane.comp.version-control.git/223572
>
> How is that more useful than 'git branch -f master $sha1'?

The 'trick' checks for a fast forward, while the branch update is 
forced. It depends on what checks are desired.

My original patch was to simply document Git's dot repository capability 
that does not appear to be that well known. Let's not keep it as an 
Easter Egg.

>
>> Not sure if that was the caring you were commenting on.
>
> My point is that nobody uses '.' as a remote. Yes, you can find the
> occasional esoteric person in the Git mailing list that might find
> some weird command useful, but that's the fringe user-base.
>
>>> You say it's "mistaken", but you are not the arbiter of truth; the
>>> fact that you say it's so doesn't make it so. It's just rhetoric.
>>>
>>> You haven't shown that it's indeed mistaken.
>>
>>
>> An aside: in some domains (e.g. Human Error taxonomy) a 'mistake' is 
>> a
>> planned action which later turns out to not be the action that would 
>> now
>> have, in retrospect, been chosen. The intent was good, but is later 
>> classed
>> (within the taxonomy) as a 'mistake'. (It is not related to 'blame').
>
> Yeah, that's what a mistake is, in my mind.
>
>> If I understand the extended thread correctly, the approach moved on 
>> and
>> alternatives were found, so in that sense the intent was good.
>
> No, the approach didn't move on, there are no better alternatives, the
> "intent" is irrelevant, the approach is good, there is no mistake.
>
> Junio simply ignored the fact that he was proven wrong.
>
> I still haven't received a response: which makes more sense?
>
> a)
>
> % git checkout svn-ext
> % git fetch
> From .
> * branch            master     -> FETCH_HEAD
> # oops
> % git fetch git-svn
> % git log ..FETCH_HEAD
> % git merge FETCH_HEAD
>
> b)
>
> % git checkout svn-ext
> % git fetch
> From git://git.kernel.org/pub/scm/git/git
>    680ed3e..de3a5c6  master     -> origin/master
> # oops
> % git fetch svn-ext
> % git log ..FETCH_HEAD
> % git merge FETCH_HEAD
>
> -- 
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.3343 / Virus Database: 3162/6344 - Release Date: 
> 05/21/13
> 
