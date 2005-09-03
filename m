From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PROBLEM] Checkout from cloned repository does not work
Date: Sat, 03 Sep 2005 09:49:38 +0300
Message-ID: <1125730179.29087.3.camel@localhost>
References: <84144f0205090204201f74e425@mail.gmail.com>
	 <7vpsrrgwxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 08:50:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBRr5-0002Nq-PA
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 08:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbVICGuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 02:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbVICGuV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 02:50:21 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6800 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161169AbVICGuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 02:50:20 -0400
Received: from hki2-5-1-87.hoasnet.inet.fi (hki2-5-1-87.hoasnet.inet.fi [80.221.48.135])
  (AUTH: LOGIN penberg, SSL: TLSv1/SSLv3,128bits,RC4-MD5)
  by mail.cs.helsinki.fi with esmtp; Sat, 03 Sep 2005 09:50:19 +0300
  id 0008FE3D.431947AB.00002298
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrrgwxb.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8035>

Hi Junio,

On Fri, 2005-09-02 at 11:13 -0700, Junio C Hamano wrote:
> You would need 'chmod +x git-test.git/hooks/post-update' here if
> you are allowing people to pull over http from this repository.

Aah, thanks! That fixed it for me.

On Fri, 2005-09-02 at 11:13 -0700, Junio C Hamano wrote:
> The problem is that 'git clone' does not support cloning over
> http from servers that are not properly prepared.  This 'git
> clone' exited with non-zero status with an error message, didn't
> it?

I double checked that -- no, it does not print out an error. I copied
the exact output in the original mail. 

On Fri, 2005-09-02 at 11:13 -0700, Junio C Hamano wrote:
> +[NOTE]
> +If you plan to publish this repository to be accessed over http,
> +you should do `chmod +x my-git.git/hooks/post-update` at this
> +point.

How about "must do chmod before pushing anything to this repository"? I
think I tried chmod at some point but always did it too late (i.e. after
the initial push).

			Pekka
