From: Eric Miao <eric.y.miao@gmail.com>
Subject: Support for a series of patches, i.e. patchset or changeset?
Date: Mon, 5 Nov 2012 10:26:55 +0800
Message-ID: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 03:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVCPY-00084S-RV
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 03:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab2KEC1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 21:27:19 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:38577 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2KEC1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 21:27:18 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3871442lag.19
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 18:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=jyngY+FkziIskK1hgjE0oVsq6iClD9E1VGW4aGPZNK4=;
        b=awmptU0LopqtzrBGXFm2of2M3oHbdkdrobXCvRLXbxPJ5qxe0HI2s7zk5uGxZAbHg8
         ZRHqMK6VGSJ6nMZK7+sBxA13oktMSHqW9rPqZt9Jz1IyDINgELpJ34ISy940rogusYbv
         bpTZ2A9hmBvbBoP65JG43/A/LzPeiU4UOvcU9HbDeot2KsQxOBhxsgutTFOoKmPtOHxp
         PqbBtB7xmvU6VWW+IcEFhUlzDV40X+h0XHWWTyzPzNWNA5soegXQguo+PS+ywXvGuCWo
         q12OL4EjQdbEChYWHpjb6Ba+ZfVtk7xWN9R0kFRJbo9CbhYLuRZjuA8H23tIQOTBk1vl
         ue9Q==
Received: by 10.112.29.199 with SMTP id m7mr3263396lbh.2.1352082435676; Sun,
 04 Nov 2012 18:27:15 -0800 (PST)
Received: by 10.114.75.1 with HTTP; Sun, 4 Nov 2012 18:26:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209044>

Hi All,

Does anyone know if git has sort of support for a series of patches, i.e.
a patchset or changeset? So whenever we know the SHA1 id of a single
patch/commit, we know the patchset it belongs to. This is normal when
we do big changes and split that into smaller pieces and doing only one
simple thing in a single commit.

This will be especially useful when tracking and cherry-picking changes,
i.e. monitoring on the changes of some specific files, and if a specific
patch is interesting, we may want to apply the whole changeset, not only
that specific one.

Ideas?
- eric
