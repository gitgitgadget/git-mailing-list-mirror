From: Tony Luck <tony.luck@gmail.com>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 15:39:55 -0700
Message-ID: <12c511ca0510191539w3dd76f89ra5fe48e1d84750d6@mail.gmail.com>
References: <4356A5C5.5080905@zytor.com> <20051019222044.GP30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 00:40:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESMbI-0007mw-Fm
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbVJSWj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbVJSWj4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:39:56 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:61033 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751586AbVJSWj4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 18:39:56 -0400
Received: by qproxy.gmail.com with SMTP id v40so204316qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 15:39:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VY/gdgmR9MHB//B2ZUVIPATb4IbiI9ckgrKaUEPGEaO3dnBmwv6YU55GnjqNMBplF0qiYvtMPvdkP7RryYU5nSTZC+122HDL2DIR/fOEMuNeNUimWnX4YJUFjSgznhDtM4xB8TsTKA3UR5dY9pVxudVg+dv8R+UyawcX9TuPBG0=
Received: by 10.64.156.18 with SMTP id d18mr950085qbe;
        Wed, 19 Oct 2005 15:39:55 -0700 (PDT)
Received: by 10.64.243.14 with HTTP; Wed, 19 Oct 2005 15:39:55 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051019222044.GP30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10322>

On 10/19/05, Petr Baudis <pasky@suse.cz> wrote:
> [client]        git-upload-pack <path>
> [server]        challenge somethingnonsensical
> [client]        challenge-response <username>:sha1(somethingnonsensical<password>)
> [server]        All right, the pack goes like this...

I think this requires that the server store the cleartext version of
the password so
that it can validate sha1(somethingnonsensical<password>) ... which is generally
thought to be a bad idea.

-Tony
