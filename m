From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t3070: Disable some failing fnmatch tests
Date: Sun, 16 Dec 2012 11:31:59 +0700
Message-ID: <CACsJy8DOhZjm05KVQYaR+HbQAu=wDNR=+NZ7H_hG8P5ZsNzSKg@mail.gmail.com>
References: <50CCCD36.9020001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Dec 16 05:32:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk5uB-0007B5-VC
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 05:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab2LPEca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 23:32:30 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41573 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab2LPEca (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 23:32:30 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so4678225obb.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 20:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zn/Heb+OzYAQYcL37bKrZgX+KnOvww9dyE3JGuyNTc4=;
        b=zgDenNfCW6OLIZ4xKeonREgTIeBJ0lpzM0rKJkawYlruYAe2DWZIazgGar1EPjv6Gy
         EBux3mvyC2FJWqA+SAWsJ9QE8b4sxagYiX3Qs5+HEkuYn1t4KIBymJz1Ug27Lf+zkR8f
         bsJ03KV3D8w5bC9fNxgT5X9hmbIOfSDHQq2698PZutAm50Qg32idhVgpYJaueRkY+bcc
         kbk7G9+C1Xs66h2yS3CkI9qnG09bJvyLZ6kJAfkmuHbG6Nkrgly3tWkI6buXXtcXDJ+N
         zDrZyOle7KwnH7nReQEbu6sUZazDLKNfifZlKdyVFmqqJlJOvy8EIOFi8OwnLz8c9goN
         Y13A==
Received: by 10.182.141.103 with SMTP id rn7mr8526159obb.5.1355632349488; Sat,
 15 Dec 2012 20:32:29 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Sat, 15 Dec 2012 20:31:59 -0800 (PST)
In-Reply-To: <50CCCD36.9020001@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211579>

On Sun, Dec 16, 2012 at 2:19 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> The failing tests make use of a POSIX character class, '[:xdigit:]'
> in this case, which some versions of the fnmatch() library function
> do not support. In the spirit of commit f1cf7b79 ("t3070: disable
> unreliable fnmatch tests", 15-10-2012), we disable the fnmatch() half
> of these tests.

I have no problem with this. You're on cygwin, right?
-- 
Duy
