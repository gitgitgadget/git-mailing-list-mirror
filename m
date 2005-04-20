From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: enforcing DB immutability
Date: Wed, 20 Apr 2005 17:57:23 +0200
Organization: Harddisk-recovery.com
Message-ID: <20050420155723.GC27307@harddisk-recovery.com>
References: <20050420084115.2699.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu
X-From: git-owner@vger.kernel.org Wed Apr 20 17:54:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHVp-0005Ol-IU
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDTP51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVDTP51
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:57:27 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:59703 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261703AbVDTP5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 11:57:24 -0400
Received: (qmail 4715 invoked by uid 501); 20 Apr 2005 15:57:23 -0000
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20050420084115.2699.qmail@science.horizon.com>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 08:41:15AM -0000, linux@horizon.com wrote:
> [A discussion on the git list about how to provide a hardlinked file
> that *cannot* me modified by an editor, but must be replaced by
> a new copy.]

Some time ago there was somebody working on copy-on-write links: once
you modify a cow-linked file, the file contents are copied, the file is
unlinked and you can safely work on the new file. It has some horrible
semantics in that the inode number of the opened file changes, I don't
know if applications are or should be aware of that.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
