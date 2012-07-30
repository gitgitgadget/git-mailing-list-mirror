From: loody <miloody@gmail.com>
Subject: git svn checkout error
Date: Mon, 30 Jul 2012 14:05:23 +0800
Message-ID: <CANudz+svPwedtWtho8xxeMajoJqsxoC0jMTZ+QhMGLk6KOv2kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 08:05:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svj6f-0000ac-7z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 08:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab2G3GFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 02:05:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64011 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab2G3GFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 02:05:23 -0400
Received: by pbbrp8 with SMTP id rp8so9279493pbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=acDJJj5eto8c+6VHeIEYzbSjUMblkIKqaeVzwVa7n4A=;
        b=L1vaUKtVji2TYkRUJoAh9TjMI/Va17SBT3SpMC0L/ZyXWAZ5bvhYARbB9j0Vd0mg3B
         /oD1Wl1GiD4ecCVl0wgSiZ79XEZDzos5mTIhaORbkN08ul3eOf0ivzmrx1QmsCiYhIjf
         aj/5kleRjwhkjgUoZBcjsPpHKJ9DML9ms0pXJD+O7uOgvDGfNbU7LiiA2CiIdXmj4yuN
         4+1pOjKrtV5tAH7khpb3UlNqmcQYodnIc0noaUagSy1yRqbgHBIE4uOOdj7Ru+2QuWka
         EFm+JZt/h7ovq+zoUBVRYG8TH/0yXovJK1k6/aGt+ReAYrBb/rPibw2c2X1Xp9lu1+HX
         xwIg==
Received: by 10.68.239.103 with SMTP id vr7mr33455625pbc.0.1343628323166; Sun,
 29 Jul 2012 23:05:23 -0700 (PDT)
Received: by 10.68.129.36 with HTTP; Sun, 29 Jul 2012 23:05:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202523>

hi all:
when I use "git svn" to checkout some repositories, it shows below error

Removing duplicate objects: 100% (256/256), done.
error: git checkout-index: unable to create symlink
linux-kernel/linux-3.0.20/arch/microblaze/boot/dts/system.dts (File
name too long)
Checking out files: 100% (42191/42191), done.
read-tree -m -u -v HEAD HEAD: command returned error: 128
$

Does that mean there is a limitation about directory depths when using
"git svn"?


-- 
Thanks for your help
