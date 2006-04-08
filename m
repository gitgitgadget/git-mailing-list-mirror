From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: strange behavior when pulling updates / get uptodate with git.git
Date: Sat, 08 Apr 2006 23:19:10 +0200
Message-ID: <443828CE.4070707@iaglans.de>
References: <4438158C.1080208@iaglans.de> <7vmzeveqin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 08 23:22:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSKsx-00067k-Lu
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 23:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWDHVWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 17:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWDHVWN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 17:22:13 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:42507 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751429AbWDHVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 17:22:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id C51FA3E9C
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 23:22:09 +0200 (CEST)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13574-03 for <git@vger.kernel.org>;
	Sat, 8 Apr 2006 23:22:06 +0200 (CEST)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 94D4B3E71
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 23:22:05 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vmzeveqin.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18532>

Junio C Hamano wrote:
> Most likely it is aborted by the "pu" branch not
> fast-forwarding.
> 
> 	Pull: +refs/heads/pu:refs/heads/pu
> 
> or dropping "pu" altogether if you are not interested in it,
> would help.  

Thank you, the +-sign helped me out.

Sincerly
Nicolas
