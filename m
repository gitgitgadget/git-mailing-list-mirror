From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.1
Date: Sat, 11 Oct 2008 20:46:12 +0200
Message-ID: <8c5c35580810111146l691573e9na58275515c33ff7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 20:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KojV2-0004AZ-L3
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 20:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbYJKSqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 14:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbYJKSqV
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 14:46:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:30089 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYJKSqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 14:46:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so518685wah.21
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=bv1C8JlBgGzi59/4G9x3VcHxEdxBFZGctuFmYSTyRLo=;
        b=pz7JK3t8kndTJWK6mYrrxn7AROu+9Xt6S0p729Z31s/NDkuArWI05HWcnkjCg5a2z/
         F/Zdf6p+BF3f1ka5aMBfw4HXpFIo2eonCss41sowO0ijHvL/kGE9aQGeqVvpSyHsKCY1
         7keOsXTTZaAuaE+tH+W1aLdS9J9BMwvwtNK7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=f4GRb4jOjcWa+WPemURtq5dY2SNXXV47pTJc8McYF6m/rAJukx3SAI3rb772q/yWpF
         LR1nZZL6gORfqtnBFDJXtTrHD3w9Wm1H71J0LBX5xAj4Caw24QHkBK1z1pckwbbjYUkp
         ut1kKSo5JNd5xKUG+SryxYJYWz2EIjIWVCgiw=
Received: by 10.115.76.1 with SMTP id d1mr3389672wal.207.1223750772867;
        Sat, 11 Oct 2008 11:46:12 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Sat, 11 Oct 2008 11:46:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97985>

cgit-0.8.1, another webinterface for git, is now available.

clone:   git://hjemli.net/pub/git/cgit
browse:  http://hjemli.net/git/cgit

This is a minor feature-release which adds support for extracting
snapshot revision (i.e. tag name) from the snapshot name instead of
relying on querystring parameters, i.e. the following urls will
download the expected revisons:
  http://hjemli.net/git/cgit/snapshot/cgit-0.8.1.tar.gz
  http://hjemli.net/git/cgit/snapshot/cgit-0.8.tar.gz

---
Shortlog since v0.8:

Lars Hjemli (5):
      ui-shared: specify correct css class for summary tab
      Add cgit_query.nohead flag
      ui-snapshot: add dwimmery
      Makefile: enable compilation on uclibc
      CGIT 0.8.1
