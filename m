From: David Kastrup <dak@gnu.org>
Subject: Problem with archimport
Date: Sun, 17 Jun 2007 09:09:57 +0200
Message-ID: <85ir9nkqey.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 09:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzouN-0000am-3q
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 09:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbXFQHKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 03:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbXFQHKp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 03:10:45 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:46158 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753481AbXFQHKo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 03:10:44 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 75EC24C8B2
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 09:10:43 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 637A223D2CD
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 09:10:43 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-043-051.pools.arcor-ip.net [84.61.43.51])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 43F35312762
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 09:10:43 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8F5571D0340C; Sun, 17 Jun 2007 09:09:57 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50335>


Hi, I am trying to import a large arch directory, and after a long
time of importing, I finally hit the following (unfortunately
repeatable) problem:

git-archimport -f emacs@sv.gnu.org/emacs--{devo,multi-tty,unicode}

Will import patchsets using the fast strategy
Renamed directories and permission changes will be missed
Unclean tree when about to process emacs@sv.gnu.org/emacs--devo--0--base-0  - did we fail to commit cleanly before?
:100644 100644 9bd88350a9553784a48ea1d5fa71484a7b200117 0000000000000000000000000000000000000000 M      lisp/.arch-inventory

Any idea what to do about this?

Thanks,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
