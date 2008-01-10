From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Wed, 09 Jan 2008 22:41:15 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801092234130.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>, Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 04:41:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCoIc-0002CJ-6C
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 04:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbYAJDlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 22:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbYAJDlR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 22:41:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10912 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbYAJDlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 22:41:17 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUE004FASWR0DC0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 Jan 2008 22:41:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0801092328580.31053@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70037>

On Wed, 9 Jan 2008, Johannes Schindelin wrote:

> I agree that gzip is already fast enough.
> 
> However, pack v4 had more goodies than just being faster; it also promised 
> to have smaller packs.

Right, like not having to compress tree objects and half of commit 
objects at all.


Nicolas
