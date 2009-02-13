From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Unexpected local changes immediately after fresh clone
Date: Fri, 13 Feb 2009 00:41:20 -0500
Message-ID: <76718490902122141h578a72e3k70366d6583d6c8c3@mail.gmail.com>
References: <3D94CDCE-88EB-479A-9D36-6B92FCFCBAF4@hoskings.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ben Hoskings <ben@hoskings.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 06:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXqp8-0004S6-ET
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 06:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbZBMFlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 00:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbZBMFlW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 00:41:22 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:29551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZBMFlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 00:41:21 -0500
Received: by rv-out-0506.google.com with SMTP id g37so569805rvb.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 21:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0NtkgBI8PjdtcZPRK9NtclStgOVGQlwqFY/AN1Bkb9g=;
        b=m3YEID2RqzwyErUOJWBWVt7MoD8jO+P3My4wik+dBVt3MIb3b3zgbl0s4WigxUNrsr
         pDtEo6/u+snJsPRlCeU1moLgymHPQxHn7t6fzfHv6p4bVGPvIFVfo+n3GtjTL2XqvB4i
         dPBw6X04iMyDHtIGpZKnyzQh8qD+Lmdro0gGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vVAEJlyQshaRsW8C5tiRhQR9NyijlfT3zZnvVlSfVx4I2tRQ4cbQm3ae1UDm6jETGn
         ydHmwo4h9W/lTyo2eIryTQQWCaIF1Om4fg9iabOfQ1p1If3ZswsCNTEDbwo3Bb6A5dVE
         jGYvd6GRKzASD5HkllLSp4caj3ydLm5hgB3R8=
Received: by 10.140.157.4 with SMTP id f4mr130903rve.3.1234503680422; Thu, 12 
	Feb 2009 21:41:20 -0800 (PST)
In-Reply-To: <3D94CDCE-88EB-479A-9D36-6B92FCFCBAF4@hoskings.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109707>

On Thu, Feb 12, 2009 at 11:08 PM, Ben Hoskings <ben@hoskings.net> wrote:
> My system is a Mac OS X 10.5.6 box (aluminium MacBook); some details are
> below.

HFS+ is case-insensitive by default. The Linux kernel has files which
collide on a case-insensitive filesystem, which is what you're seeing.

Create a disk image using Disk Utility, you can use "Mac OS Extended
(Case-sensitive)". Check-out the repo to the disk-image.

j.
