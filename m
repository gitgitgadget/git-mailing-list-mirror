From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH 1/4] Remove unnecessary call_depth parameter in merge-recursive.
Date: Sun, 14 Jan 2007 20:35:03 +0100
Message-ID: <20070114193503.GB2378@steel.home>
References: <20070114052832.GA19113@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2B-0000IT-J3
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:15 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7z-0003eK-UR
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbXANTfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbXANTfV
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:35:21 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:57524 "EHLO
	mailout01.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622AbXANTfU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jan 2007 14:35:20 -0500
Received: from fwd26.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1H6B8N-0007DN-00; Sun, 14 Jan 2007 20:35:15 +0100
Received: from tigra.home (G59O1YZJweJOKM1pKq7clNQ7TZH6HUcOTokD3idcu6UegxWPPBh5Ej@[84.163.118.52]) by fwd26.sul.t-online.de
	with esmtp id 1H6B8B-2CDG2i0; Sun, 14 Jan 2007 20:35:03 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 76B7A277B6;
	Sun, 14 Jan 2007 20:35:03 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 62622C79D; Sun, 14 Jan 2007 20:35:03 +0100 (CET)
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070114052832.GA19113@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: G59O1YZJweJOKM1pKq7clNQ7TZH6HUcOTokD3idcu6UegxWPPBh5Ej
X-TOI-MSGID: f9e1df73-4f22-4c03-87fe-8b89f9e4b5d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36872>

Shawn O. Pearce, Sun, Jan 14, 2007 06:28:33 +0100:
> Because the output_indent always matches the call_depth value
> there is no reason to pass around the call_depth to the merge
> function during each recursive invocation.

Actually, you removed output_indent, not call_depth.
