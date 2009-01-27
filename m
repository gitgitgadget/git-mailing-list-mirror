From: PJ Hyett <pjhyett@gmail.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 15:10:06 -0800
Message-ID: <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 00:11:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRx5j-0006ri-0G
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbZA0XKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbZA0XKJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:10:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:63646 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZA0XKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:10:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6639009rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CQmVHoJiED8FMJnX8RhSqHxl62P8zV6KvFFSyVSBj/s=;
        b=juG/BogYJ77S/1LaNW41WbAmc/fMs5u4/9/aJUA4Y92UNwv5HXb1zEu/0+CQxqIqeS
         ZySTf/t5z+U7kroajUxntIimNXxW+D8+xWOi8NxSrWD55Y4awjlFvgku2Ghg4hQwF+Ja
         +kKJuDO6l8h6QN+V2twoNyxxxwFhrqSbIDt68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=QjJV3iGnmZLMpFW4qB8C4BB0BWvxdfEqvRKuQE7yYXlhE+qmCKN5Fy1iUPe8mKcCS/
         a5HZTlqClUz+bxtbVpgvjRP+ZgjNT+5WhELb41olZAIKjJfCFJu3PPZfY4cevD25yM8h
         e6GMbX2A1mP14mSZ/Vqrdn1dLNJUo4EaMgoec=
Received: by 10.141.28.4 with SMTP id f4mr568055rvj.37.1233097806615; Tue, 27 
	Jan 2009 15:10:06 -0800 (PST)
In-Reply-To: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107421>

To expand further, here's the output from the command line when this happened.

~/Development/github(jetty)$ git push pjhyett jetty
fatal: bad object e13a86261c6e710af8fd4b5fb093b28b8583d820
error: pack-objects died with strange error
error: failed to push some refs to 'git@github.com:pjhyett/github.git'

~/Development/github(jetty)$ git fsck --full
warning in tree 0d640d99b492b0c7db034e92d0460a7f84b22356: contains
zero-padded file modes
warning in tree 56fe2a1a3da446606aadf8861feccd592b636a34: contains
zero-padded file modes
warning in tree 99e2a89db2aa9846fc2491b3e4ccd8861e8d3283: contains
zero-padded file modes
warning in tree a6e532d7451bc4aadab86ade84df69180fab4765: contains
zero-padded file modes
dangling blob 43611213c3eff91e5fe071cf2907f69a99b630b2
dangling commit b28b3ecd85a04ecbd1dcb8aedc6886a465f6ab18
dangling commit 13a70c8687527936d2c375f0f7aefe71142de3c7
dangling commit 2aa94c1199cb332f58b70c6ce19d8de3c45c6f3c
dangling blob 61b910e7a97600691fd279e4db3662e751fb5fb7
dangling commit c4f19e16208d59666323ae0575435720be9b865d
dangling commit 19245f5d77aa449eebb4a0521b5ff4f6ce1865ab
dangling commit 122995fb7c9a7e459b0801e0647eb918bea878bf
dangling commit 7d51e3926b8720d1c7cad19aeb35d6ab4af755fd
dangling commit 1162dd21370439416967a34915832125e4975239
dangling blob 8c630b66927f6022a72e457be308de5c9ad9f4e6
dangling blob 827d4d8855fe6a3a7856ea35cd641192140f2dcd
dangling commit c9824506855d6cad9b52df115aa267d70872c2cc
dangling blob fb9bbfc3aa17c5d1ae4e15c862bd874e3476fcfc
dangling commit 46a4b39245a58ad867010f272991d6233db6288b
dangling commit d6bf5f30853fecea745559dc3a718113f3619634
dangling blob d4d66fc4c3a2cbc94d8ed9cb30a6b56daa86e58f
dangling commit b4f8d7766e8905e5ac6d6cfeeaf7370a716c24a2

Very odd that the bad object didn't appear in the fsck output.

I was able to fix the error by copying a non-corrupted version of the
object back into .git/objects and then running a git fetch.

-PJ
