From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Using gitk over the network
Date: Wed, 19 Mar 2008 15:31:14 +0100
Message-ID: <ae63f8b50803190731h49e224cby33344f8737f83718@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 21:49:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5DW-000683-6O
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759887AbYCSU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756042AbYCSU2W
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:28:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:20892 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759887AbYCSU2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:28:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so332356nfb.21
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 13:28:18 -0700 (PDT)
Received: by 10.78.68.18 with SMTP id q18mr797675hua.72.1205937074930;
        Wed, 19 Mar 2008 07:31:14 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Wed, 19 Mar 2008 07:31:14 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: fe9bb63342c87221
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77539>

Hi there,

I'm using gitk through an SSH-tunnelled X11 connection.  Once loaded,
the GUI is usable on a DSL connection, but the problem is that gitk
loads the whole commit history, not only the commits that will fit on
screen.  It can take up to a minute with our repository for the GUI to
be ready, especially when visualizing all branches.

I thought I'd let you know, in the case there is the possibility to
have some sort of progressive loading in the future.  Compared to
gitk, git-gui works fine in this environment.

NOTE: I discovered tig today on this very mailing-list, and I admit
it's fulfilling part of our usecase, but maybe there are some people
in my team that are reluctant to text-based interfaces, who knows.

Cheers,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
