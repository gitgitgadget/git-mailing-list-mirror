From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH JGIT] fix typo
Date: Sun, 1 Feb 2009 12:42:56 +0000
Message-ID: <2faad3050902010442v6f64b804l79689245c6a60ff4@mail.gmail.com>
References: <1233411967.8213.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 13:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTbgZ-0004yz-Lw
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 13:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbZBAMnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 07:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbZBAMnA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 07:43:00 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:32795 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZBAMm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 07:42:59 -0500
Received: by bwz5 with SMTP id 5so790053bwz.13
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 04:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QHeVzLYbQ0/X8jpzcWRcvpRmMhOvyFv2UJgm2zZmI7I=;
        b=LwC7XgLsU4nGG5moXlHMbb6uxSyENL1sfiTnG5TbmzW4w5PZRv+Cp7BNTrdm4tVbuA
         4255rQwycfuGTGs4unQrx2p5L+vheM5DO1nFOL/DjzUJyTqkvEXjMa5W2+1+kdlFcYn/
         53cQj7U79jmzN5MICUNNfq4iwTeSxIVoecxww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hWFB/M1vABsG2L9mBPmFwsdeNhc0S3YewtRRqVQk9aRFO4ZeY9S/Yg5orhvoczLCI3
         EmZbHbwiqirMSlKruIQ8nXLdQ0DLgPlhVZPkEKL+Q3P0cm7HKjcgiJOhm80NSbWyldMq
         akNwRLtZ60o9Vz3pMQMTAmRq8vSZ40687K4jY=
Received: by 10.223.110.200 with SMTP id o8mr1291844fap.56.1233492177026; Sun, 
	01 Feb 2009 04:42:57 -0800 (PST)
In-Reply-To: <1233411967.8213.4.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107980>

2009/1/31 Yann Simon <yann.simon.fr@gmail.com>:
> fix a little typo
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
>  .../src/org/spearce/jgit/lib/WindowedFile.java     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> index 5eb8465..1ff8caa 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> @@ -61,7 +61,7 @@
>  * before any single byte can be accessed.
>  * </p>
>  * <p>
> - * Using a specific MapMode will avoid the complete copy by mmaping in
> the
> + * Using a specific MapMode will avoid the complete copy by mapping in

Is this actually a typo? java.nio being used to mmap() files here (see
the later use of mmap in this class), its more informative and common
to use the double m to describe that. I'd have said the typo was at
the end of the comment, ie "fast enough to permit new windows to be
mapped." should read "fast enough to permit new windows to be
mmapped."

> the
>  * operating system's file buffers, however this may cause problems if
> a large
>  * number of windows are being heavily accessed as the Java garbage
> collector
>  * may not be able to unmap old windows fast enough to permit new
> windows to be
> --
> 1.6.0.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
