From: fork0@t-online.de (Alex Riesen)
Subject: Re: file name case-sensitivity issues
Date: Thu, 25 May 2006 17:47:35 +0200
Message-ID: <20060525154735.GA6119@steel.home>
References: <20060523210615.GB5869@steel.home> <7v7j4c4af3.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 17:48:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjI3t-0004jr-I1
	for gcvg-git@gmane.org; Thu, 25 May 2006 17:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWEYPrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWEYPrm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 11:47:42 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:57230 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750777AbWEYPrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 11:47:41 -0400
Received: from fwd30.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1FjI3m-00048n-00; Thu, 25 May 2006 17:47:38 +0200
Received: from tigra.home (EY0knvZHoe2l5yn41-GeLANTMwd3lQZvmLaejhhI0OgHBZkJljV3wJ@[84.160.104.11]) by fwd30.sul.t-online.de
	with esmtp id 1FjI3k-1ttJ0S0; Thu, 25 May 2006 17:47:36 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DE84C277B5;
	Thu, 25 May 2006 17:47:35 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FjI3j-0001kG-91; Thu, 25 May 2006 17:47:35 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j4c4af3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-ID: EY0knvZHoe2l5yn41-GeLANTMwd3lQZvmLaejhhI0OgHBZkJljV3wJ
X-TOI-MSGID: 0861358a-f9f0-494d-801a-e42e847d0efb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20742>

Junio C Hamano, Wed, May 24, 2006 00:57:04 +0200:
> I'd call that a PEBCAK.

It is not solvable there though.

> If you _know_ you are working on a case challenged filesystem, I
> think the best thing you can do is not to work on a project that
> has files in different cases on such a filesystem.

That is seldom an acceptable suggestion. Besides, how about when you
don't _know_, like when cloning onto an usb-stick mounted with
auto-detection? Will the files with case-different names just
overwrite each other?
