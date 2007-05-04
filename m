From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects
 --compression=N
Date: Fri, 04 May 2007 16:17:35 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705041609260.24220@xanadu.home>
References: <463802ED.1080200@gmail.com>
 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
 <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
 <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.99.0705040937250.24220@xanadu.home>
 <56b7f5510705040910i3cac723co3aed45034c097def@mail.gmail.com>
 <alpine.LFD.0.99.0705041218130.24220@xanadu.home>
 <56b7f5510705041251v1a09103eif677c02efc53059e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 22:17:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4E0-0004Ng-VE
	for gcvg-git@gmane.org; Fri, 04 May 2007 22:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S376133AbXEDURo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 16:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376136AbXEDURo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 16:17:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31707 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S376133AbXEDURn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 16:17:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHJ00MMW9PBPCI0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 May 2007 16:17:36 -0400 (EDT)
In-reply-to: <56b7f5510705041251v1a09103eif677c02efc53059e@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46209>

On Fri, 4 May 2007, Dana How wrote:

> Now that I'm awake your original quote at the top suggests:
> (a) zlib_compression_level =
>     isset(core.loosecompression) ? core.loosecompression :
>     isset(core.compression) ? core.compression : Z_BEST_SPEED;
> (b) pack_compression_level =
>     isset(pack.compression) ? pack.compression :
>     isset(core.compression) ? core.compression : Z_DEFAULT_COMPRESSION;
> 
> Your later reaction to my quoted (a)/(b) table suggests:
> (a) zlib_compression_level =
>     isset(core.compression) ? core.compression : Z_BEST_SPEED;
> (b) pack_compresion_level =
>     isset(pack.compression) ? pack.compression : Z_DEFAULT_COMPRESSION;

My final comment is that I think the former looks more coherent, while 
the later is simpler to implement.


Nicolas
