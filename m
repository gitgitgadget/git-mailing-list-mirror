From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 02 Feb 2014 12:04:18 +0100
Message-ID: <m2mwi9rd1p.fsf@linux-m68k.org>
References: <87a9e92424.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 19:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WANux-0007mJ-9U
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 19:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaBCSGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 13:06:43 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38657 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaBCSGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 13:06:42 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fHxnD6xtFz4KK4K;
	Mon,  3 Feb 2014 19:06:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fHxnD634zzbbgJ;
	Mon,  3 Feb 2014 19:06:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 8ko-UJxmQzEM; Mon,  3 Feb 2014 19:06:39 +0100 (CET)
X-Auth-Info: ToO+Swko/jR2d88MWUwutuBtWW/cEZoXj4uWXNV7CPM=
Received: from linux.local (ppp-46-244-233-163.dynamic.mnet-online.de [46.244.233.163])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  3 Feb 2014 19:06:39 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 8B6DB1E54A9; Sun,  2 Feb 2014 12:04:19 +0100 (CET)
X-Yow: Do I have a lifestyle yet?
In-Reply-To: <87a9e92424.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sun, 02 Feb 2014 11:37:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241443>

David Kastrup <dak@gnu.org> writes:

> Are there some measures one can take/configure in the parent repository
> such that (named or all) additional directories inside of $GITDIR/refs
> would get cloned along with the rest?

$ git config --add remote.orgin.fetch '+refs/notes/*:refs/notes/*'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
