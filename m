From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Re: why still no empty directory support in git
Date: Wed, 31 Dec 2008 18:50:16 -0800
Message-ID: <3665a1a00812311850p59f0f5e7ode1853d26c30b26@mail.gmail.com>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
	 <4959BB07.6000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ping Yin" <pkufranky@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Liu Yubao" <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 03:55:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIDir-0000O5-Gc
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 03:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZAACuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 21:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbZAACuT
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 21:50:19 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:4178 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbZAACuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 21:50:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2971862wah.21
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 18:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OClekQw+pxhPMPcgOUk5nhuiJYooylQBCi3DRembIDY=;
        b=xb/qHfHLE0t8dN67EF7VSzYfs400YKFx+SxAvLAwSBY1I/mbl9HuX8Z6YA9foG/65t
         SvYjmred8EPq++HlrNRMfxTOP28FOkd6ZTrovLKDJhZggAEAy9pX2bISOjz7IplI6/FD
         tbxglgYgiEYHoXTYRP6pUre0CQlaYdAknKuGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fmwI9hxZ4Pv3ZaLPJTaaFKIftM/r5Mb+MvpmmoNVIEhzzunBX+q3YXKgVU1ZkbzdTs
         y29M83iZ06+ZoED1xHtqQ1P6G/koPAy6gIm7GBCQDHmhbyQ663LFdGOdm9B5pVUYwMZR
         RVZeYIM8pkhgBz5+ulahP+Un5+p4p8ojwb4bs=
Received: by 10.115.76.5 with SMTP id d5mr10891835wal.55.1230778216376;
        Wed, 31 Dec 2008 18:50:16 -0800 (PST)
Received: by 10.114.76.6 with HTTP; Wed, 31 Dec 2008 18:50:16 -0800 (PST)
In-Reply-To: <4959BB07.6000106@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104288>

Hi

On Mon, Dec 29, 2008 at 10:09 PM, Liu Yubao <yubao.liu@gmail.com> wrote:
>
> Ping Yin wrote:
> > Yes, i know this topic has been discussed for many times. However, i
> > am still not clear about the real reason.
> >
> > So which is the reason?
> >
> > 1. it's by design, intentional
> It's saied somewhere git is a "stupid content tracker", it cares file content
> not file name, and empty directories will complicate the merge algorithm
> unnecessarily.

Could you please explain how will it complicate merging. What is the
difference between merging 2 directories with 0 and 5 files and
merging 2 directories with 5 and 10 files?

+1 that git should respect empty directories. Git should handle file
content and not decide for user does he want to keep empty directory
in the source tree or not.

--
anatol
