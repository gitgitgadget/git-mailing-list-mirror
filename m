From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: git-gui Error
Date: Tue, 13 Feb 2007 07:56:16 +0100
Message-ID: <20070213065616.GA4195@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 08:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGs7Z-00088g-Og
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 08:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXBMHae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Feb 2007 02:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbXBMHae
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 02:30:34 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:44136 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbXBMHae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 02:30:34 -0500
X-Greylist: delayed 2055 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Feb 2007 02:30:34 EST
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id EE3986868ED3
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 07:56:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qcTj4P6z-qny for <git@vger.kernel.org>;
	Tue, 13 Feb 2007 07:56:16 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B52626800A19; Tue, 13 Feb 2007 07:56:16 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39501>

Starting git-gui without any parameters display an error message instea=
d
of a usage message:

Error in startup script: child process exited abnormally
    while executing
"close $fd"
    (procedure "load_all_heads" line 11)
    invoked from within
"load_all_heads"
    invoked from within
"if {[is_enabled transport]} {
        load_all_remotes
        load_all_heads

        populate_branch_menu
        populate_fetch_menu
        populate_push_menu
}"

mfg Martin K=F6gler
