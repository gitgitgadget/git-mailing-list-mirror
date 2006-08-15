From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Tue, 15 Aug 2006 09:40:06 +0200
Message-ID: <81b0412b0608150040m422e695fl68650dad6b692533@mail.gmail.com>
References: <20060814075305.GH21963@mellanox.co.il>
	 <20060814175523.GC16821@mellanox.co.il>
	 <7vk65bdm9f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 09:40:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCtXE-0007qR-Ed
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 09:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWHOHkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 03:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbWHOHkK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 03:40:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:18191 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965241AbWHOHkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 03:40:08 -0400
Received: by nf-out-0910.google.com with SMTP id x30so239428nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 00:40:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qwOLMGWuPKRZEcvYcwts7sKLYcHM3HfxvfnUGggKq45Wr5YeSWxhd/hZd6dmdSU35bFDnd98Yt2qn+IrsTtEuUoWUW81jbAvZemwdPpVz920Q9BVvnZsMrzHi+nD0VkzDGRg/BX6c9bbMOOBdXY6YyaGvnUO0JpXCAwg8JQvVfI=
Received: by 10.48.163.19 with SMTP id l19mr882873nfe;
        Tue, 15 Aug 2006 00:40:06 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Tue, 15 Aug 2006 00:40:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vk65bdm9f.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25441>

On 8/14/06, Junio C Hamano <junkio@cox.net> wrote:
>  - when dealing with the refspecs from the shorthand
>    (.git/remotes), the one on the first "Pull: " line is for
>    merge and everything else is not.

What happens if you have _many_ refspecs in a "Pull:"-line?
