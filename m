From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 10:36:44 +0200
Message-ID: <200610211036.44679.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <vpqk62uhzkk.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 10:36:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbCLX-0002um-4W
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 10:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWJUIgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 04:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbWJUIgo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 04:36:44 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:27237 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161193AbWJUIgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 04:36:43 -0400
Received: by hu-out-0506.google.com with SMTP id 28so507042hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 01:36:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OsJIF6iUgX7v4Vjz94MIwOSkeSwhSRmmS0DD9mDpqK5a/KMJlNKEVUK7ScYHpRgjhoit8iiu1GqFMnlXNcsRLbwh8YMjRr0IsRs2kCStxhtCBviUOod1+2qsAEqRwzALaJljMl9cXdHmIjM0Qw2yyugJlvXWxfpnigV8NkldAO8=
Received: by 10.66.220.17 with SMTP id s17mr3485548ugg;
        Sat, 21 Oct 2006 01:36:42 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e1sm1553086ugf.2006.10.21.01.36.41;
        Sat, 21 Oct 2006 01:36:41 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <vpqk62uhzkk.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29592>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> It's my understanding that most changes discussed on lkml are provided
>>> as a series of patches.  Bazaar bundles are intended as a direct
>>> replacement for patches in that use case.
>>
>> As _series_ of patches. You have git-format-patch + git-send-email
>> to format and send them, git-am to apply them (as patches, not as branch).
>>
>> I was under an impression that user sees only mega-patch of all the
>> revisions in bundle together, and rest is for machine consumption only.
> 
> Nothing prevents you from using series of bundles.
> 
> A bundle for a single revision looks like a patch with a few comments
> on top and bottom. _If_ you have several revisions in your patch, you
> get the diff as human readable, and the intermediate revisions as
> MIME-encoded.
> 
> For big changes, people do send several bundles.
> 
> So, a bundle is a direct replacement for a patch, not for series of
> patches.

Ah, that explains this. So why people use bundles instead of patches
(with some metainfo like commit message)? And do bzr have command to
apply in correct ordering series of bundles send either chain replied
to (each patch in the series is reply to previous patch) or being
replies to patchseries introductory message?

-- 
Jakub Narebski
Poland
