From: Curt Sampson <cjs@cynic.net>
Subject: Bug: "git svn clone" does not honor svn.authorsfile setting
Date: Tue, 10 Nov 2009 22:09:13 +0900
Message-ID: <20091110130913.GR19475@poetic.cynic.net>
Reply-To: Curt Sampson <cjs@cynic.net>, git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 14:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7qbv-0003sQ-Nf
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 14:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbZKJNSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 08:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbZKJNSD
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 08:18:03 -0500
Received: from static-122-103-239-153.ng-fam.svips.gol.ne.jp ([122.103.239.153]:64494
	"EHLO priv.dyadic.cynic.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756305AbZKJNSC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 08:18:02 -0500
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2009 08:18:02 EST
Received: by priv.dyadic.cynic.net (Postfix, from userid 1765)
	id 412912A242; Tue, 10 Nov 2009 22:09:13 +0900 (JST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132563>

[Note that I've set Reply-to to both myself and this list, as I am not
subscribed to the list. Broken list software and MUAs sometimes don't
honor this. Check to whom you're replying!]

When using "git svn fetch" or "git svn clone", the --authors-file
command line parameter does what it claims in the docs. Additionally,
for "git svn fetch", an svn.authorsfile configuration parameter in
~/.gitconfig is used, if no command line argument is specified. However,
svn.authorsfile is ignored by "git svn clone", though the documentation
claims that clone "runs init and fetch."

I have confirmed this bug is present in git versions 1.6.0.4 and 1.6.5.1.

cjs
-- 
Curt Sampson       <cjs@starling-software.com>        +81 90 7737 2974
           Functional programming in all senses of the word:
                   http://www.starling-software.com
