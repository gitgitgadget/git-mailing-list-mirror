From: Nicolas Pitre <nico@cam.org>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 21:28:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810272041180.13034@xanadu.home>
References: <ge0rla$mce$1@ger.gmane.org> <200810270252.23392.jnareb@gmail.com>
 <b6jwksWkldU6N726dbI3k3yYE6WL1aXJERb9Oh1lNd8g5zdTavgRew@cipher.nrlssc.navy.mil>
 <200810272137.07309.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arne Babenhauserheide <arne_bab@web.de>, mercurial@selenic.com,
	SLONIK.AZ@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 02:30:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KudPC-00059p-NO
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 02:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYJ1B2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 21:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYJ1B2p
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 21:28:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31981 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYJ1B2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 21:28:44 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9F00HQ1DFP777R@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 27 Oct 2008 21:28:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200810272137.07309.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99270>

On Mon, 27 Oct 2008, Jakub Narebski wrote:

> On the other access from "smart" client (git://, ssh://, future "smart"
> HTTP server) results in creating a pack, so we cannot allow for too
> tight pack compression, or to be more exact too much CPU load taken.

Don't forget that, in those cases, the created pack for streaming is 
copying chunks of data from existing packs for most objects, effectively 
reusing for free the work that has previously been done to tightly 
compress those packs.


Nicolas
