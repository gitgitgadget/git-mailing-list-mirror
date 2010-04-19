From: Yves Caniou <yves.caniou@ens-lyon.fr>
Subject: Compilation pb of git-1.7.0.5
Date: Mon, 19 Apr 2010 07:59:14 +0200
Organization: ENS-LIP
Message-ID: <201004190759.15032.yves.caniou@ens-lyon.fr>
Reply-To: yves.caniou@ens-lyon.fr
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 08:08:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3kA9-0000c1-9k
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 08:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab0DSGIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 02:08:45 -0400
Received: from jabiru.ens-lyon.fr ([140.77.51.2]:52118 "EHLO
	jabiru.ens-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab0DSGIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 02:08:44 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2010 02:08:44 EDT
Received: from localhost (localhost [127.0.0.1])
	by jabiru.ens-lyon.fr (Postfix) with ESMTP id 7B2A5AFA9E
	for <git@vger.kernel.org>; Mon, 19 Apr 2010 08:01:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.1 (20080629) (Debian) at ens-lyon.fr
Received: from jabiru.ens-lyon.fr ([127.0.0.1])
	by localhost (jabiru.ens-lyon.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZY5aktjhTDK9 for <git@vger.kernel.org>;
	Mon, 19 Apr 2010 08:01:22 +0200 (CEST)
Received: from [133.11.204.119] (unknown [133.11.204.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by jabiru.ens-lyon.fr (Postfix) with ESMTPSA id 46776AFA88
	for <git@vger.kernel.org>; Mon, 19 Apr 2010 08:01:22 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145264>

Dear all,

I tried to install git on a Quad-Core AMD Opteron(tm) Processor 8356, with the 
version 4.1.2 of gcc (Red Hat 4.1.2-14).

After the ./configure --prefix=$HOME/git, the make all gives me

- some warnings like
"fast-import.c: 2622: Warning: 2570, Value assigned to enumeration 
object "type" is different type."

- some errors like
"archive.c: 223: Serious: 4470, Initialization value must be address constant 
expression."
This error appears also on lines 309, 311, etc.

Thank you for any help.

.Yves.
