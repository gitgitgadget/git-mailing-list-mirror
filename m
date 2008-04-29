From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: cvsimport and branches with "(" in the name
Date: Tue, 29 Apr 2008 08:22:02 +0100
Message-ID: <320075ff0804290022r56c9f4efx74a13d3502be212@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:23:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqkAv-0001L0-GG
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbYD2HWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYD2HWF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:22:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbYD2HWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:22:04 -0400
Received: by fg-out-1718.google.com with SMTP id l27so5118201fgb.17
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ARu3E+LWZXKpUYA4CJOyqP/p4eUk57f08gT5PVTVeWw=;
        b=rnTYLo467Hh4xJo+RRopKGTCK1owD6wJHLP7BKvZNFtBzPqqjElP05+lRtk+JNSp/o2F5iKA6OFkhp7FU0efPTIJ1B6acgGz2oA/gUTk8ZXqCPjfvA+rjF23LekxPdbuhvB4UOkkoYKYNhaCCotCSPjq3TBFlIeWmc1z6UXoUZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hrnyFznIgFcagz5aucfxx3zLKzd0rYgK7/LZtKtK7ymBZCHkRRPhV9zIZ7kz4SBdGIxDdSA5Az23gUrZ0Imdn/u6V+tuJtqALhoTt6V36FblQM+8v3i3hExuC3MmtRnS4/p92QZb3zTGcnfDiFBGP0yetQK/7D2k2bzuz+8n/kY=
Received: by 10.82.159.2 with SMTP id h2mr3808325bue.25.1209453722768;
        Tue, 29 Apr 2008 00:22:02 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Tue, 29 Apr 2008 00:22:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80665>

git 1.5.4.4 on ubuntu, I cvsimport a repository that has an oddly
named branch - I get

sh: Syntax error: "(" unexpected
Cannot write branch ChapelHill_3_0(iteration2)_esap_demo for update:
Bad file descriptor

though the end of my -v log shows

Tree ID 46f13621661205b02a80d7d431a2c59be500ae45
Parent ID d635ccf06e1cac3afacc4fba6e70bba7f771ead2
Committed patch 1956 (ChapelHill_3_0(iteration2)_esap_demo +0000
2006-12-04 10:28:31)
Commit ID 76c991af0c690d9ae5471c0b661dfba3b3df18c6

and refs/heads has a correctly named file

My guess is something in the guts isn't liking the ( character, when
committing the next patch.

Any ideas on how to diagnose / fix it further ?
