From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: git clone questions relating to cpio
Date: Mon, 1 Oct 2007 20:28:38 +0100
Message-ID: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 21:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcQx7-0003kN-Qk
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 21:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbXJAT2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 15:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbXJAT2k
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 15:28:40 -0400
Received: from el-out-1112.google.com ([209.85.162.179]:52227 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbXJAT2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 15:28:40 -0400
Received: by el-out-1112.google.com with SMTP id v27so806701ele
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=m6VNe2mkrn4Udkf30E5zR9GCrA0OPHJEYjzqbgBKzvw=;
        b=H5A+cUuoXyBoDA1pG5DyKyQdIfOJ6jZvPLc4cZQXj5zRZqOenOqfg57/FOvaNgkULkxNljspDU5Bd3lj9lbQd9wuJD8Nin0UPGjZLtMGAByHPtrX2YGdh5sm0ylZ9Eb05MxQjmrLs81mIUKHzm8E+XMtoNJHA/DfyEIDsGbKVQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PXI8Sw9PffZD4DZgDcOIlJHM0YaF0xWVA7yGVWheQI2k8lTsy1cqDKSLWZdO9a7dQ5tevrGNs4j3XomW6HkhVhzM4Lw0E9NWCtst+jfC6O6ESmGFLR9Cv+67Gl+RNasLuPJqRLvBKKNkyMcsPQLYtlOv9J0mlLYfaNHg/SVWID8=
Received: by 10.114.196.1 with SMTP id t1mr1024124waf.1191266918053;
        Mon, 01 Oct 2007 12:28:38 -0700 (PDT)
Received: by 10.141.23.10 with HTTP; Mon, 1 Oct 2007 12:28:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59631>

Hi,

I am running a Linux From Scratch 6.2 system that does not have cpio
installed on it. This means that I can't clone a local repository
unless I install cpio. Is it possible to use a fallback method if cpio
is not present, as there is no NO_CPIO option on make like there is
for OpenSSH, cURL and expat?

Also, I have an external USB hardrive that is mounted onto the virtual
filesystem. Will clones from the USB harddrive (or a USB flash drive
that is mounted) result in a copy being performed, not a hardlink?

Ideally, the hard linking for local clones should be optional. What if
I want to move a repository because, for example, I have imported a
CVS repository and now want to push it to a new bare repository?

- Reece
