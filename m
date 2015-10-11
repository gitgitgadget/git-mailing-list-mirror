From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 0/4] Fix locking issues on Windows with `git clone
 --dissociate`
Date: Sun, 11 Oct 2015 13:45:51 +0300
Message-ID: <20151011104551.GA13032@wheezy.local>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444131898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 11 12:46:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlE8i-0004GB-OO
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 12:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbbJKKp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 06:45:59 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:33888
	"EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbbJKKp7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2015 06:45:59 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-04.prod.phx3.secureserver.net with 
	id Tmlr1r00E5B68XE01mlx4q; Sun, 11 Oct 2015 03:45:58 -0700
Content-Disposition: inline
In-Reply-To: <cover.1444131898.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279334>

On Tue, Oct 06, 2015 at 03:17:36PM +0200, Johannes Schindelin wrote:
> This is version 3, adding that BUG! message if do_not_close was set.
> 
> Max, I still hope that this patch series helps also your use case!

Thanks, this mostly makes gone one of my commits. I only
need to invoke the function after builtin is done. And maybe
spend some time to check that dies do not happen.

The other one with cloexec I think I will still need.

It migh take some time before I return to it.

-- 
Max
