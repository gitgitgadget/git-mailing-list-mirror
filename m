From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 22:27:03 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712102225240.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
 <7vlk82hrdt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 04:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1vmN-0006We-Rx
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 04:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXLKD1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 22:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXLKD1G
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 22:27:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbXLKD1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 22:27:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSV00KB4894EBD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 22:27:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vlk82hrdt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67781>

On Mon, 10 Dec 2007, Junio C Hamano wrote:

> "Jon Smirl" <jonsmirl@gmail.com> writes:
> 
> > 95%   530  2.8G - 1,420 total to here, previous was 1,983
> > 100% 1390 2.85G
> > During the writing phase RAM fell to 1.6G
> > What is being freed in the writing phase??
> 
> entry->delta_data is the only thing I can think of that are freed
> in the function that have been allocated much earlier before entering
> the function.

Yet all ->delta-data instances are limited to 256MB according to Jon's 
config.


Nicolas

> 


Nicolas
