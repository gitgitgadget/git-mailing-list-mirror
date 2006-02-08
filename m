From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: git + ssh + key authentication feature-request
Date: Wed, 08 Feb 2006 23:42:11 +0100
Message-ID: <43EA73C3.2040309@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 08 22:43:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6x5o-0004Y8-S7
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 22:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWBHVnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 16:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBHVnO
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 16:43:14 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:9733 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S932078AbWBHVnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 16:43:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id AA9323E9D
	for <git@vger.kernel.org>; Wed,  8 Feb 2006 22:43:11 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28003-07 for <git@vger.kernel.org>;
	Wed, 8 Feb 2006 22:43:10 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 66E573E51
	for <git@vger.kernel.org>; Wed,  8 Feb 2006 22:43:09 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15753>

Hi guys,

first of all, great work.

I just discovered git and i like it.

I would like to ask if it is possible to use ssh keys to authenticate 
via ssh on a git repository via git-pull/git-push. Since ssh supports 
them, wouldn't it be nice to use them in git, too?

The layout would be following:

you have a system user with a git-shell and several keys in 
.ssh/authorized_keys ... these are the keys of your contributors. They 
are allowed to login and work with the repository.

I haven't found a posibility to get this. Maybe I haven't discovered it, 
yet...

Sincerly
Nicolas
