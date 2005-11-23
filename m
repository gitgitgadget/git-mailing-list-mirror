From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Allow editing of a revert-message
Date: Wed, 23 Nov 2005 11:42:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511231141030.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511230954440.13959@g5.osdl.org>
 <7v7jaz5fj7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 20:43:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0Vo-0001qv-IX
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKWTm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVKWTm1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:42:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932246AbVKWTmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 14:42:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jANJg2nO005279
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 11:42:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jANJg01T019646;
	Wed, 23 Nov 2005 11:42:01 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jaz5fj7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12644>



On Wed, 23 Nov 2005, Junio C Hamano wrote:
>
> I think we can do
> 
> 	-e)
> 		edit="-e" ;;
>         ..
> 
> 	git-commit -n -F .msg $edit
> 
> to lose the ${EDITOR-${VISUAL-vi}} part..

You are of course right. That would also fix the total idiocy of my patch 
that had you editing the message even if it wasn't used due to a "-n" that 
disables commits ;)

		Linus
