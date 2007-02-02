From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: Question: next, master and pu branches
Date: Fri, 2 Feb 2007 12:54:44 +0600
Message-ID: <200702021254.44992.litvinov2004@gmail.com>
References: <200702021142.08975.litvinov2004@gmail.com> <20070202060030.GA20442@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCsK1-0000PW-Es
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423157AbXBBGyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbXBBGyy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:54:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:24450 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423157AbXBBGyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:54:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so685357uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 22:54:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jbju7ER/QIe0bUgZTwiiW1gE8BnY+CJbIwGbZDvPEdmRdBgJLgZGYcFCRSh/qyxv54wygbMI65WyxrU1w8MF2cppARr04buUF6AW7rVfbynagg1LEW9zAfNO+iKv+TMgdoeYGEocWe2OY+VHUqDDRtA3QYAHWFcDcPmfJuYxlIg=
Received: by 10.67.19.17 with SMTP id w17mr3972619ugi.1170399292696;
        Thu, 01 Feb 2007 22:54:52 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id j1sm4762041ugf.2007.02.01.22.54.51;
        Thu, 01 Feb 2007 22:54:52 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <20070202060030.GA20442@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38465>

> You can let git-rerere help you to manage conflicts which might
> reoccur during merges.  If you create the .git/rr-cache directory
> then git-commit and git-merge will automatically use git-rerere to
> help you.

Yes git-rerere is a black magic tool, but it works :-)
Byt he way, why git-pull (or possible git-merge) does not commit the merge 
result after conflict was fixed by git-rerere ?
