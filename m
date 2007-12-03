From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-commit --allow-empty
Date: Mon, 03 Dec 2007 12:58:29 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712031255560.9605@xanadu.home>
References: <4751A0FB.6090705@gmail.com>
 <7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
 <7v63zgkw0x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mark Drago <markdrago@gmail.com>, stelian@popies.net,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:59:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFZF-00009A-LN
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXLCR6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbXLCR6c
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:58:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28878 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXLCR6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:58:31 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSH00DREJ9HY5C0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Dec 2007 12:58:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v63zgkw0x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66932>

On Mon, 3 Dec 2007, Junio C Hamano wrote:

> +--allow-empty::
> +	Usually recording a commit that has the exact same tree as its
> +	sole parent commit and the command prevents you from making such
> +	a mistake.  This option bypasses the safety, and is primarily
> +	for use by foreign scm interface scripts.

The first sentence is rather buggy I would say.


Nicolas
