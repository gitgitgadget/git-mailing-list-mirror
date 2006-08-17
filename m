From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] Trace into a file if GIT_TRACE can interpreted as a filename.
Date: Thu, 17 Aug 2006 08:14:43 +0200
Message-ID: <200608170814.44461.chriscool@tuxfamily.org>
References: <20060816225846.ae424b46.chriscool@tuxfamily.org> <7vhd0c2xbz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 08:09:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDb4V-0004Wa-Is
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 08:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWHQGJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 02:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWHQGJh
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 02:09:37 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:16816 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750843AbWHQGJg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 02:09:36 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1504D4469F;
	Thu, 17 Aug 2006 08:09:35 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vhd0c2xbz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25549>

Junio C Hamano writes:
> 
> I wonder if we can pass an already opened file descriptor to
> GIT_TRACE.  E.g.
> 
> 	GIT_TRACE=9 make test 9>/var/tmp/trace.log
> 
> and make the trace code to emit the message with one write(2) to
> make sure messages from processes do not get mixed up in the
> middle.
 
I will see if I can come up with something.

Thanks again,
Christian. 
