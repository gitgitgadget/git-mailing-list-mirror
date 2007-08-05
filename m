From: David Kastrup <dak@gnu.org>
Subject: Re: How to figure out what 'git push' would do?
Date: Sun, 05 Aug 2007 13:42:49 +0200
Message-ID: <85ps228ax2.fsf@lola.goethe.zz>
References: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHeVj-0005KV-KD
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbXHELnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbXHELnA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:43:00 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:49907 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032AbXHELm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 07:42:59 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id AC7383665C6;
	Sun,  5 Aug 2007 13:42:58 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 9DF772DA964;
	Sun,  5 Aug 2007 13:42:58 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 6574336E86F;
	Sun,  5 Aug 2007 13:42:58 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 361671C3D500; Sun,  5 Aug 2007 13:42:49 +0200 (CEST)
In-Reply-To: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de> (Steffen Prohaska's message of "Sun\, 5 Aug 2007 13\:37\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54998>

Steffen Prohaska <prohaska@zib.de> writes:

> How can I check what a 'git push' would do, without
> actually doing it?
>
> Is there something like 'git push --dry-run', similar
> to 'rsync --dry-run'?

Wel, you could put

#!/bin/sh
cat >/tmp/dryrun
exit 1

into

$GIT_DIR/hooks/pre-receive

on the receiving side.  Or maybe the update hook.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
