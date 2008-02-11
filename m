From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Mon, 11 Feb 2008 11:00:33 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOb66-0003Ku-Ed
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbYBKQBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755612AbYBKQBA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:01:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57924 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbYBKQA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:00:59 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW3008CQ0GX0570@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 11:00:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73546>

On Mon, 11 Feb 2008, Martin Koegler wrote:

> If pack-objects hit the memory limit, it deletes objects from the delta
> window.
> 
> This patch make it only delete the data, which is recomputed, if needed again.
> 
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

Looks fine.

Acked-by: Nicolas Pitre <nico@cam.org>


Nicolas
