From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Re: [PATCH] remove ARM and Mozilla SHA1 implementations
Date: Mon, 24 Aug 2009 13:42:08 +0200
Message-ID: <a1b6cb1b0908240442t676a13a2ma706c489e3c06860@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nico@cam.org
X-From: git-owner@vger.kernel.org Mon Aug 24 13:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfXwH-0002UI-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 13:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbZHXLmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbZHXLmI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 07:42:08 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:63273 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbZHXLmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 07:42:08 -0400
Received: by ewy3 with SMTP id 3so2281015ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CFghk+geRZAPDuekkR0UgevQcXK1xiUjhYn5wuBz+Fw=;
        b=ETvVaPA91jTkWVXCDi9HcGh1H+M7LyjqFaJKuVRheeS1Lf8sy00oshZF4o6gvHvm1Z
         1JqFaUpbyJEzpFKMik/sSXplyzK3BLm7jfcsGZvP9rG968EyUyEiX9TGw0xoG5rRc1jC
         tEnRVAtuN6mikng+T+jXMwOtWSGLImzg6c+M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=foiDO7ba5jGazu4UvTwI1nrWIYxgwrUxGB25mff/BPeph6NC+5CpeGdM94NXOcnAsz
         wmhNUObFt8Zg4Am8RW0Vo/AQ49zfUIvmbAxwnQAEDgxqdCnEFAcqKQGEP3O1rkDa6OPy
         ltnniS8rw9+dDlpqR2XIcXu6GVBAJXNb+w4zE=
Received: by 10.216.46.83 with SMTP id q61mr976953web.71.1251114128921; Mon, 
	24 Aug 2009 04:42:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126918>

block-sha1/sha1.{ch} simply say this:

/*
 * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.c),
 * optimized to do word accesses rather than byte accesses,
 * and to avoid unnecessary copies into the context array.
 */

This means that if mozilla-sha1 is removed, we need to copy the
license information back to block-sha1.

Ulrik
