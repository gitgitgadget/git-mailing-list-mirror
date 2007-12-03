From: Nicolas Pitre <nico@cam.org>
Subject: Re: v1.5.4 plans
Date: Mon, 03 Dec 2007 13:06:49 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFhH-0003Yz-Ne
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXLCSGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXLCSGv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:06:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40297 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbXLCSGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:06:50 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSH000UIJNDF840@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Dec 2007 13:06:50 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66934>

On Sun, 2 Dec 2007, Junio C Hamano wrote:

> Please do not take this as the final decision made by the Emperor, whose
> subjects now must follow.  This is a sanity-check to see if everybody is
> on the same page.
> 
> I am not the Emperor anyway ;-)

Emperor of the Rising Sun.  ;-)

> Deprecation and Removal
> -----------------------
> 
>  * We also will give deprecation warning for the following features and
>    commands in the release notes to v1.5.4, and remove them in v1.5.5:
> 
>    - lost-found (use fsck --lost-found);
>    - post-update hook (use post-receive hook);
>    - peek-remote (use ls-remote)

Two things I would like to see in the next version (1.5.5) as well, for 
which we could provide early warnings now:

 - repack.usedeltabaseoffset defaulting to true

 - pack.indexversion defaulting to 2


Nicolas
