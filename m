From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cg-fetch: handle tags with funny chars, retrieve missing commits
Date: Thu, 20 Oct 2005 18:05:58 +1300
Message-ID: <46a038f90510192205jd4f3a12j60799f043ee31f85@mail.gmail.com>
References: <11297835242417-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 07:07:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESScu-0000LP-0N
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 07:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbVJTFGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 01:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbVJTFGA
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 01:06:00 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:14421 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751751AbVJTFF7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 01:05:59 -0400
Received: by qproxy.gmail.com with SMTP id v40so254325qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 22:05:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fd+0wwNLfijBFj0n0XOVXqqvjFlQq6yffKpm5oLnF9yuL0Z6+4gxLBB5VGnVp5OgixeeMB2Gqc1u6tVR8IPnJVQbm0xX6rNonus7Tiq/kem9lS6AXjHRhPLWU1eWZFNAWjy/tZSyZNT9uJGyRuk4Tq4peK01reQKa05uzCwB03k=
Received: by 10.64.242.2 with SMTP id p2mr1204406qbh;
        Wed, 19 Oct 2005 22:05:58 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 22:05:58 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <11297835242417-git-send-email-martin@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10349>

Pulled, superceded by new version.

On 10/20/05, Martin Langhoff <martin@catalyst.net.nz> wrote:
>  + handles tags with funny chars a bit better
>  + will check tagrefs, trying to ensure it actually has the relevant
>    commits. If the commits are missing, it'll go out and fetch them.
>
> This isn't a complete solution for cg-fetch -- git-fetch is actually
> much smarter now, and cg-fetch should perhaps be a thin wrapper
> around it, dropping all the duplicate code.
>
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
