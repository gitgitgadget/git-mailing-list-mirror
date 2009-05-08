From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Bug: 'git am --abort' can silently reset the wrong branch
Date: Fri, 8 May 2009 10:37:39 +0200
Message-ID: <fabb9a1e0905080137v613d6b9hccd6d17149bd049f@mail.gmail.com>
References: <20090506191945.GG6325@blackpad> <20090508082826.GA29737@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eduardo Habkost <ehabkost@raisama.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 10:38:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Lb0-00074i-MG
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbZEHIiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbZEHIiA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:38:00 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:44032 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZEHIh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:37:59 -0400
Received: by bwz22 with SMTP id 22so1221911bwz.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0SlmGrcSdSqbyblV3grXUlIfhnUn/qw+I9PD8Vu5g/A=;
        b=WbCshAyp7y+EBY3CRe20mxe8jnqrg6fqGXYl2uGq4F8NsYHE97sU0ryLQu7ZZ9SqJC
         YdV9enh+17n+Yk4AI+mim8riTAtneaqfwg/Kiff2KdkoDUZwua+HETS1ry+H90Q6RVsV
         n/LUnZlz6lSRGc+n++HHn9gnzBNo5k2jGXwYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h9BtXSDQWp+HMpQhgrI6Yb7+FFfwITPSjBXjmUxT3tuOFEJ9eyoplNWgX+L1eWPHdU
         nkyVSMVR2dIJqtPFv7GMhYUSfmHHadBapZcytsFjjZZXGM8kaKaUCmARGHiXg/Cxe4v5
         mCxRSEhgOS1YIJ3MKYCZctjpUoi8UNKO4aB9Q=
Received: by 10.103.161.16 with SMTP id n16mr2189586muo.79.1241771879077; Fri, 
	08 May 2009 01:37:59 -0700 (PDT)
In-Reply-To: <20090508082826.GA29737@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118587>

Heya,

On Fri, May 8, 2009 at 10:28, Jeff King <peff@peff.net> wrote:
> So maybe just picking the changed-branch situation is the best we can
> do. I'd be interested to hear comments from others.

FWIW, I usually use 'git am' on accident (when trying to type somthing
else :P), and I would prefer if 'git am --abort' would just clean up
it's own mess, but leave my working dir alone. If I want to obliterate
my data I can 'git reset --hard' myself.

-- 
Cheers,

Sverre Rabbelier
