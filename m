From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 6 Sep 2005 12:13:29 +1200
Message-ID: <46a038f90509051713389c62c8@mail.gmail.com>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 02:15:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECR6Y-00054S-SH
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 02:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVIFANf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVIFANf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 20:13:35 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:64521 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964936AbVIFANe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 20:13:34 -0400
Received: by rproxy.gmail.com with SMTP id i8so754614rne
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 17:13:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZxzArnWlFfz/vfsIQ5ASm4HHfZIyPhG3lva6AiZNpmdW7ysAEsjFE9rjgJGJzE33rS++/pUlUDtf4ibhKOQ4HagVmraHKFb7RP3mxRDT4LyVmjbyh6psuWM+YgPDar4Lr78+30/ZcezeO2MJdN5Vg+QEf77+UJtUzG7xdtajlqo=
Received: by 10.38.101.47 with SMTP id y47mr369704rnb;
        Mon, 05 Sep 2005 17:13:29 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 5 Sep 2005 17:13:29 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8120>

On 9/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Grepping for strings.
> 
> For example, when renaming a binary, the sane way to check that you fixed
> all users right now is
> 
>         grep old-binary-name *.c *.h *-scripts
> 
> and you catch all users.

Grep knows how to ignore binary files. Try:

   grep -I git-commit *

cheers,


martin
