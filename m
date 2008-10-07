From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: git-who
Date: Tue, 7 Oct 2008 17:02:46 -0400
Message-ID: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 23:04:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnJit-0000N7-IU
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 23:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYJGVCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYJGVCu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:02:50 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:59417 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbYJGVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:02:49 -0400
Received: by qw-out-2122.google.com with SMTP id 3so821851qwe.37
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=H56pVf37DnzHdmKwtecwg49iBbnfxZ9EcIQchkxW8Cw=;
        b=mCsgYhk5lyFGZrUunyBLxzPEr7/vNUYGD3uByDWDspA7wI5+PtZsUQvNkUVV7D/Lyi
         XhfzOGFtjwgqJ2qwPW/CvQIUUd8yfntFM9RdFDtUlbfykUj1YJE6e04Wcf18nCSzqRX/
         L+2ZBVg98BGBadyvQghmFDFGuBJyd8A22dOds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=SPXSedp6bVr5jeKIDu6NuNuZqqnWnTPCXOAxdXbAF7RczB3OE3wc+IdpFw33WR5EUL
         ThMLiK3RQ10OiSo952UkYbyQdNBYwEBlgbelT5j10i5dLsieaXlKYO7jcGlNbj1TF3DH
         IW1J1QgxnlzL7uSJqukQAcE4UpwzpnJp9xh6k=
Received: by 10.214.10.4 with SMTP id 4mr8840891qaj.60.1223413368735;
        Tue, 07 Oct 2008 14:02:48 -0700 (PDT)
Received: from ?172.30.14.217? (fw01.cmbrmaks.akamai.com [80.67.64.10])
        by mx.google.com with ESMTPS id 8sm8288839ywg.6.2008.10.07.14.02.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Oct 2008 14:02:48 -0700 (PDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97744>

Once upon a someone asked about seeing who had touched some files.  
Petr Baudis responded with a quickie script that did the job. I've  
since expanded upon it a little, and since I find it pretty useful, I  
figured I'd send it back for others to use too.

As is it's probably not worth including in git, but I'm thinking that  
someone else can probably come up with some improvements, such as  
dates in the verbose mode, support for a treeish instead of a single  
file path, and / or rewriting it in C so that it can work on Windows.

http://github.com/masukomi/git_accessories/tree/master
git://github.com/masukomi/git_accessories.git

Not that it's particularly worthy of it's own repo at the moment, but  
I figure I'll continue to keep poking it from time to time...

-masukomi
