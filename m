From: Alecs King <alecsk@gmail.com>
Subject: Re: lost again on syntax change - local repository?
Date: Mon, 28 Nov 2005 14:36:25 +0800
Message-ID: <20051128063625.GA3070@localhost>
References: <861x118r9t.fsf@blue.stonehenge.com> <7v7jat2w6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 08:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgccI-0000fT-EW
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 07:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVK1Gfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 01:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVK1Gfs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 01:35:48 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:61338 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932100AbVK1Gfr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 01:35:47 -0500
Received: by zproxy.gmail.com with SMTP id 13so2388267nzn
        for <git@vger.kernel.org>; Sun, 27 Nov 2005 22:35:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mXRwNL4nvw2opforHp/MjpN+5wD8rKtBWT7F++pbJvVs51IMQ4QjsMWtu4tyZzaKat73LUimwuoq1qkleExPpZS5ChLI/0rDZvV7rgletJ0vujkDUzaMnpWc3R926/Kds9a8b+NSppw0s3DmMw0D7LC1mlDDmpc8VxOC9vTOlgI=
Received: by 10.36.5.11 with SMTP id 11mr3208118nze;
        Sun, 27 Nov 2005 22:35:47 -0800 (PST)
Received: from localhost ( [221.218.135.227])
        by mx.gmail.com with ESMTP id 36sm780316nzk.2005.11.27.22.35.44;
        Sun, 27 Nov 2005 22:35:46 -0800 (PST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7jat2w6u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12853>

On Sun, Nov 27, 2005 at 09:11:37PM -0800, Junio C Hamano wrote:
> 	$ echo >.git/remotes/origin <<EOF
          ^^^^ you probably meant 'cat'. :)
> 	URL: /path/to/remote.git/
>         Push: master
>         Pull: master:origin
>         EOF
> 	$ git push origin

-- 
Alecs King
