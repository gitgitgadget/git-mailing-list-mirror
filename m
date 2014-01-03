From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH v2 00/18] remote-bzr: massive changes
Date: Fri, 03 Jan 2014 15:17:14 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <8761q0hlbp.fsf@flea.lifelogs.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
	<7vppxb8d9k.fsf@alter.siamese.dyndns.org>
	<CAMP44s3zf0Hbx4-KHVH7+wCm_czTigJo2y=wqD5Ai-9cKxZcug@mail.gmail.com>
	<7vli7y8xia.fsf@alter.siamese.dyndns.org>
	<CAMP44s0n28ihRXf4f25Sx0jkg2u-eROR93bkO0Nm6X00tmkVMA@mail.gmail.com>
	<7vehdq5yvc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 21:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzB9w-000625-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 21:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbaACUPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 15:15:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:36088 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbaACUPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 15:15:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VzB9n-0005pI-VE
	for git@vger.kernel.org; Fri, 03 Jan 2014 21:15:47 +0100
Received: from c-98-229-61-72.hsd1.ma.comcast.net ([98.229.61.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 21:15:47 +0100
Received: from tzz by c-98-229-61-72.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 21:15:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-229-61-72.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:kh+UYbpAOhEsjf8GuBbiTzuG9b8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239935>

On Wed, 01 May 2013 11:38:47 -0700 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> On Wed, May 1, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>> 
>>>>> So let's go ahead and apply these directly on top of 'master', once
>>>>> we hear from Emacs folks and they are happy with it.  I'll queue it
>>>>> on 'pu' so that I do not have to go back to the list archive when it
>>>>> happens.
>>>> 
>>>> I already heard that everything seems to be working correctly, except
>>>> one feature, the biggest change, which I screwed up with a one-liner
>>>> commit. That's why I added a test. Anyway, I've fixed it in my github
>>>> branch and in this patch series, and I've told them to try the fix.
>>> 
>>> Let us know when they make progress on that front.
>>> 
>>> If Emacs decides to switch to Git and decides to use this version of
>>> remote-bzr for their conversion, or at least a nontrivial group of
>>> developers favor to do so, without seeing concrete technical points
>>> that say remote-bzr is not yet ready (e.g. "the conversion is still
>>> wrong and X, Y and Z needs to be fixed"), that would be a very
>>> welcome solid vote of confidence in favor of us going ahead with
>>> this.
>> 
>> Seems unlikely for political reasons (isn't it always for GNU?), since
>> RMS is heavily involved in the decision.

JCH> I am very aware of that discussion (and the original one when they
JCH> decided to use bzr).  That is exactly why I said "at least ... favor
JCH> to do so".

FYI, in case you're not aware, there's a pretty strong feeling on
emacs-devel that the switch to Git will happen and RMS is not opposed.

I don't know if they'll use remote-bzr, though.  It's more likely
they'll use one of the already-existing mirrors and sync it up, based on
the feedback so far.  It's a good time to bring remote-bzr up on
emacs-devel if you want it to be considered.

HTH
Ted
