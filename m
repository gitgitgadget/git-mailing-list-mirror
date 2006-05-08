From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 22:39:18 -0400
Message-ID: <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcvjW-00074j-6k
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWEHCoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWEHCoX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:44:23 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:10825 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932260AbWEHCoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 22:44:23 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 May 2006 19:48:51 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4A958644C28;
	Sun,  7 May 2006 22:44:21 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060507223918.6112f0c1.seanlkml@sympatico.ca>
In-Reply-To: <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 May 2006 02:48:51.0593 (UTC) FILETIME=[F045E790:01C67249]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 07 May 2006 19:29:50 -0700
Junio C Hamano <junkio@cox.net> wrote:


> Not at all.  Whatever Porcelain that runs repo-config to record
> the branch name needs to spell that branch name with proper
> quoting, like:

Okay.  It just seems nuts to require quoting because you happen
to use an uppercase character.  People are used to quoting 
special characters like * and $, not uppercase letters.

> I _do_ want to keep my slashes intact and also dots; mangling
> them is not very nice to me X-<.

You're right.

We should just relax the config file rules for legal characters,
in identifiers, at least [a-zA-Z0-9_/-].

Sean.
