From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 26 Nov 2008 19:43:27 +0100
Message-ID: <20081126184327.GA4399@blimp.localdomain>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com> <4923FE58.3090503@viscovery.net> <alpine.LFD.2.00.0811190753420.27509@xanadu.home> <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com> <49241AEF.1080808@viscovery.net> <alpine.LFD.2.00.0811190940480.27509@xanadu.home> <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com> <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:45:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5PNi-00057y-Ky
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 19:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYKZSnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 13:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYKZSnm
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 13:43:42 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:31524 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYKZSnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 13:43:41 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE81rapA
Received: from tigra.home (Fa9b5.f.strato-dslnet.de [195.4.169.181])
	by post.strato.de (mrclete mo58) (RZmta 17.20)
	with ESMTP id p0294bkAQHwMQx ; Wed, 26 Nov 2008 19:43:28 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id D0452277C8;
	Wed, 26 Nov 2008 19:43:27 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 6187236D27; Wed, 26 Nov 2008 19:43:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101756>

Nicolas Pitre, Wed, Nov 26, 2008 15:33:51 +0100:
> On Wed, 26 Nov 2008, Alex Riesen wrote:
> > 2008/11/19 Nicolas Pitre <nico@cam.org>:
> > > I'm looking at it now.  I'm therefore revoking my earlier ACK as well
> > > (better keep that test case alive).
> > >
> > 
> > Any news here?
> 
> Yes: my hard disk crashed a couple hours after I mentioned this, so most 
> of my time has been spent on recovery since then.  I'll come back to it 
> eventually.

Heh... Good luck!
