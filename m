From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 18:03:10 -0500
Message-ID: <CAMP44s3rpS==ANz_OEVyVeUWXFNBu7RZaxJ5k-b7N5k9WFFhVw@mail.gmail.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
	<7v1u91uw95.fsf@alter.siamese.dyndns.org>
	<08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
	<7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
	<CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com>
	<7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed May 22 01:03:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UevaO-0002jm-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 01:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab3EUXDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 19:03:12 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:48946 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab3EUXDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 19:03:12 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so1329515lab.35
        for <git@vger.kernel.org>; Tue, 21 May 2013 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hep+30stYRPaFm2vKZ4aafUrZwEiajKuttcptWeXWtA=;
        b=HoOhJAzU80tlED8NQqyzeAdhCW6tLcHDPPIEKZosru1R/H3KH5xPxyCJk0WvokgF1q
         07QDL2xm99eDLr+fXJa9FY2OQJzfJ+CTgPAr0mYoKWfmtsftgQ5tEAIWiG1txBwlMLTy
         ZW5fDWarZIzNX+iXWk4Wg2sOzHwGKCZhEl+eBhd72ypsRtKPONVczGpnC0EkeVoKkRXK
         cPKPFDFqt+L7gw+wtzZl8gAsLdXjXJONA7aSTHnPkjpcMp+1p4Ov2OdG4CRgi8AMHKUr
         smsAeAkzUXhVS9b99PESxv1chqitvhibNJvmOVfPguPsC1jdHrj38r0tL5uVMmFBm4hr
         JyiQ==
X-Received: by 10.112.164.105 with SMTP id yp9mr91160lbb.103.1369177390328;
 Tue, 21 May 2013 16:03:10 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 16:03:10 -0700 (PDT)
In-Reply-To: <7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225091>

On Tue, May 21, 2013 at 5:33 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Tuesday, May 21, 2013 10:21 PM
>
>> On Tue, May 21, 2013 at 11:23 AM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>>
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>
>>>> On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com>
>>>> wrote:
>>>>>
>>>>> Another trick is to use "git push":
>>>>>         git push . $production_sha1:refs/heads/master
>>>
>>>
>>> It all falls out naturally from the "Git is distributed and no
>>> repository is special" principle.  I think that word "trick" merely
>>> refers to "those who do not realize that the local repository is not
>>> all that special and merely is _a_ repository just like anybody
>>> else's may not realize they can do this", nothing more.
>>
>> Nobody cares.
>
> The value of the trick was acknowledged as now being in use
> http://article.gmane.org/gmane.comp.version-control.git/223572

How is that more useful than 'git branch -f master $sha1'?

> Not sure if that was the caring you were commenting on.

My point is that nobody uses '.' as a remote. Yes, you can find the
occasional esoteric person in the Git mailing list that might find
some weird command useful, but that's the fringe user-base.

>> You say it's "mistaken", but you are not the arbiter of truth; the
>> fact that you say it's so doesn't make it so. It's just rhetoric.
>>
>> You haven't shown that it's indeed mistaken.
>
>
> An aside: in some domains (e.g. Human Error taxonomy) a 'mistake' is a
> planned action which later turns out to not be the action that would now
> have, in retrospect, been chosen. The intent was good, but is later classed
> (within the taxonomy) as a 'mistake'. (It is not related to 'blame').

Yeah, that's what a mistake is, in my mind.

> If I understand the extended thread correctly, the approach moved on and
> alternatives were found, so in that sense the intent was good.

No, the approach didn't move on, there are no better alternatives, the
"intent" is irrelevant, the approach is good, there is no mistake.

Junio simply ignored the fact that he was proven wrong.

I still haven't received a response: which makes more sense?

a)

	% git checkout svn-ext
	% git fetch
	From .
	 * branch            master     -> FETCH_HEAD
	# oops
	% git fetch git-svn
	% git log ..FETCH_HEAD
	% git merge FETCH_HEAD

b)

	% git checkout svn-ext
	% git fetch
	From git://git.kernel.org/pub/scm/git/git
	   680ed3e..de3a5c6  master     -> origin/master
	# oops
	% git fetch svn-ext
	% git log ..FETCH_HEAD
	% git merge FETCH_HEAD

-- 
Felipe Contreras
