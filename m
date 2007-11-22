From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH 2/3 v3] git-svn info: implement info command
Date: Wed, 21 Nov 2007 19:16:21 -0800 (PST)
Message-ID: <900537.19467.qm@web52411.mail.re2.yahoo.com>
References: <20071122014038.GA25341@soma>
Reply-To: ddkilzer@kilzer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 04:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv2YU-0007Bu-MS
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 04:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbXKVDQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 22:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbXKVDQX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 22:16:23 -0500
Received: from web52411.mail.re2.yahoo.com ([206.190.48.174]:38406 "HELO
	web52411.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751780AbXKVDQX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 22:16:23 -0500
Received: (qmail 19716 invoked by uid 60001); 22 Nov 2007 03:16:21 -0000
X-YMail-OSG: _wHcFvgVM1krEuY5eYRGQCfBKzUGiOb4dja3_PFSees3fgduGzyvtlSKZgga3SnAoIPJlg--
Received: from [24.7.124.164] by web52411.mail.re2.yahoo.com via HTTP; Wed, 21 Nov 2007 19:16:21 PST
X-RocketYMMF: ddkilzer
In-Reply-To: <20071122014038.GA25341@soma>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65737>

Eric Wong <normalperson@yhbt.net> wrote:
> When running from a top-level directory with no arguments, the first
> line of git-ls-tree was being read.  This allowed the test case to pass
> because ls-tree sorts the output and 'directory' just happened to
> be up top; so we were getting the 040000 mode from the 'directory'
> tree and not the top-level tree.
> 
> The below test should fix it for the trivial case I have.

Acked-by: David D. Kilzer <ddkilzer@kilzer.net>

Looks good!  Thanks!

Dave
