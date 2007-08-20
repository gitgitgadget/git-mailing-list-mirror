From: Tom Schinckel <gunny01@gmail.com>
Subject: Git Questions
Date: Mon, 20 Aug 2007 19:25:48 +0930
Message-ID: <1187603749.11595.10.camel@tom-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 11:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN40W-0007e9-4Q
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 11:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbXHTJ5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 05:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbXHTJ5H
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 05:57:07 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:21915 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbXHTJ5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 05:57:06 -0400
Received: by rv-out-0910.google.com with SMTP id k20so935105rvb
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 02:57:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=mwwRFyln6pELzsmgolNgNzC+6eI03AwVX1LzHg+F0r4ZfSbMbHIvLbiFWpCFUGxphtJYBHp0GaNVFSKjo6YxMia0VoiqefyThw7j9iK1hogAYWyNf09yoPPRw9he6fFkr/42Je+zG9QjQwgxo5TFl/1Dn1vTjUahKZDad/wC/T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JDSxLUk+ciUY6K/CjJ40dDHwmyZjTQ7sZMpNgsAy5+N0Ea8DzwTCAJ2xalQCtPiJfx/hbllO6ML0yOjL6vZxPvVKI5nstjd22uxALNwij+vek70n3XEh5vVOnw5WwGpvrV50xvXm9sKH6nho/wwH+nK7pU+iw53SIWVo84+40Vk=
Received: by 10.141.52.5 with SMTP id e5mr2582249rvk.1187603823871;
        Mon, 20 Aug 2007 02:57:03 -0700 (PDT)
Received: from ?192.168.1.67? ( [121.45.94.82])
        by mx.google.com with ESMTPS id f10sm11083057rvb.2007.08.20.02.57.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Aug 2007 02:57:03 -0700 (PDT)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56204>

Hi all,

I've just started using git to run a repository on my local machine. I'm
wondering about the following questions:

Is it possible to change the revision numbers from long hashes to normal
numbers (i.e, 0001 for first, 0002 for the second)

Can I set up Git to:

a) Automatically commit a file to the repository every time it's saved

b) Automatically use the default hashed-out bit:

	# Please enter the commit message for your changes.
	# (Comment lines starting with '#' will not be included)
	# Updated but not checked in:
	#   (will commit)
	#
	#       modified:   TOK/bce.abw
	#
	# Untracked files:
	#   (use "git add" to add to commit)
	#
	#       TOK/bce.abw.bak~

as the commit message? (i.e, remove the hash signs and not bring up vim
in the first place?)

Thanks for any help.

tom
