From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn fetch loses data
Date: Sun, 15 Nov 2009 21:52:00 +0100
Message-ID: <200911152152.01513.trast@student.ethz.ch>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com> <200911151433.54797.trast@student.ethz.ch> <4B005C14.8090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Victor Engmark <victor.engmark@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Johan 't Hart <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 21:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9m5l-00085h-Kn
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 21:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbZKOUws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 15:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbZKOUws
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 15:52:48 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:5908 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbZKOUwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 15:52:47 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 21:52:50 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 21:52:44 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <4B005C14.8090607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132960>

Johan 't Hart wrote:
> I didn't even know you could also do
> $ git rebase git-svn
> Unless git-svn is a ref...

You can't, but in git-svn's default configuration (without
--stdlayout) the cloned SVN history is called refs/remotes/git-svn.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
