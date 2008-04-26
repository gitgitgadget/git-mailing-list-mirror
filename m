From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] Check for circular references causing 'lost' nodes
Date: Sat, 26 Apr 2008 16:41:53 +0200
Message-ID: <20080426144153.GA21197@cuci.nl>
References: <20080425234556.C271E545D@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 16:43:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JplcI-00061c-5p
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 16:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYDZOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYDZOl7
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 10:41:59 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34742 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYDZOl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 10:41:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D2566545E; Sat, 26 Apr 2008 16:41:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080425234556.C271E545D@aristoteles.cuci.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80378>

The most likely cause for circular references are bad entries in the
grafts file (like I did once); since basically noone tells you where you
went wrong, it can be a bit puzzling to find out that part of your tree
goes dark sometimes, depending on which tool/options you pick to walk the
commit-tree.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg (AKA BuGless).
"God gave us a penis and a brain but not enough blood
 to use both at the same time." -- Robin Williams
