From: David Kastrup <dak@gnu.org>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 13:28:27 +0100
Message-ID: <85lk6giv4k.fsf@lola.goethe.zz>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	<7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
	<7v63xlqnd0.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801231221120.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHej1-0008TM-Ua
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 13:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYAWM2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 07:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYAWM2d
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 07:28:33 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:57357 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009AbYAWM2c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 07:28:32 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id ED6B5183439;
	Wed, 23 Jan 2008 13:28:30 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 4EB582BECD2;
	Wed, 23 Jan 2008 13:28:30 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-046-029.pools.arcor-ip.net [84.61.46.29])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 1E93B225124;
	Wed, 23 Jan 2008 13:28:30 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D7A2A1C3D4E5; Wed, 23 Jan 2008 13:28:27 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0801231221120.5731@racer.site> (Johannes
	Schindelin's message of "Wed, 23 Jan 2008 12:24:13 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5531/Wed Jan 23 11:32:09 2008 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71535>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Both issues (and the config variable issue Linus raised) are easily
> helped with: store not only the hashmap in the extension, but also an
> identifier for the hash method used.

For a reasonably implemented hash algorithm, computing the hash should
be cheaper than reading it from disk.

So storing precomputed hashes is not worth the trouble.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
