From: Emily <lingyan.ren@gmail.com>
Subject: how to merge sub directory or file?
Date: Mon, 7 Nov 2011 22:54:18 +0800
Message-ID: <8B3D19E0-2181-4E9C-943F-CA26A399E0D9@gmail.com>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
Mime-Version: 1.0 (iPad Mail 8H7)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 15:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNQZX-0007fv-EL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 15:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316Ab1KGOxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 09:53:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57008 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab1KGOxI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 09:53:08 -0500
Received: by iage36 with SMTP id e36so5915510iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:references:from:content-type:x-mailer:in-reply-to
         :message-id:date:to:content-transfer-encoding:mime-version;
        bh=EHOdf1vGJ+1b4A65I/TWEPJyur+/9z1slQRMiud+sGQ=;
        b=RmTlUeJQ4ZImYDBNqE0chHp8i7dUR/1HmVx1mxfvXH5uHGwepW5pQQAzJ4txRgTcYN
         bKbjRe7Hv3d9fjKQEuKrCkQidsE9jY7rkhAp6EVoF8Xw93XNMWCstqTBTmZ7ALdLoSKO
         +oP7ulznIKklwp9yXY7D68xyHDN/1pcELfqmA=
Received: by 10.231.26.201 with SMTP id f9mr5147024ibc.40.1320677587817;
        Mon, 07 Nov 2011 06:53:07 -0800 (PST)
Received: from [192.168.11.4] ([123.118.94.188])
        by mx.google.com with ESMTPS id l28sm38507247ibc.3.2011.11.07.06.53.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 06:53:07 -0800 (PST)
X-Mailer: iPad Mail (8H7)
In-Reply-To: <20111107172652.0faade61@ashu.dyn.rarus.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184986>

Hi,

I have two git projects A and B, content of B is subset of A. For example, Project  A and B's tree are as below:

A
--- dir1
--- dir2
--- dir3
       |---file1
       |---dir4
       |---dir5
--- dir6
--- dir7

B
--- dir1
--- dir3
      |--- file1
      |--- dir4

When there's new changes in project A, how can I merge them to project B without changing B's directory structure?

Your help will be highly appreciated.

Thanks,
Emily
