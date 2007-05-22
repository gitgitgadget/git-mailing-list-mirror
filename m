From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 23:51:34 +0200
Message-ID: <20070522215134.GH30871@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net> <20070522060302.GH5412@admingilde.org> <7v646l9xkn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org,
	Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 23:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcGg-00038C-8V
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbXEVVvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758223AbXEVVvm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:51:42 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56360 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757505AbXEVVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:51:42 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (klopstock mo40) (RZmta 6.5)
	with ESMTP id A0473dj4MHWXRd ; Tue, 22 May 2007 23:51:35 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E07EA277BD;
	Tue, 22 May 2007 23:51:34 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B4838D195; Tue, 22 May 2007 23:51:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v646l9xkn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48122>

Junio C Hamano, Tue, May 22, 2007 08:33:44 +0200:
> 	struct child_process {
>         	...
>                 const struct {
>                         const char *name;
>                         const char *value; /* NULL to unsetenv */
>                 } *env;
> 		...
> 	};

I actually like how the environment is organized. And it is simple to
define in the source. And there are well-known routines for
environment-like array manipulation.
