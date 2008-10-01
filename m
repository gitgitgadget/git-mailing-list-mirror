From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 3/8] Dispose of allocated colors on finalize()
Date: Wed, 1 Oct 2008 19:48:09 +0200
Message-ID: <200810011948.10041.robin.rosenberg.lists@dewire.com>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com> <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com> <20081001143718.GU21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 19:50:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl5qH-0000Qh-KZ
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 19:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYJARtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYJARtS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 13:49:18 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:51147 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYJARtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 13:49:17 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id CDF1B383C2; Wed,  1 Oct 2008 19:49:15 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 9BDD0383C1; Wed,  1 Oct 2008 19:49:15 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 4F5BD37E57;
	Wed,  1 Oct 2008 19:49:15 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20081001143718.GU21310@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97250>

onsdagen den 1 oktober 2008 16.37.18 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
[..]
> I think this is wrong.  Any color that we get from
[...]
> What was the rationale for disposing of these resources?  Did you
> identify that this is a resource leak somewhere?  Because I'd like
> to make sure I actually understand the SWT resource model better
> so I don't commit mistakes in the future.

I read the Color javadoc, but not the getSystemColor one. You are right, drop this patch
and the "dispose" hunk in the next patch (which was also a

-- robin
