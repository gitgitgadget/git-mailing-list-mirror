From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 07:45:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811190740570.27509@xanadu.home>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mS8-0006RI-W6
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbYKSMp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYKSMp0
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:45:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36802 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYKSMpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:45:25 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAK008L5ZECQ360@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Nov 2008 07:44:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101333>

On Wed, 19 Nov 2008, Alex Riesen wrote:

> The opened packs seem to stay open forever.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> I'm very unsure about the solution, though: it is really horrible code
> to debug...

What is the actual problem?  Pack windows are left open on purpose.


Nicolas
