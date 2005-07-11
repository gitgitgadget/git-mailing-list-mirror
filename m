From: Darrin Thompson <darrint@progeny.com>
Subject: Re: [PATCH 2/2] Demo support for packs via HTTP
Date: Mon, 11 Jul 2005 16:49:04 -0500
Message-ID: <1121118544.3939.6.camel@localhost.localdomain>
References: <Pine.LNX.4.21.0507101555271.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:57:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6GI-0002UX-OG
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 23:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVGKVxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 17:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVGKVvY
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 17:51:24 -0400
Received: from zealot.progeny.com ([216.37.46.162]:58044 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S262801AbVGKVtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 17:49:11 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id A7DAB636AC; Mon, 11 Jul 2005 16:49:04 -0500 (EST)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507101555271.30848-100000@iabervon.org>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-07-10 at 15:56 -0400, Daniel Barkalow wrote:
> +	curl_easy_setopt(curl, CURLOPT_FILE, indexfile);
> +	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
> +	curl_easy_setopt(curl, CURLOPT_URL, url);

I was hoping to send in a patch which would turn on user auth and turn
off ssl peer verification.

Your (preliminary obviously) patch puts curl handling in two places. Is
there a place were I can safely start working on adding the needed
setopts?

--
Darrin
