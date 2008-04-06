From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 3/4] git log and git rev-list: Add --graph option
Date: Mon, 7 Apr 2008 00:15:32 +0300
Message-ID: <200804070015.32783.tlikonen@iki.fi>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <1207507332-1866-2-git-send-email-adam@adamsimpkins.net> <1207507332-1866-3-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 23:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JicDq-0007G3-Be
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 23:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYDFVPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 17:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbYDFVPf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 17:15:35 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:64099 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753478AbYDFVPe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 17:15:34 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB960049237A; Sun, 6 Apr 2008 23:15:33 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <1207507332-1866-3-git-send-email-adam@adamsimpkins.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78930>

Adam Simpkins kirjoitti:

> The --graph option causes a text-based representation of the history
> graph to be printed on the left-hand side of the output.

The '--graph' seems to work nicely with every '--pretty=' option 
except 'email'.

$ git log --graph --pretty=email


|
M     From 77ad7a49d3cc946487ca759e5361effbcfb03be5 [...]
From: Junio C Hamano <gitster@pobox.com>
|\    Date: Fri, 4 Apr 2008 22:38:32 -0700
| |   Subject: [PATCH] Merge git://repo.or.cz/git-gui
| |   
| |   * git://repo.or.cz/git-gui:
| |     git-gui: use +/- instead of ]/[ to show [...]
| |     git-gui: Update french translation
| |     git-gui: Switch keybindings for [ and ] to [...]


The 'From:' field is always at the column 1.
