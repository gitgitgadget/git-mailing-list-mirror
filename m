From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel()
Date: Mon, 11 Jan 2010 20:12:57 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001111354470.7728@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am> <20100110101154.GA18138@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 08:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUEYV-0005g8-4K
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 08:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab0AKHTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 02:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348Ab0AKHTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 02:19:09 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:49347 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab0AKHTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 02:19:09 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 7BD4B40088;
	Mon, 11 Jan 2010 20:19:06 +1300 (NZDT)
In-Reply-To: <20100110101154.GA18138@progeny.tock>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136609>

On Sun, 10 Jan 2010, Jonathan Nieder wrote:
> Why not 'cdup=$(git rev-parse --show-toplevel) && cd "$cdup"'
> unconditionally?  That would avoid having to look for the .git dir
> twice and would mirror setup_work_tree() a bit more closely.

Depends on what you think is the lesser of to evials, running 
'git rev-parse' twice or preforming a cd when theres no need to, but after
looking at setup_work_tree() I agree with you and will send in a new patch.

-- 
Steven
