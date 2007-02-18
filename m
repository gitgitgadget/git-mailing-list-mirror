From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: git-fast-export ?
Date: Sun, 18 Feb 2007 13:45:31 +0100
Message-ID: <45D84A6B.3060402@xs4all.nl>
References: <eqoaf7$loq$1@sea.gmane.org> <20070212011401.GK31488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 13:45:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIlQ4-0005zE-JK
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 13:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbXBRMp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 07:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbXBRMp3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 07:45:29 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4043 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbXBRMp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 07:45:28 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l1ICjJTb045311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 18 Feb 2007 13:45:24 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <20070212011401.GK31488@spearce.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40075>

Shawn O. Pearce escreveu:
>> Regarding GFI, it's a breeze to work with; my compliments to its
>> author.
> 
> Hey, thanks!  ;-)

BTW, I just had a brainwave

Wouldn't it make sense to build a git-fast-export, which 
can be used to interrogate a git-repository: a GIT tool 
could run a single git command, 

  git-fast-export

and communicate with that process in a similar fashion, eg.

  object-type SP 0ac9f9cb54e7cf400453b85a3ae5f63813f5fdae LF

=>

  show-raw SP 0ac9f9cb54e7cf400453b85a3ae5f63813f5fdae LF
=>
  data SP 235 LF 
tree 76c9d63f83530851d911f6ead36e3899929e0cda
parent e3559e3c52cf006a6b3b03ec083ed658ba1941ee
author Han-Wen Nienhuys <hanwen@lilypond.org> 1171799942 +0100
committer Han-Wen Nienhuys <hanwen@lilypond.org> 1171799942 +0100

ignorance. LF

this would make interfacing with Git from scripts more ergonomical, 
less dependent on changes in the UI of porcelains, and in some cases
more efficient.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
