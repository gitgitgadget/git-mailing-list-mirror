From: David Greaves <david@dgreaves.com>
Subject: Re: [RFD] Ignore rules
Date: Mon, 16 May 2005 17:05:01 +0100
Message-ID: <4288C4AD.6060004@dgreaves.com>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net> <20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com> <20050514153027.GN3905@pasky.ji.cz> <7vsm0py8vz.fsf@assigned-by-dhcp.cox.net> <2cfc4032050514181127c02e43@mail.gmail.com> <pan.2005.05.16.09.35.22.73817@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 18:24:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXiNg-0003GF-A5
	for gcvg-git@gmane.org; Mon, 16 May 2005 18:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEPQYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 12:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVEPQYE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 12:24:04 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:61319 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261733AbVEPQXu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 12:23:50 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C932CE6DA5; Mon, 16 May 2005 17:23:38 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12460-01; Mon, 16 May 2005 17:23:38 +0100 (BST)
Received: from oak.dgreaves.com (modem-780.lion.dialup.pol.co.uk [217.135.163.12])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 0DD14E6DA2; Mon, 16 May 2005 17:23:38 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DXi5V-00054V-Vo; Mon, 16 May 2005 17:05:01 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.05.16.09.35.22.73817@smurf.noris.de>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs wrote:

>Hi, Jon Seymour wrote:
>
>  
>
>>a. pushing the ignore logic into the core git tools such as git-ls-files
>>
>>b. including the current ignore .* rule as a default ignore rule that
>>can be overridden by a .gitignore file
>>    
>>
>
>I'd say YES to both.
>
>My preferred ignore file logic would be:
>
>- stop at first match (that's more efficient)
>  
>
more efficient true - but then surely 98% of the time you have to check
_all_ patterns since files aren't generally ignored.
And the ability to override earlier matches makes life much easier.
So I say no shortcuts, last pattern to match decides ignore/accept status

>- !pattern prevents exclusion of matching files
>- bash-style shell globs, except that ...
>  - a pattern that starts with / is a regexp
>  - * doesn't cross directory boundaries, but ** does
>  
>
>- I don't need a per-repository (i.e. non-checked-in/propagated)
>  ignore file.
>
I agree.
But for the sake of checking a couple of files it makes sense to define
a complete set of locations.

David


-- 

