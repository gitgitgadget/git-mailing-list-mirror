From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] init-db: support --import to add all files and commit
	right after init
Date: Tue, 24 Mar 2009 19:14:58 -0700
Message-ID: <20090325021458.GY23521@spearce.org>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguy???n Th??i Ng???c Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIfP-0004L4-1b
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbZCYCPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 22:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbZCYCPB
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:15:01 -0400
Received: from george.spearce.org ([209.20.77.23]:49051 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbZCYCPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 22:15:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 03EF138211; Wed, 25 Mar 2009 02:14:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114541>

Nguy???n Th??i Ng???c Duy <pclouds@gmail.com> wrote:
> This is equivalent to "git init;git add .;git commit -q -m blah".
> I find myself doing that too many times, hence this shortcut.

Why not:

  git config --global alias.init-import '!git init && git add . && git commit -q'

?

-- 
Shawn.
