From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Sat, 8 Mar 2008 17:51:06 +0000
Message-ID: <20080308175106.GA13855@hashpling.org>
References: <20080308165245.15343.62914.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 18:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY3D8-0005f3-Ac
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 18:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYCHRvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 12:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYCHRvP
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 12:51:15 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:40719 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbYCHRvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 12:51:15 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JY3CV-0005y1-QY; Sat, 08 Mar 2008 17:51:15 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m28Hp6hr014328;
	Sat, 8 Mar 2008 17:51:06 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m28Hp6Wx014326;
	Sat, 8 Mar 2008 17:51:06 GMT
Content-Disposition: inline
In-Reply-To: <20080308165245.15343.62914.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 683a1cf7b9d60e04a1ea1d5e429d0f2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76568>

On Sat, Mar 08, 2008 at 05:57:20PM +0100, Jakub Narebski wrote:
> Add output_pipeline subroutine, which allows to use list form of
> pipeline; instead of
>   open my $fh, "-|", "cmd_1 option | cmd_2 argument"
> we can now write
>   my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
> which allows to avoid troubles with shell quoting, and avoid spawning
> shell.  Code is based on snippet http://www.perlmonks.org/?node_id=246397
> simplified a bit.
> 

I'm not a perl open expert, and I don't know if gitweb has other
issues on windows anyway, but the list time I experimented with it
neither the open( FHAND, "-|" ) trick, not the list form of open in
combination with the "-|" mode worked at all on windows.

Charles.
