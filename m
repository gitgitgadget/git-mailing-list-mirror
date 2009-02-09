From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tool and worktree
Date: Mon, 9 Feb 2009 04:23:24 +0100
Message-ID: <2c6b72b30902081923g17779b10gc36fca528beb1976@mail.gmail.com>
References: <20090208034406.GB7230@b2j>
	 <2c6b72b30902080147u61412b04w24baa0e5fdc29584@mail.gmail.com>
	 <2c6b72b30902081717q35fd4ba0k6ff5b1be8cd5ef2c@mail.gmail.com>
	 <20090209021508.GA7599@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 04:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWMlS-0002EW-Vl
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 04:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbZBIDX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 22:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbZBIDX1
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 22:23:27 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:49036 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbZBIDX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 22:23:26 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1327848fkf.5
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 19:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=gw2JT2uyXtfqzQ1pu9ZfW3GSEMdUrGPW5/CmyqvA33U=;
        b=gNCU4sWNQAf1RVtX+iEUtfNGxXV1xo2IzVYJkqrQTqkULv+nQDCgUWUOoZ1DnQtZY2
         IIpWWzDZcavHYjcLcLoZtu+mW+HwDtRJ4W0F03HGAaveJoyz/DtM1/ozxTFabttg5ZXM
         DNsIGHldfyd4J0/+HiwkVgjX5UGJ787rVNkRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Hk/zdleQubEwi5xZOkbt/KBL8ERlnZBNNavsm44Q8qORynl/Xv43E76JXIa/KhObbU
         17SBHdanjcHC8UJUrM+rB8SiRXzxwZKO2DuvKKLnCAho4Avf7ydrJxEm+Xy4EOnd5Kyr
         e19B9yyNXlxjE36fEb8d34qHPvd6OAXIJSlmw=
Received: by 10.181.235.6 with SMTP id m6mr149581bkr.131.1234149804942; Sun, 
	08 Feb 2009 19:23:24 -0800 (PST)
In-Reply-To: <20090209021508.GA7599@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109041>

2009/2/9 bill lam <cbill.lam@gmail.com>:
> Since /etc contains both public and private files.  When browsing the
> untracked files in the status view, for files that without read
> permission, eg the shadow passwd file, the lower pane displays the
> content of the last readable file.  Could it clear the content or just
> filter and display only files with read permission for the untracked
> files?

It now closes the lower pane and displays the reason why it failed to
load the file using strerror().

-- 
Jonas Fonseca
