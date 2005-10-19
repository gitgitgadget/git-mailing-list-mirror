From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Hard-linked trees with git?
Date: Wed, 19 Oct 2005 13:23:52 +0200
Message-ID: <m3irvt21iv.fsf@defiant.localdomain>
References: <m3vezufujo.fsf@defiant.localdomain>
	<7vpsq2pmyl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 13:27:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESC3S-0001CX-2W
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 13:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVJSLYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 07:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVJSLYI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 07:24:08 -0400
Received: from khc.piap.pl ([195.187.100.11]:32772 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750766AbVJSLXy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 07:23:54 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 6AE5A10A61; Wed, 19 Oct 2005 13:23:52 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsq2pmyl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 18 Oct 2005 13:52:18 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10286>

Junio C Hamano <junkio@cox.net> writes:

>> Or: is it possible to have some constant file timestamps, so that
>> changing the HEAD to something and returning to the old HEAD
>> (say, with hard resets) restores the old timestamps?
>
> That would screw up 'make'.

Not if the old timestamps matched the old files and if you make sure
you don't mix different branches with one object tree (i.e., you always
switch to correct HEAD before building).
-- 
Krzysztof Halasa
