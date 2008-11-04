From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Mon, 03 Nov 2008 20:57:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811032053410.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <m37i7pggnk.fsf@localhost.localdomain>
 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
 <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
 <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
 <alpine.LFD.2.00.0811031611060.13034@xanadu.home>
 <f1d2d9ca0811031453p49390911p956149ca76b9b80d@mail.gmail.com>
 <alpine.LFD.2.00.0811031959070.13034@xanadu.home>
 <7v3ai8tgq9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thanassis Tsiodras <ttsiodras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 02:58:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxBBe-00008S-9P
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 02:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYKDB5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 20:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYKDB5L
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 20:57:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54809 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYKDB5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 20:57:10 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9S00DJ8DF441B0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Nov 2008 20:57:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3ai8tgq9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100024>

On Mon, 3 Nov 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Right.  Those thin packs were designed for different versions of the 
> > same file in mind, not different files with almost the same content.  
> > This could possibly be improved at some point...
> 
> Wouldn't using a large --window help by going across name-hash boundaries?

The issue is to decide what preferred delta base to add to the list of 
objects.  Currently only objects with the same path as those being 
modified are considered.


Nicolas
