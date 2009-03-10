From: Mike Swanson <mikeonthecomputer@gmail.com>
Subject: Remove leading/trailing whitespace from commit messages when importing
 from Subversion?
Date: Mon, 09 Mar 2009 20:14:09 -0700
Message-ID: <49B5DB01.8080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 04:15:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgsRX-0002aH-A2
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 04:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbZCJDON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 23:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbZCJDON
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 23:14:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:14657 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZCJDOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 23:14:12 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1983732rvb.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=xGjR8yZBszk+4qIVpTSvkauVxlOeIBWK1bj7XaJHHzs=;
        b=hv8Jc5SpmoO2ZPPr6j2VyoL0/H3/nn7EenUZa+GnAyFZiILQEC0xgVnJrQ7W4Onzip
         kbwRO2GaDOwQaxDc8pxFiRP07EEGkTlD+N2IUd/k6cLjuArclMYgaFuyTPfZeuJTCCZe
         QFxd+hh8x7XhbepC5tL4wbgh8AmV7pvPbCjFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=XGZH7JEytj6DLeK1x9gu9qr+7j0lq2SMj7QW+DnVrx8YdrrIBr6oy4xEWe4I2nh/qV
         MmTrgQ4RPxGaypyaCRAn/Sr9y6i6J5c273UddcZZe/HTVPcmSgV/phaT4DyBMUDLDEpD
         4NQv4/moLFlRNlcbwlbnSVrPOuf9IYoyq4q+g=
Received: by 10.114.180.1 with SMTP id c1mr3941779waf.206.1236654850302;
        Mon, 09 Mar 2009 20:14:10 -0700 (PDT)
Received: from ?192.168.1.2? (c-76-28-231-90.hsd1.wa.comcast.net [76.28.231.90])
        by mx.google.com with ESMTPS id n20sm13919699pof.17.2009.03.09.20.14.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Mar 2009 20:14:09 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112777>

I was wondering if it's possible to removing leading and trailing
whitespace (tabs, newlines, spaces) from commit messages when importing
from Subversion via git-svn.

I've got a repository with tens of thousands of commits, and not all of
the messages are entered... sanely.  I need to know whether it is
possible to clean these up when transfering the repository to Git.


Thanks.
