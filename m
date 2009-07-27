From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem packing repository
Date: Mon, 27 Jul 2009 08:56:03 -0700
Message-ID: <20090727155603.GM11191@spearce.org>
References: <F635344B8FC01740B0AA69090F092E9B01669B3C@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 17:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVSYg-0006ng-9s
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 17:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbZG0P4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 11:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbZG0P4D
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 11:56:03 -0400
Received: from george.spearce.org ([209.20.77.23]:58163 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZG0P4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 11:56:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 15D2A381FD; Mon, 27 Jul 2009 15:56:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <F635344B8FC01740B0AA69090F092E9B01669B3C@ex2k.bankofamerica.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124171>

"Murphy, John" <john.murphy@bankofamerica.com> wrote:
> I thought I resolved this problem with an upgrade to version
> 1.6.3.2.306.g4f4fa
> 
> I am getting this from git-gc in repositories that alternates:
> 
> usage: git-pack-objects [{ -q | --progress | --all-progress }] 

At first glance it would seem you are running an older version of
the git-pack-objects binary.  Maybe check the system calls with
truss and find out which binary its exec'ing ?

-- 
Shawn.
