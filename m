From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ls-files and read-tree need core.filemode
Date: Tue, 8 Nov 2005 10:39:58 +0100
Message-ID: <81b0412b0511080139k19bb0e0ep408d936cad9ac4b8@mail.gmail.com>
References: <81b0412b0511080023k1384dc26j944e9a07987be436@mail.gmail.com>
	 <7vacgfldry.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 10:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZPxb-0003zF-FE
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 10:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVKHJkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 04:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVKHJkA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 04:40:00 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:55778 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965121AbVKHJj7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 04:39:59 -0500
Received: by nproxy.gmail.com with SMTP id q29so148237nfc
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 01:39:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mISS7IAAZKH/7jk/7i/6EncvFBW7ceg3wUZ7l9qc6L1LB+wZJtS4yOrlkk4kuWn+j7FW2nOUMGvCiBDbAhNCDlYAwXzXiS/aYIsQoe1I4TWMKMm1ZjZZHRhPiry5B7EBYuvrh5P++AxINJDQOHy2vBsH89ol9Fv0FL6FXDjxJfo=
Received: by 10.48.80.6 with SMTP id d6mr1142352nfb;
        Tue, 08 Nov 2005 01:39:58 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 8 Nov 2005 01:39:58 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacgfldry.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11319>

On 11/8/05, Junio C Hamano <junkio@cox.net> wrote:
> However, please note that git-mailinfo which splits a piece of
> e-mail into metainformation and patch part takes commit log
> material only from the main message part, so having this
> one-line explanation inside attachment is like having it under
> the three-dash line.

Noted, thanks!

> >>diff --git a/ls-files.c b/ls-files.c
> >>--- a/ls-files.c
> >>+++ b/ls-files.c
> >>@@ -569,10 +569,11 @@ int main(int argc, const char **argv)
> >>      argv0 = *argv;
>
> I wonder what this thing is, though.  I sense that usage()
> cleanup patch that makes programs state their names
> semi-automatically is coming...
>

That's just me, trying to figure out were all the errors were coming from.
Promise to try to base patches properly in the future.
