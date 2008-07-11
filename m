From: Petr Baudis <pasky@suse.cz>
Subject: Re: Ext4 patchqueue corrupted ?
Date: Fri, 11 Jul 2008 15:13:38 +0200
Message-ID: <20080711131338.GU10151@machine.or.cz>
References: <20080711034606.GA779@skywalker> <20080711084715.GT10151@machine.or.cz> <20080711122617.GA8154@mit.edu> <20080711123109.GA14606@skywalker> <20080711124742.GA20099@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Ming Ming Cao <cmm@us.ibm.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: linux-ext4-owner@vger.kernel.org Fri Jul 11 15:14:50 2008
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHISP-0004Pd-OF
	for gcfe-linux-ext4@gmane.org; Fri, 11 Jul 2008 15:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbYGKNNo (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Fri, 11 Jul 2008 09:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYGKNNo
	(ORCPT <rfc822;linux-ext4-outgoing>);
	Fri, 11 Jul 2008 09:13:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48322 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbYGKNNn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Fri, 11 Jul 2008 09:13:43 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id F35B9393BB0A; Fri, 11 Jul 2008 15:13:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080711124742.GA20099@mit.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88116>

  Hi,

On Fri, Jul 11, 2008 at 08:47:42AM -0400, Theodore Tso wrote:
> Can you completely zap the repository replace it with a freshly 
> "git init"-ialized files, and I'll try repushing?

  right, I have done that now. For anyone interested in the corrupted
repository, the backed up refs and objects directories are still in the
repository under the name *.broken, e.g. at

	http://repo.or.cz/r/ext4-patch-queue.git

I will try to analyze it myself later.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
