From: Anuj Gakhar <anuj.gakhar@gmail.com>
Subject: Git Architecture Question
Date: Tue, 28 Dec 2010 16:54:30 +0000
Message-ID: <20FFFEFA-5808-4673-B876-C5F76B52D12E@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 17:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXcoo-0005ML-OG
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 17:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0L1Qye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 11:54:34 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52790 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0L1Qyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 11:54:33 -0500
Received: by wwa36 with SMTP id 36so9983839wwa.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=UnEA5ixc3Ga43dnx9vqfdVt3SfPlp/EtOA5M4I8CBlk=;
        b=faOBtz44PHbFOCr9zTzSIJV47QUOegFSO7tnuy8RJTOS8X2+uq7A/UwMdvtkcm8tJ7
         mH/49ghqr6dO9uPys+leftiKTUPcwTLr9AF16gWpB/nORipOzCwvQIcwnLUN/x0Cprf0
         fOdjehjc9no/fnCixe+WxY2MraZCPYcyMvhcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=hPlzS7Z6XiprdoLVFRojML1rsSNRj/I6R713Yd0TTouwhTDmJEtmLgoobzuSEVlz7m
         bupB4yscQtGPTjhIV/C3zTwtV6IAZ8HMkIh5xF47nMK9ZJvkBAKcMVr9eGBKbiULQzKT
         jsqc1fzwVUBvnu1bcLcXqHQlFuT08cflH37bs=
Received: by 10.227.199.5 with SMTP id eq5mr2886135wbb.219.1293555272104;
        Tue, 28 Dec 2010 08:54:32 -0800 (PST)
Received: from [192.168.0.7] (5ad96a4e.bb.sky.com [90.217.106.78])
        by mx.google.com with ESMTPS id 11sm9427458wbj.19.2010.12.28.08.54.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 08:54:31 -0800 (PST)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164275>

Hi all,

I am new to Git and learning this powerful tool these days.

I have a simple question :-

I work on a project that has 3 different environments. dev, staging  
and production. dev is obviously the local git repo that all dev's  
work on. staging is where most of the development takes places on a  
daily basis. and production is where least development happens but we  
still do it because sometimes we have to fix things quickly directly  
on the production server.

So how should I set this up ?

2 branches staging and master (default) ?

How can I make it so that the staging branch gets deployed to a  
different folder on the server and the master branch gets deployed on  
a different folder ?

Once a week, we would merge all the staging work into production and  
make a release.

Any ideas ?


Anuj Gakhar
www.anujgakhar.com
www.anshconsulting.co.uk
