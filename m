From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Wed, 25 May 2016 00:12:55 +0200 (CEST)
Message-ID: <925654601.13199.1464127975010.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr> <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr> <xmqqmvnf46on.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5KSm-0006Zj-N9
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbcEXWGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:06:03 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57720 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075AbcEXWGC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 18:06:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B3A4D24DE;
	Wed, 25 May 2016 00:05:57 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzHtG0WGArzT; Wed, 25 May 2016 00:05:57 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 981B224BB;
	Wed, 25 May 2016 00:05:57 +0200 (CEST)
In-Reply-To: <xmqqmvnf46on.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: userdiff: add built-in pattern for CSS
Thread-Index: uT18JBGjWBkwhrhKMNKvEiY0IQE+rA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295536>

> It is not a big deal for a small single-patch topic like this, but
> it often is hard to reviewers if you do not respond to comments you
> received and instead just send a new version of the patch with
> "changes since..." comment.  Please make it a habit to do both.

Apologies, I am not quite used to work with a mailing list yet, I
will make sure to respect this in the future!
 
>  - Have you considered using IPATTERN()?  PATTERNS() that defaults
>    case sensitive match is suitable for real languages with fixed
>    case keywords, but the pattern you are defining for CSS does not
>    do anything special for any set of fixed-case built-in keywords,
>    and appears to be better served by IPATTERN().

I did have considered IPATTERN(), but assumed that case-sensitive was
default and case-insensitive was the exception. As the CSS pattern
does not deal with letters at all it seemed sensible to me to follow
the example of the HTML pattern, which use PATTERNS().

>  - In our codebase, we format multi-line comments in a particular
>    way, namely
> 
> 	/*
>          * A multi-line comment begins with slash asterisk
>          * on its own line, and its closing asterisk slash
>          * also is on its own line.
>          */

I take good note of that. I took example on the fortran pattern
comment, should I fix it too while I'm at it?
 
>  - Try not to write overlong lines.  If your expression needs to
>    become long and there is no good place to fold lines, that is one
>    thing, but an overlong comment is unexcuable, as you can fold
>    lines anywhere between words.

Again, I take good note of that.

Thank you for your time!
