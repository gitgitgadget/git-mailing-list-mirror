From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git-gui translators: gitgui-0.10.0 coming soon
Date: Fri, 14 Mar 2008 09:38:09 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0803140936130.25570@ds9.cixit.se>
References: <20080313052713.GU8410@spearce.org>
 <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se>
 <20080314063817.GW8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 09:39:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja5RO-0001zN-UQ
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 09:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYCNIiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 04:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYCNIiY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 04:38:24 -0400
Received: from ds9.cixit.se ([193.15.169.228]:59059 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbYCNIiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 04:38:23 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2E8c9wE032588
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Mar 2008 09:38:09 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2E8c9Dl032583;
	Fri, 14 Mar 2008 09:38:09 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080314063817.GW8410@spearce.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 14 Mar 2008 09:38:09 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77192>

Shawn O. Pearce:

> Squashed.

Faster than lightning :-)

Quick sanity check, is "Apple" really supposed to be translated here:

  #: git-gui.sh:2092 lib/choose_repository.tcl:41
  msgid "Apple"
  msgstr ""

In git-gui.sh:

 .mbar add cascade -label [mc Apple] -menu .mbar.apple

in choose_repository.tcl:

  $w.mbar add cascade -label [mc Apple] -menu .mbar.apple

Since the menu title is the Apple symbol, should it really have a
translatable label?

-- 
\\// Peter - http://www.softwolves.pp.se/
