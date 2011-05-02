From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Mon, 2 May 2011 10:12:51 +1000
Message-ID: <BANLkTin7ozKg8E40N3Nas_TSROt4awfEAw@mail.gmail.com>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
	<7vbozmthhy.fsf@alter.siamese.dyndns.org>
	<20110501234833.GC11550@elie>
	<7v62puq8a5.fsf@alter.siamese.dyndns.org>
	<BANLkTik-8WVsw-_P7=-pEiXFLeoQQRAVeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 02:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGglE-00085H-54
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 02:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab1EBAMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 20:12:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34380 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab1EBAMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 20:12:52 -0400
Received: by vws1 with SMTP id 1so3910908vws.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=U5o8EoU4ojEOL3vbI8uIZGJ+NIXUGt6VHrwM/5drjAs=;
        b=kxV0xQRTdeSi1HyBEMOAUrVrQsNpsAHqQSukT5qEUvnBUflmjKkdbsh49XCGiBRfAS
         R2jij6hSKWI7nygHW/u9MZWCI6cGmsz1O3zAuR9CGpvPejEZzMrZeOmYGCu/v7PSFtoQ
         JTf0N0rr7DyeUP8QY9hnSKOJxghUfoABiAmuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wnDFapk9uGPxvc7sCY1D5Sx46A1fvy/wC0aMt3T2dW/680X57UftCiv/PdoQvuXhea
         WdZsmpYbpxfgayLoF8yPo2ZtLGIh0rbwGJz4lVfl4ieJYw+xcZgkhg3+yXiqnthbb8b/
         rtTF+AolnGp7RsEeyyxa1NvdkO8V2XhiGRPCU=
Received: by 10.52.180.164 with SMTP id dp4mr3279055vdc.119.1304295171368;
 Sun, 01 May 2011 17:12:51 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sun, 1 May 2011 17:12:51 -0700 (PDT)
In-Reply-To: <BANLkTik-8WVsw-_P7=-pEiXFLeoQQRAVeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172558>

On Mon, May 2, 2011 at 10:06 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Mon, May 2, 2011 at 10:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>

BTW: should it be --man-path and --info-path or --man-dir and --info-dir.

I chose --man-path to be consistent with the other options, but in
reality, I think all these options specify directories rather than
paths (e.g. lists of directories).

jon.
