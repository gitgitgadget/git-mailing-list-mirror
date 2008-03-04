From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] git-pack-objects: Automatically pack annotated tags if
 object was packed
Date: Mon, 03 Mar 2008 21:45:21 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803032144110.2947@xanadu.home>
References: <20080304023607.GA16152@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNAG-0000aH-8G
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 03:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYCDCpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 21:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYCDCpX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 21:45:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61617 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYCDCpW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 21:45:22 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX60093DQBL4720@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Mar 2008 21:45:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080304023607.GA16152@spearce.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76017>

On Mon, 3 Mar 2008, Shawn O. Pearce wrote:

> The new option "--auto-follow-tags" allows the caller to request that
> any annotated tag be included into the packfile if the object the tag
> references was also included as part of the packfile.

Wouldn't "auto-include-tag" a better name for this option?


Nicolas
