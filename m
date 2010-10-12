From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Tue, 12 Oct 2010 17:39:45 +0200
Message-ID: <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
References: <loom.20101012T114900-532@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 17:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5gxF-0007Bu-RW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 17:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab0JLPjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 11:39:48 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49697 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459Ab0JLPjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 11:39:47 -0400
Received: by qwa26 with SMTP id 26so481374qwa.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=FinrPJZwD2qXFMyznEtEw+XE7yUm67Gf1JNjaHxGiss=;
        b=rgJTDwBnOQg2cfnd8O7Xq8iuJ1KDauQ4abNKhmJLo/nuy2svCX9+NRM6fFzC1IZovH
         WCuVlqo2oQ0n1LBMjCmgvwfEGNDMW5SXAXYOV2/AtEcrU/utMAdNLLbax/cMI4TF9hRF
         hdGuCqiy1/DJf+8aYoAaC3Vbr1/Q68aMfWn4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IOipSe6uk9RWOUs2+5gEVn0Kx255L2JH1b9INCFOnhGsY9sjUax7hxdKSBP5WNaSFD
         0D0xWrROX/yI2FhowWnRvlx3Xtot80zDfqr7BsG2FFWQoaoeRagyzlyXdQeI+B7lB92o
         T74KrN8cr42KVDvqQvaFv9tnWpQPTLhbYMaCs=
Received: by 10.224.174.147 with SMTP id t19mr5790141qaz.262.1286897985364;
 Tue, 12 Oct 2010 08:39:45 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Tue, 12 Oct 2010 08:39:45 -0700 (PDT)
In-Reply-To: <loom.20101012T114900-532@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158857>

On Tue, Oct 12, 2010 at 12:03, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> Can I checkout a certain file to a specific revision without also adding this
> content to the index? I only want to alter the working-tree - no modification of
> index or HEAD needed.

"git show <revision-specification>:path/name > path/name" ?
