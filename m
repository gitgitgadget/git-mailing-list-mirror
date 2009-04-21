From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Tue, 21 Apr 2009 00:56:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904210054190.6741@xanadu.home>
References: <cover.1240115957.git.cloos@jhcloos.com>
 <d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 06:58:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw83L-0006k1-8A
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 06:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbZDUE4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 00:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZDUE4R
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 00:56:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57728 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZDUE4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 00:56:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIF006FWPPMKG20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Apr 2009 00:56:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Apr 2009, James Cloos wrote:

> When progress.c:throughput_string() is called, the variable total
> invariably has its twelve least significant bits set.  Ie, it is
> always the case that:
> 
>        total & 0xFFF == 0xFFF

Could you please explain ow you come to that conclusion?


Nicolas
