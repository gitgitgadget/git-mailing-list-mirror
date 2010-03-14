From: Evgeny Kalashnikov <ekalashnikov@gmail.com>
Subject: Make Problem in 1.7.0.2; install: cannot stat `po/de.msg': No such 
	file or directory
Date: Sun, 14 Mar 2010 09:34:02 -0700
Message-ID: <db6719031003140934k412a0b0ay37d072978f64ba37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 17:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqqlk-0000jt-Cb
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 17:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759487Ab0CNQeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 12:34:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45547 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759499Ab0CNQeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 12:34:03 -0400
Received: by gwb11 with SMTP id 11so542020gwb.19
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=TRfpw4eLxzzbIzuapQcF0fy4CyOrPLhF9fu34V7YIGU=;
        b=iWpdv5lXgyhgtn0N2QGC8lmQ7UCwWrgG3S+XBt70iiPOnApK7jiFWvfbCY2UIQJRS1
         QFdOz4kCThTDQBQ5Z0/WbPlNgJEPdiDTZlqeZEWKLwlEoqeX9PTrkFIgRAdpSwa0EvkR
         KgPaviQDZnngHNthlis004qI1TBNbMT59k69A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cvTp+gxJFnYy1/MrTCNMA4kdxe4qZ63jUxErIMGFbtmIMTWUJFsno1IkR5UHgi5tsp
         SuWoc5/q4s9AhYveX59jEnP4Cu11flgkNZyE3LrAb/bdRjuEKWyUkiDTydL/RXPEtaNX
         PpcI/p7kGby4dhLUgRaX3+YylSze34R6V4f0Y=
Received: by 10.101.28.7 with SMTP id f7mr5676321anj.243.1268584442729; Sun, 
	14 Mar 2010 09:34:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142146>

Cannot install git 1.7.0.2, have git v 1.6.0.4 installed with apt-get
install git

[words...]
Generating catalog po/sv.msg
tclsh po/po2msg.sh --statistics --tcl po/sv.po -l sv -d po/
install -m 755 gitk-wish '/root/bin'/gitk
install -d -m 755 '/root/share/gitk/lib/msgs'
install -m 644 po/de.msg '/root/share/gitk/lib/msgs' &&  install -m
644 po/es.msg '/root/share/gitk/lib/msgs' &&  install -m 644 po/fr.msg
'/root/share/gitk/lib/msgs' &&  install -m 644 po/hu.msg
'/root/share/gitk/lib/msgs' &&  install -m 644 po/it.msg
'/root/share/gitk/lib/msgs' &&  install -m 644 po/ja.msg
'/root/share/gitk/lib/msgs' &&  install -m 644 po/ru.msg
'/root/share/gitk/lib/msgs' &&  install -m 644 po/sv.msg
'/root/share/gitk/lib/msgs' && true
install: cannot stat `po/de.msg': No such file or directory
make[1]: *** [install] Error 1
make[1]: Leaving directory `/root/git-1.7.0.2/gitk-git'
make: *** [install] Error 2


What can be the problem ?

I am using
./configure --prefix=$HOME --without-python
make && make install
