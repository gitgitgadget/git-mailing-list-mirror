From: Bill Lear <rael@zopyra.com>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 14:28:21 -0600
Message-ID: <17875.28901.705687.843342@lisa.zopyra.com>
References: <17875.25882.784307.731860@lisa.zopyra.com>
	<20070214194919.GE28290@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 21:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQjs-00041k-Cz
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbXBNU2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXBNU2Z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:28:25 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60192 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568AbXBNU2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:28:25 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EKSLD15576;
	Wed, 14 Feb 2007 14:28:21 -0600
In-Reply-To: <20070214194919.GE28290@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39740>

On Wednesday, February 14, 2007 at 14:49:19 (-0500) Shawn O. Pearce writes:
>...
>Use `git checkout <SHA>` which will detach your HEAD and seek to
>the commit, leaving your current commit alone.  Later you can get
>back by `git checkout oldbranch`.

BTW, we are still using 1.4.4.1.  This will work with that?

Another BTW: this seems very similar to something that you would
tackle with git bisect (haven't used that yet), but as I understand
it, git bisect works on tags(??).

Sort of what I had in mind:

% git bisect start
% git bisect good --date="2 days ago"
% git bisect bad master
[...]



Bill
