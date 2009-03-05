From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git push bash completion
Date: Fri, 6 Mar 2009 00:15:39 +0100
Message-ID: <200903060015.39834.markus.heidelberg@web.de>
References: <fabb9a1e0903051430k5628fe26v4749360e026ac7d2@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 00:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfMo1-0006JH-En
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 00:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZCEXPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 18:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbZCEXPQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 18:15:16 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:40641 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbZCEXPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 18:15:14 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5DC55FE43982;
	Fri,  6 Mar 2009 00:15:12 +0100 (CET)
Received: from [89.59.104.0] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LfMmW-0005TM-00; Fri, 06 Mar 2009 00:15:12 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <fabb9a1e0903051430k5628fe26v4749360e026ac7d2@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX180OtfEd/dGRfi70JEnYKsaIloyy6hJvOh92Usp
	OeR4ZOQskkMyqXGULppfvKQeLvaZNX+q+gJtEDrEak8Pf/6UTK
	bzyiOpVLV8bIN0iUwaEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112358>

Sverre Rabbelier, 05.03.2009:
> Heya,
> 
> Observe:
> $ git push ori<tab>
>   git push origin
> 
> $ git push -f ori<tab>
>   git push -f origin/
> 
> Something weird going on there, or is this intentional and am I
> missing something?

Something similar happens with fetch and pull. They only complete the
remote name, when exactly 2 words are existing on the command line
("git" and the subcommand) by: if [ "$COMP_CWORD" = 2 ]

Doesn't seem right.

Markus
