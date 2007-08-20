From: "jungseung lee" <lkml.js@gmail.com>
Subject: gitstat 0.1: kernel development statistics / monitoring system
Date: Mon, 20 Aug 2007 09:57:10 +0900
Message-ID: <82ab508a0708191757q5da6ac96g8f8992c6123ab557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 02:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMva3-0000PO-Ij
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 02:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbXHTA5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Aug 2007 20:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbXHTA5P
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 20:57:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:20214 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbXHTA5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 20:57:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so532546nfb
        for <git@vger.kernel.org>; Sun, 19 Aug 2007 17:57:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a9G9IM4jeo/ZHze7aWcg90rPP+eI13cHtfzxHYMbx3oHagU03OWFEZDNv7EvLpvaN+cSJ3b+94LTFGUGvU0pZfnDH6BFoKfvaxFiUaXvDEm/Chx/qyVZgcduLQgH+HtDqYwG8w1167VWJ3OcCBnyVaFxFFT5byO3G+iQMOSP9jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mdxyn8eddS5rOhYohjdxdSdPertqyoCp7qkcSzYbxQIwRDzFq4+ELpA/SotYFUdTxyetF9011TldbJFslwS+nU3l9lIgO0p/zMY+Ev84XT8e+pa/3p3xBmRmsYe6/eBoiGwHpbHBrFrgOW2puVqKflvedjGU5Xi6Zbdi9pHq7Ls=
Received: by 10.78.183.15 with SMTP id g15mr1655617huf.1187571430834;
        Sun, 19 Aug 2007 17:57:10 -0700 (PDT)
Received: by 10.78.120.19 with HTTP; Sun, 19 Aug 2007 17:57:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56161>

We are pleased to announce the release of gitstat 0.1.

Gitstat is a GPL'd, web-based git statistics/monitoring system.

It retrieves a specified git tree, analyzes changesets,
and shows graphical information like the number of changesets per day, =
the
number of people who submitted changesets for a specific version(tag)=85=
etc.

Users may subscribe to gitstat so that they automatically receive
an email notification if any change is applied to a specified
directory. Currently, gitstat is mainly for linux kernel developers
to monitor kernel development more conveniently with email notification=
s.

It also shows each changset that users can search
through with a specified title, content or developer.

Gitstat was originally developed for internal use with minimal function=
alities
and therefore has much room for improvement. We hope more people
join us to make this system a better one.

gitstat was derived from kfm(kernel feature monitor) which
was originally developed by Keun-Sik Lim and Sang-Bae Lee of
Samsung Electronics and currently maintained and developed by
Jeong-Seung Lee and Soon-Son Kwon(Shawn) of Samsung Electronics.

kfm was inspired from Jon Corbet of lwn.net when he analyzed the
git tree and Greg KH when he presented similar status report at OLS2007=
=2E
We thought it would be interesting those information every day.

You are welcome to try gitstat at http://tree.celinuxforum.org/gitstat

=46or any suggestion, bug report, or patches, please visit
http://sourceforge.net/projects/gitstat

The developers would like to thank Samsung for sponsoring the
work and CE Linux Forum for providing the hosting space
