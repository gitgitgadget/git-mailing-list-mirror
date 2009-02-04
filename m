From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from the git configuration
Date: Wed, 4 Feb 2009 02:04:15 +0100
Message-ID: <200902040204.16102.robin.rosenberg.lists@dewire.com>
References: <1233695594.8042.6.camel@localhost> <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de> <20090204005907.GA23383@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 02:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUWD3-0001tf-3I
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZBDBET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 20:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbZBDBET
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 20:04:19 -0500
Received: from mail.dewire.com ([83.140.172.130]:13092 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbZBDBET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 20:04:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BD054147E7FE;
	Wed,  4 Feb 2009 02:04:17 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id exwG8PRb-43K; Wed,  4 Feb 2009 02:04:17 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 578D6147E7FA;
	Wed,  4 Feb 2009 02:04:17 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090204005907.GA23383@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108284>

onsdag 04 februari 2009 01:59:07 skrev Shawn O. Pearce:
> Hell, Java 6 added an executable flag to java.io.File.  This is
> a rather funny concept on Windows where executablity is based on
> file name and not a "mode bit", but its in the Java 6 S2SE API.
> At least even on Windows getenv makes sense and provides data.

There is an execute bit in windows ACL's. Disable it for an executables (exe, dll etc and
see for yourself). I've hit it when trying to track an eclipse installation using git and
some DLL wasn't executable after a checkout.

-- robin
