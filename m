From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 13:45:46 +0100
Message-ID: <bd6139dc0901150445l51f3b861n5bbd85bb6d1382b6@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
	 <496EE74F.6000205@viscovery.net>
	 <200901151101.53441.johan@herland.net>
	 <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
	 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 13:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRku-0003cC-J0
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbZAOMyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 07:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZAOMyA
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:54:00 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:54842 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbZAOMx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:53:59 -0500
Received: by yx-out-2324.google.com with SMTP id 8so442280yxm.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=d2UTs/1biWgKpITaxUX/9KX4hlxeYHUyf/+MSueAMx4=;
        b=jvuUrAguTM0JzwO/Tv17Pt8UV/yvGXM7G7BA+p/d85gEu9iG3zKw6/Go02mYgPT/0i
         syYMkUvioFyXh4cz7JaL67Wc70045JNruu8SVQRIPhQq+Ti29A00sAVOYfw7QQ+bggm0
         T+FLReU9U5kk4ifqqxOl7yzWUOI2R45+Qq1PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=frmMQYBTYLml7Zivlp/2n0s2ILmIhqyvbvX3rku1nQAjxGIHRkWswKbVBQBAnGjEfH
         GvX3tZs/A7BbTqoX+sO3KvZdeDiRjQYlkgMJHHu12MFzbYPoXWZ1pDLIizaKQKxmJ9SY
         WFLYfYnIV+ILxJZ+NuWRikBmhDwdO+9Jw5dZY=
Received: by 10.151.156.7 with SMTP id i7mr3970970ybo.69.1232023546596;
        Thu, 15 Jan 2009 04:45:46 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 04:45:46 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: c5cc1794097a6d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105786>

On Thu, Jan 15, 2009 at 13:36, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If at all, I'd introduce 'examine' as a synonym to 'edit' (might be more
> intuitive).

Examine suggests that you cannot change the commit (you can look, but
don't touch it!), no?

> However, for the same reason (is it intuitive?) I am not fully convinced
> of 'amend' either.  Because --amend _can_ mean that you change the
> diff of the commit.  Maybe 'correct', 'redact' or 'rephrase'?

OTOH, when you have no changes staged "git commit --ammend" will do
exactly that, it will let you edit the commit message of the last
commit.

> BTW I was not fully happy with 'edit' back then, either, which is the
> reason why I showed the usage in the comment _above_ the commit list.  But
> nobody could suggest a name that I found convincingly better.

The coder's law #349: "The hardest part of writing new functionality
is coming up with a proper name that everyone agrees on".

-- 
Cheers,

Sverre Rabbelier
