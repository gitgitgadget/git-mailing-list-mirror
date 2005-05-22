From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 20:42:37 +0200
Message-ID: <20050522184237.GG18500@cip.informatik.uni-erlangen.de>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net> <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 20:42:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvO9-0001jv-1P
	for gcvg-git@gmane.org; Sun, 22 May 2005 20:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVEVSml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 14:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEVSmk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 14:42:40 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:26840 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261437AbVEVSmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 14:42:39 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MIgcS8023381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 18:42:38 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MIgbu5023380
	for git@vger.kernel.org; Sun, 22 May 2005 20:42:37 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

>  - in all other cases: if the file is new, prepend a "+", if the file is 
>    old, prepend a "*", and if the file goes away, prepend a "-". In other 
>    words, the actual pathname (if it exists) always starts at the second
>    character and is always prepended by _something_ (ie there is no 
>    ambiguoity with pathnames that start in -/+/*).

I guess that this is only on human readable but not on the machine
format, right?

> What do you think?

Sounds good. Especially that we keep the fixed fields for the machine
parsable stuff.

	Thomas
