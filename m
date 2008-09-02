From: "Felipe Carvalho Oliveira" <felipekde@gmail.com>
Subject: Re: Error on new installation
Date: Tue, 2 Sep 2008 11:19:35 -0300
Message-ID: <a2075f4c0809020719u40850e8bk240db2ee1499ee0@mail.gmail.com>
References: <200808310047.50560.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alan Chandler" <alan@chandlerfamily.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 02 16:20:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaWkP-0005YS-3d
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 16:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbYIBOTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 10:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYIBOTi
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 10:19:38 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:60205 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYIBOTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 10:19:38 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1043749ika.5
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UNVbAaNZWOZzbgp4JBCb87C2xsKpdSt2sRUveovUEtM=;
        b=Q5A0OvsxmVsCC+6OaK5hE1b+MShxwhLQeMnaPDspNVJZEGRQkqi9ffPY/m1B0tKJjI
         DJf+aSHF5vmOY1T/T1CXkMmdwishJRcD3zOqy+I+k4uVPbs2Ib30c028R+KNVAj63N9D
         nC29czYlbf9knLxNRB+v8br8TLD+KlRjbgOBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hpQ6JsQfYKBSZ3rAw1ZcGh7yzyTYYRxL+shBtiU7w+j2dRxqPA9kSNhnq6Q7SS438h
         Mokl7Apue5qNyK2IpZdrcOKBrYufTILFONWcWcFHru512hQ8cyB9JIf3dtBfMO9owdBA
         J7e5WVS7SQUeCNzI/lxjnaf2Wy8kIJL80IT1E=
Received: by 10.210.63.5 with SMTP id l5mr8368025eba.87.1220365175132;
        Tue, 02 Sep 2008 07:19:35 -0700 (PDT)
Received: by 10.210.46.3 with HTTP; Tue, 2 Sep 2008 07:19:35 -0700 (PDT)
In-Reply-To: <200808310047.50560.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94672>

I use sshfs (my hosting don't permits Shell Acess) to mount my "sftp" server
on my filesystem and it works welll (a litle bit slow, but works).

sshfs -o workaround=rename user@host:/home/user/  ~/web/hosting/

With this command I can just do:

cd ~/web/hosting/my_project/
git clone ~/projects/my_project
git-checkout -b production
#performs some server specific modifications
git-checkout master
git-merge production

#work offline iin my project on ~/projects/my_project/

cd ~/web/hosting/my_project/
git pull # and my project is up-to-date

fusermount -u ~/web/hosting/ # to unmount

from Brazil
                            Felipe
