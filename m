From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 14:03:30 +0100
Message-ID: <85b5c3130811260503k445b0debr2f681f9766cfc361@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
	 <492D227C.8020805@drmicha.warpmail.net>
	 <alpine.DEB.1.00.0811261344120.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 14:06:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5K5Z-0003G4-R4
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 14:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbYKZNDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbYKZNDe
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 08:03:34 -0500
Received: from gv-out-0910.google.com ([216.239.58.191]:41303 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbYKZNDc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 08:03:32 -0500
Received: by gv-out-0910.google.com with SMTP id e6so137594gvc.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=8TLPlTRcpI9WyNMgr1cXn0GzatRohEyLzsFohD7ueTE=;
        b=UuivwrMQIOwgqFNG8PBI7WWTOJBI5L4lHbjvmxEEmBepaHJaC3wQhEcgC9/rmfC5W/
         1F10M+p9/Rt46yL5PMxVlP1D6zxDrgaB++hREpQYunU/xdhocJ9WSsdTKpOipSFQEawT
         JarsQxCYudywxcIdYz1TF4ydSMmnj6wWAeL28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=FIamQxD6Mm2efL18f0KHzGmSrHiYjidG9wEKyIEeD71aeclaf9oSviRUjGkRud3vtO
         LGSwQJpbWom77mVxP3eS9LWLxZNPyvgVXI/CfiOUmxrBx7gA9T1Fz3qo5PU0YCvhP+4a
         wVsjRxZxzbIaXkG/RcmRFNqBYKrEonf8jKoRc=
Received: by 10.86.91.12 with SMTP id o12mr3776634fgb.52.1227704610365;
        Wed, 26 Nov 2008 05:03:30 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Wed, 26 Nov 2008 05:03:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811261344120.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 9156ce7d7bcaaab9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101731>

On Wed, Nov 26, 2008 at 1:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Ondrej & Michael,
>
> On Wed, 26 Nov 2008, Michael J Gruber wrote:
>
>> Johannes Schindelin venit, vidit, dixit 26.11.2008 01:14:
>>
>> > Can you try again with a Git version that contains the commit
>> > 2075ffb5(fast-export: use an unsorted string list for extra_refs)?
>
> Okay, so both of your use cases seem to be real bugs in fast-export.  May
> I respectfully submit a request for a test script (as patch to
> t/t9301-fast-export.sh)  which is as short as possible and shows the
> respective bugs?
>
> My Git time budget these days is almost negative, so I will not be able to
> work on these issues without having a small and concise example.

I'll do my best and try to create a simple example. I'll report back
if I have something.

Ondrej
