From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix handle leak in sha1_file/unpack_objects if there were
 damaged object data
Date: Wed, 19 Nov 2008 07:49:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811190749250.27509@xanadu.home>
References: <81b0412b0811190314k92a0acbn3ea820cce2a7a40b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mWf-000881-S0
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbYKSMuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbYKSMuE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:50:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40546 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYKSMuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:50:03 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAK005TAZN92U50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Nov 2008 07:49:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <81b0412b0811190314k92a0acbn3ea820cce2a7a40b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101334>

On Wed, 19 Nov 2008, Alex Riesen wrote:

> In the case of bad packed object CRC, unuse_pack wasn't called after
> check_pack_crc which calls use_pack.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Acked-by: Nicolas Pitre <nico@cam.org>


> ---
>  sha1_file.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 


Nicolas
