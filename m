From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Wed, 17 Oct 2007 16:56:09 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710171653500.19446@xanadu.home>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <20071017021137.GO13801@spearce.org>
 <20071017082003.GA10799@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_N1E5uOci0wWGDDGZwvgo8g)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 22:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiFwb-0008Fk-Mw
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 22:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036AbXJQU4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbXJQU4f
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 16:56:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24295 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbXJQU4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 16:56:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ2005QBQ5LQH00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Oct 2007 16:56:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071017082003.GA10799@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61426>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_N1E5uOci0wWGDDGZwvgo8g)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Wed, 17 Oct 2007, Karl Hasselström wrote:

> On 2007-10-16 22:11:37 -0400, Shawn O. Pearce wrote:
> 
> > Nicolas Pitre <nico@cam.org> wrote:
> >
> > > Each progress can be on a single line instead of two.
> >
> > Nice. Of course that screws with git-gui and now I have to match two
> > regexs and not one. But whatever.
> 
> Maybe an env variable could cause the code to emit machine-friendly
> progress information instead?

That won't help with remotely generated progress unaware of local env 
variable, and the remote server might still be generating old format.


Nicolas

--Boundary_(ID_N1E5uOci0wWGDDGZwvgo8g)--
