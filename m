From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 13:38:54 +0200
Message-ID: <4C1371CE.8010309@gnu.org>
References: <20100605005116.GA8774@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 13:39:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONP3Q-0001jz-Ia
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 13:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab0FLLi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 07:38:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:9715 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab0FLLi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 07:38:58 -0400
Received: by fg-out-1718.google.com with SMTP id d23so608375fga.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=U+M+7aNDHyOtjZa68fYlYM+zyWYrQVzUH79NPVN7aNA=;
        b=WLxsYAzwjk8i0UamQlgXMy8qishOh9yzkNZMbJfYUwCuvX8drq7dX+Dqn2BdEc8n+c
         fDrn03LtIdK+jNzOAloEs9ZNd9C6+3xNSa5cHjJBD4vNG5H5OQTmf18c+0F5OnUbUjal
         3PjPiPAAgUHgBfZwP46MUf9luUkwQVHVnjYzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=d50ngsUyZisr85ZBBE/3MW40MCAiec+Z5V25Ab1WD1FU0Z34VwB7I3q24mpoCvaahI
         qhxg198mUsumMq1yLPc7JeiP9sh+2fmw05M7xrLanYqnrnpyeYusFHPVS1rNukzI5pU0
         Jef/4jIyeVZujG1IyycyfGvoq39V27KxmlGrk=
Received: by 10.87.72.2 with SMTP id z2mr5268444fgk.29.1276342736569;
        Sat, 12 Jun 2010 04:38:56 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id 31sm3755971fkt.49.2010.06.12.04.38.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 04:38:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <20100605005116.GA8774@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149004>

On 06/05/2010 02:51 AM, Jonathan Nieder wrote:
> This series teaches =E2=80=98git grep=E2=80=99 to accept
>
> 	git grep -Ovi some_function_name
>
> to find all the call sites for some_function_name so they can be
> adjusted.  Dscho=E2=80=99s cover letter[1] explains it better.
>
> And in fact, Dscho did all the work here; this iteration just rebases=
 it
> on master and adds some tests.
>
> Happy hacking,
> Jonathan
>
> Johannes Schindelin (2):
>    grep: Add the option '--open-files-in-pager'

Just a nit, why not just "--open-files-in"?  It is not necessarily a=20
pager, as you cover letter shows.  Of course the shorter version works,=
=20
but I'm asking because I would like to add this option to GNU grep and =
I=20
would definitely prefer to avoid the "pager" reference.

Paolo
