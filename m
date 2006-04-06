From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git-clone and cg-clone
Date: Fri, 07 Apr 2006 00:14:00 +0200
Message-ID: <443592A8.4070203@iaglans.de>
References: <44355978.3080205@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 00:17:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRcmZ-0002jB-6P
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 00:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWDFWQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 18:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWDFWQc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 18:16:32 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:4109 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S932191AbWDFWQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Apr 2006 18:16:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id A66123E96
	for <git@vger.kernel.org>; Fri,  7 Apr 2006 00:16:28 +0200 (CEST)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02712-04 for <git@vger.kernel.org>;
	Fri, 7 Apr 2006 00:16:23 +0200 (CEST)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 42B5A3E71
	for <git@vger.kernel.org>; Fri,  7 Apr 2006 00:16:21 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
In-Reply-To: <44355978.3080205@itaapy.com>
X-Enigmail-Version: 0.92.0.0
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18484>

Belmar-Letelier wrote:
> Since 0.17 to take benefit of cg-switch
> 
> I use:
> 
> $ git-clone  xxx
> $ cg-branch-add origin xxx
> 
> instead of
> 
> $ cg-clone xxx
> 
> becauce cg-clone did not fetch all the heads.
> 
> Is there a better way to do this ?
> 

well, first I was also using cg clone... but i also realized, that there
is only one branch being pulled from the repository.

If you use git clone, then all tags and branches will be pulled... so
everytime i start using a fresh repository and start pulling origin of
it, i use git clone instead of cg-clone.

i also use git checkout instead of cg-switch... well, i think i haven't
had a use for the effekts, cg-switch does, and always wanted git
checkout... and wondered about the files, which were missing in the
index of the new branch..

i think thats the difference between porcelain and plumbing...

Sincerly
Nicolas
