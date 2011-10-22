From: John Hsing <tsyj2007@gmail.com>
Subject: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sat, 22 Oct 2011 08:20:43 +0800
Message-ID: <4EA20C5B.3090808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 02:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHPPU-0005ai-U0
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 02:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1JVAUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 20:20:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58739 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1JVAUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 20:20:48 -0400
Received: by iaek3 with SMTP id k3so5306479iae.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 17:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=5GTuYgSKnIuw3Nj2aY6UVeQHmlsHz563JxGAzmS6ySA=;
        b=YsJ+Httge+dOQLIsL9YHwBfJDDJB+qfrZ3qVJMBrauCK+zschoR/95HQ5dKuEZNAbG
         azSV8n6Td7Vk6CGEGRF0UZcS21KhneJOUSn2ZmQL0FsX1sv3J1BxQOdxZogYhS5FVIxn
         xmNOaVvPwJMrdYu5BuBsNrC7x9qL6Cn+smmns=
Received: by 10.42.158.3 with SMTP id f3mr27658296icx.7.1319242847750;
        Fri, 21 Oct 2011 17:20:47 -0700 (PDT)
Received: from [10.13.153.83] ([112.2.255.84])
        by mx.google.com with ESMTPS id e2sm37400631ibe.0.2011.10.21.17.20.45
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 17:20:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110930 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184094>

the error:
git: malloc.c:3096: sYSMALLOc: Assertion `(old_top == (((mbinptr)
(((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struct
malloc_chunk, fd)))) && old_size == 0) || ((unsigned long) (old_size) >=
(unsigned long)((((__builtin_offsetof (struct malloc_chunk,
fd_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t))) -
1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end & pagemask)
== 0)' failed.
