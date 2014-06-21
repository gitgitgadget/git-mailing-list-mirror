From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: gitk does not respect UI fonts
Date: Sat, 21 Jun 2014 15:32:00 +0200
Message-ID: <53A58950.1000602@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jun 21 15:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyLP2-0007YK-36
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jun 2014 15:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbaFUNcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2014 09:32:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:49644 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbaFUNcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2014 09:32:15 -0400
Received: from [192.168.1.19] ([95.222.188.187]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M8MyE-1Wle6F0f0k-00vxES; Sat, 21 Jun 2014 15:32:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
X-Provags-ID: V03:K0:CrJ3XUhGT86y673tzloiALTg7twcMf4L8k0/Fibdfw3YUFPrOvx
 2o3NVcspfEUhvpJwoamnXjfDJlSOMoWhFNxh2tL9tSMue7ZT07d5+10+IxYhlFhbePH7jCM
 X8xfXApkyIQnBHhjtzNDY0f5AoAJ8aAcaKoS9NhJOuHTr6+6VUo58JNSpVqpLC5NvkAwPAB
 zYm4PURjG0tetJBL6TLHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252301>

In gitk three UI fonts may be specified. These used for some GUI 
elements but not for all.
Radioboxes for instance do not use any of the 3 fonts that can be specified.
An example is provided here:
http://i58.tinypic.com/11kwpp0.png

Please, change the coding to always use the specified fonts.
