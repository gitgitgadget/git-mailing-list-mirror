From: Nicolas Pitre <nico@cam.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 17:27:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702141722410.1757@xanadu.home>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net>
 <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
 <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSbL-0000S6-Bi
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbXBNW10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbXBNW10
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:27:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58419 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbXBNW1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:27:25 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDH00EOR51OSB10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Feb 2007 17:27:24 -0500 (EST)
In-reply-to: <17875.33204.413186.355557@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39765>

On Wed, 14 Feb 2007, Bill Lear wrote:

> WAAAAAIAMINIT ... I think I see it:
> 
> % perl -pi -e 's/.*\$Id.*//sx' $(xgrep -l '[$]Id')
> 
> Could I have corrupted the pack file?  I'll bet $50 I did:
> 
> % [yet another clone]
> % xgrep -l '[$]Id'
> ./.git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
> [...]
> 
> %!@#$&$%(@@@!!!

But...... your pack file is read-only, isn't it?

Is perl -i so bad to overwrite even read only files?


Nicolas
