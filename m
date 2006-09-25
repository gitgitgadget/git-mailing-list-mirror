From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: fsck objects and timestamp ordering
Date: Mon, 25 Sep 2006 12:32:47 -0400
Message-ID: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 25 18:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRtO4-00032t-Sz
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 18:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWIYQct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 12:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWIYQct
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 12:32:49 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:28524 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751247AbWIYQcs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 12:32:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so2596378pyg
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 09:32:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kA0bYus6z2oU/4Vm2sdFc9/QrOY5DhnnUVwvP7Ysq/LngKqBis6mk7TAUndZaGXTKTyPgGhWmPNPHnWR93b5ZPpn97qbwZjQga9h60X8nylndovZGierMn9T3iJx/NhzEt4y6WMn8sxo2s+ZNnfOUswe2M1AlX9akx2u2JJqFRI=
Received: by 10.35.18.3 with SMTP id v3mr8651650pyi;
        Mon, 25 Sep 2006 09:32:47 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Mon, 25 Sep 2006 09:32:47 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27741>

When running fsck objects, does it verify that timestamps are ordered
in the same order as the dependency chains?

I am having trouble with a CVS repository where the timestamp ordering
and dependency order are in conflict. It would be best if git didn't
experience the same problem.

-- 
Jon Smirl
jonsmirl@gmail.com
