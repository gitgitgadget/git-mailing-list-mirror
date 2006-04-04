From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Tue, 4 Apr 2006 14:16:32 +1200
Message-ID: <46a038f90604031916r4651b572lb9bae4c5a3d47bc9@mail.gmail.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
	 <1144116459.2303.129.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 04:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQb5w-0002Hd-4l
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 04:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWDDCQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 22:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWDDCQd
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 22:16:33 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:5657 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964958AbWDDCQd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 22:16:33 -0400
Received: by wproxy.gmail.com with SMTP id i22so1402444wra
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 19:16:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lt/eZgQg3LjyMLblwAiNYkxv5hVyKWZN88pOgkD5mb9xW/K+hpPNCu6hvDMuBCGkeYV+4uR38euZmEFvL3GTLT9SQVToQDPnIJzyGGvohQuHQJwYuok3VAM5W4JRaNnZMrC/f887ekVn52752cCl5nZcMi8Bc6guCQZcPGNnyCA=
Received: by 10.54.116.1 with SMTP id o1mr3808528wrc;
        Mon, 03 Apr 2006 19:16:32 -0700 (PDT)
Received: by 10.54.72.7 with HTTP; Mon, 3 Apr 2006 19:16:32 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1144116459.2303.129.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18371>

On 4/4/06, Keith Packard <keithp@keithp.com> wrote:
> Trust me, it wasn't because I wanted to replace git-cvsimport; it's
> solely that cvsps was generating complete garbage for most of my
> repositories.

Oh, I don't mind -- we may as well bury cvsimport but I can't do C
like I can do Perl, and I surely want to help on this one.

> My new tool isn't perfect yet; it isn't getting exactly the expected
> answers for the postgresql repository, but it's working perfectly for my
> X server one.

Meh, had you done it in Perl, I'd be helping you with the Pg repo,
attic files and ensuring that files created on a branch and then put
into HEAD are handled gracefully. (But you'll get Linus' and Junio's
attention. Smarty cookie.)

Does it run incrementally? Can it discover non-binary files and pass -kk?

cheers,


martin
