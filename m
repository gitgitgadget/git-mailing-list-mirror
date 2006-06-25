From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: On boolean configuration variables...
Date: Sun, 25 Jun 2006 13:33:26 +0000 (UTC)
Message-ID: <e7m3b6$eoa$1@sea.gmane.org>
References: <7vy7vmviul.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jun 25 15:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuUk7-0003PC-9y
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 15:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWFYNde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 09:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWFYNde
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 09:33:34 -0400
Received: from main.gmane.org ([80.91.229.2]:53125 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750790AbWFYNde (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 09:33:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FuUk0-0003P1-Fd
	for git@vger.kernel.org; Sun, 25 Jun 2006 15:33:32 +0200
Received: from mail.globalcapital.cc ([80.85.66.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 15:33:32 +0200
Received: from wildfire by mail.globalcapital.cc with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 15:33:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.globalcapital.cc
User-Agent: pan 0.98 ("The plain old chaos of undifferentiated weirdness.")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22622>

On Sat, 24 Jun 2006 05:28:02 -0700, Junio C Hamano wrote:

> Boolean configuration variables in $GIT_DIR/config are a bit
> strange.
> 
> 	[bool]
>         	var1
>                 var2 =
>                 var3 = true
>                 var4 = yes
>                 var5 = 1
>                 var6 = 2
>                 var7 = false
>                 var8 = no
>                 var9 = 0
> 
> var1, var3, var5, and var6 are "true"; var2, var7 and var9 are
> "false".  var4 and var8 are syntax errors.
> 
> Currently "git repo-config --bool --get bool.var1" returns
> "false", which is fixed by the attached patch, but I am
> wondering if it is a good idea to allow "yes" and "no" as well.
> 

Allowing 'yes' and 'no' to equal 'true' and 'false' respectively sounds
pretty sane and user-friendly.

Why wouldn't you want to do that?

Anand
