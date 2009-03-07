From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Sat, 7 Mar 2009 11:38:14 +0100
Message-ID: <200903071138.14683.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfuFy-0000Of-N5
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 11:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbZCGK6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 05:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbZCGK6V
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 05:58:21 -0500
Received: from mail.dewire.com ([83.140.172.130]:23481 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbZCGK6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 05:58:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C315515E0DF1;
	Sat,  7 Mar 2009 11:58:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nk4Pwap8utAP; Sat,  7 Mar 2009 11:58:14 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 265628026EF;
	Sat,  7 Mar 2009 11:58:14 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112524>


Slightly related; A new cygwin (not msysgit-related) version with UTF-8 support was announced. Most notably:

- New setlocale implementation allows to specify POSIX locale strings.
  You can now use, for instance in bash, `export LC_ALL=en_US.UTF-8'.
  The language and territory will be ignored for now, the charset
  will be used by multibyte-releated functions.

- UTF-8 filenames are supported now. 

- Support UTF-8 in console window.

This certainly makes it more feasable to interoperate with *nix repos that has non-ascii metadata and file names.

-- robin
