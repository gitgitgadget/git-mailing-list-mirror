From: "Sean Brown" <seanmichaelbrown@gmail.com>
Subject: move git repository out of a folder?
Date: Wed, 4 Jun 2008 16:03:57 -0400
Message-ID: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
Reply-To: seanmichaelbrown@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 22:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zE4-0002bb-4z
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbYFDUD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbYFDUD7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:03:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:11537 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbYFDUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:03:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so138472fgg.17
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=M8i5I7tnUtiC5gHCAFu4DQgxy6U3Uuy8QCeWNgXKQLw=;
        b=EmM1Yv1IOAxX2UGvQrW9JX5TjGy/1Nbl4YddChCaky8/Z7KdGK5TbZHqs3uIofBub4
         GNwmiapvQPJvm4xeT4G3wwF2ebTKDjMmgvMz6lkMjSwSOfnaAcOBoE43L30R3/MmVcdH
         iI3hBhKt8L2SrmLXM+CwSi5BMaZaxe9707/AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=j0FexLPTnRseyHB7LqRmuGDAN9pp/hp+i2CYe6SSp2l7mkvbirfwYxoYexB+oGEW2H
         62T6x60JqGkLNWZkNn4VMQKZylmbQPzLjg158ZSxiM0cfCUAzwYQQNl2eEF3cJ6W+WcT
         Yn5UAXY5fiDIvWQjsS9cWH+R1Z92Sp3w+kKiA=
Received: by 10.86.9.8 with SMTP id 8mr734121fgi.22.1212609837131;
        Wed, 04 Jun 2008 13:03:57 -0700 (PDT)
Received: by 10.86.53.12 with HTTP; Wed, 4 Jun 2008 13:03:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83818>

Let's say I've got this directory structure of source files:

/folderA
/folderA/sourcecode/
/folderA/sourcecode/file1.txt
/folderA/sourcecode/file2.txt
etc...

When putting the project under git source control, I did this:

cd /folderA
git init

So now when colleagues clone my repository, they get the source code
in the "sourcecode" folder.  I'd like to just make the repository
simply give them the source files, not in a directory.  In other
words, as if I had originally been smart and done this:

cd /folderA/sourcecode
git init

Can I make that happen without losing all of the history?

Thanks,

Sean
