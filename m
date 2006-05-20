From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] include header to define uint32_t, necessary on Mac OS X
Date: Sat, 20 May 2006 16:41:11 +0200
Message-ID: <20060520144111.GA5798@steel.home>
References: <20060511173632.G60c08b4@leonov.stosberg.net> <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605111218380.3866@g5.osdl.org> <7viroav534.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605142056320.3038@mundungus.clifford.ac> <Pine.LNX.4.64.0605142057220.10680@mundungus.clifford.ac>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 16:41:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhSeG-0003pr-OK
	for gcvg-git@gmane.org; Sat, 20 May 2006 16:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWETOlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWETOle
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 10:41:34 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:30146 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964844AbWETOle (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 10:41:34 -0400
Received: from fwd29.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1FhSdp-000674-04; Sat, 20 May 2006 16:41:17 +0200
Received: from tigra.home (E67iiQZJQeQB4jqf3kAUHoVYhRkeMPTXRdm4j2a8XgaKtysolso+0s@[84.160.102.60]) by fwd29.sul.t-online.de
	with esmtp id 1FhSdk-0LslJA0; Sat, 20 May 2006 16:41:12 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0DBD6277B5;
	Sat, 20 May 2006 16:41:12 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FhSdj-0002YE-QX; Sat, 20 May 2006 16:41:11 +0200
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605142057220.10680@mundungus.clifford.ac>
User-Agent: Mutt/1.5.6i
X-ID: E67iiQZJQeQB4jqf3kAUHoVYhRkeMPTXRdm4j2a8XgaKtysolso+0s
X-TOI-MSGID: 8e2ffd72-8299-4c78-996a-2dc07e4430c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20382>

Ben Clifford, Sun, May 14, 2006 22:58:33 +0200:
> From: Ben Clifford <benc@hawaga.org.uk>
> Date: Sun, 14 May 2006 21:34:56 +0100
> Subject: [PATCH] include header to define uint32_t, necessary on Mac OS X
> 
> ---
> 
>   pack-objects.c |    1 +
>   sha1_file.c    |    1 +
>   2 files changed, 2 insertions(+), 0 deletions(-)
> 
> 2ee926ab9da67ef2a6ca28bb70954a33d65ba466
> diff --git a/pack-objects.c b/pack-objects.c
> index 1b9e7a1..5466b15 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -10,6 +10,7 @@ #include "csum-file.h"
>   #include "tree-walk.h"
>   #include <sys/time.h>
>   #include <signal.h>
> +#include <stdint.h>
> 

BTW, Ben, how did you produce this patch? It has some unusual
indentations...
