From: Morten Welinder <mwelinder@gmail.com>
Subject: cg-add does not understand symlinks
Date: Wed, 11 May 2005 14:25:32 -0400
Message-ID: <118833cc050511112528a768ce@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 11 20:20:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVvnY-0006jI-5x
	for gcvg-git@gmane.org; Wed, 11 May 2005 20:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVEKSZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 14:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSZv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 14:25:51 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:13329 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbVEKSZh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 14:25:37 -0400
Received: by rproxy.gmail.com with SMTP id a41so108278rng
        for <git@vger.kernel.org>; Wed, 11 May 2005 11:25:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aKmiFhrQ579UyjuwegCIPdJXZH2kXW0M9yuk9oaWz7gZocy8MZH20JX9N2syEke/uAIsav9EO0HcBP7kKTO9MNkGkIjPKN49RiIXvxNgB2oCl85kPAvFyJxNa0wz+3OvniwMvE28HqaUqjuK+7lFXUoQtIulGw9OxK8BPqW5Hac=
Received: by 10.38.67.69 with SMTP id p69mr369466rna;
        Wed, 11 May 2005 11:25:32 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Wed, 11 May 2005 11:25:32 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>,
	"Petr \"Pasky\" Baudis" <pasky@ucw.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It looks like cg-add does not understand symlinks.

Morten


ln -s dir yyy
ls -l yyy
lrwxrwxrwx    1 welinder research        3 May 11 14:21 yyy -> dir
cg-add yyy
cg-add: yyy does not exist
