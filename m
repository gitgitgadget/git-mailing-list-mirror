From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Make git compile with SUNs forte12 compiler
Date: Sun, 13 May 2007 12:52:10 +0200
Message-ID: <20070513105210.GD18546@cip.informatik.uni-erlangen.de>
References: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de> <Pine.LNX.4.64.0705131238420.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 13 12:52:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnBgb-0000NF-Ss
	for gcvg-git@gmane.org; Sun, 13 May 2007 12:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303AbXEMKwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 06:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757337AbXEMKwL
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 06:52:11 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55345 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757303AbXEMKwL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 06:52:11 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 189FD3F319; Sun, 13 May 2007 12:52:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705131238420.6410@racer.site>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47139>

Hello,

> A better solution (IMHO) is to make it "static inline".

they're already static inline. Maybe the sun compiler got confused by
the prototype which is a few lines below and missing the "static". Let
me check ... actually that's it. I make a patch ready.

        Thomas
