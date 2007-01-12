From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.5.0.rc1.g4494: Can't use a bare GIT_DIR to add
Date: Fri, 12 Jan 2007 09:33:20 -0800
Message-ID: <7v7ivsup3z.fsf@assigned-by-dhcp.cox.net>
References: <200701121545.l0CFjMC1017088@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 18:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5QHO-0002w8-4l
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 18:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbXALRdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 12:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbXALRdW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 12:33:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50130 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964784AbXALRdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 12:33:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112173321.SUGM97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 12:33:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AHYV1W00F1kojtg0000000; Fri, 12 Jan 2007 12:32:30 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701121545.l0CFjMC1017088@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Fri, 12 Jan 2007 12:45:22 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36682>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> I tried this:
>   
>   mkdir xyz
>   cd xyz
>   git --git-dir=../xyz.git   
>      # Initialized empty Git repository in ../xyz.git/
>   echo Junk > file-a
>   git --git-dir=../xyz.git add .
>      # fatal: add cannot be used in a bare git directory
>
> I expected that "GIT_DIR is bare, over there, stuff is here" works the same
> as "GIT_DIR is .git, right here among stuff".
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                    Fono: +56 32 2654431
> Universidad Tecnica Federico Santa Maria             +56 32 2654239
> Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
