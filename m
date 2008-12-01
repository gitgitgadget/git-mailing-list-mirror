From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: two questions about the format of loose object
Date: Mon, 1 Dec 2008 23:16:11 +1100
Message-ID: <20081201121611.GC32415@mail.local.tull.net>
References: <493399B7.5000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 13:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77oz-0004y0-H5
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 13:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYLAMW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 07:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYLAMW4
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 07:22:56 -0500
Received: from vps1.tull.net ([66.180.172.116]:38771 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752282AbYLAMWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 07:22:55 -0500
Received: (qmail 12798 invoked by uid 1015); 1 Dec 2008 23:16:13 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Mon, 01 Dec 2008 23:16:13 +1100
Received: (qmail 2655 invoked by uid 1000); 1 Dec 2008 23:16:11 +1100
Content-Disposition: inline
In-Reply-To: <493399B7.5000505@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102029>

On Mon, Dec 01, 2008 at 04:00:55PM +0800, Liu Yubao wrote:
> I did a simple benchmark on my notebook and a server in my company,
> writing a big file to disk is faster than compressing it first and
> writing the result out. The former's performance for reading should
> also be better because of file cache.

In a corporate environment (and not related to git) I found the
opposite. The disk was fairly slow (over NFS) and it was in fact
quicker to read and write compressed files.

Nick.
