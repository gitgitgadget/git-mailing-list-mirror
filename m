From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Problems getting git-send-email to work
Date: Mon, 12 May 2008 11:18:47 +0200
Message-ID: <bd6139dc0805120218m4acf370m81475526f7237084@mail.gmail.com>
References: <402c10cd0805111901q2e934e44w45938ca4a85f240b@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 11:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUCU-0001FR-UW
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 11:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbYELJSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 05:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbYELJSy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 05:18:54 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:15582 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbYELJSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 05:18:53 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2235172wfd.4
        for <git@vger.kernel.org>; Mon, 12 May 2008 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FZXaO2qet5u9BO68vtzMvUKWdzpl2emRHkZ/X9WJLRE=;
        b=NbLLy9ft7t1gk9+sclXzCsZqZYpmXgwP/yNoxdNDSO8UHo1dJNIgPRMwxjrjyq/X+RvIvpjxXs8hXs0VDjGg36CYGe5DrqsguLQI2Baorf/H2AgZIPyK3GOuV8eiIu/+CBlTHSFytRiXJKpuSjDCgCoZPKG18InyY7iIUpojKUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NeHIHQlS0yLWnXXYhnaP7DNCvDTXlCDLjRB0evpXQKlAUl8zPd9K9LEIopmLi3pE+xWuu6e6tQoMdN+PYBj2wwofJ2vKkHzKT+31551rnLC/K4Babkr7ZikIBcxLzw2qB8R4FOs2v0fZ3u0d79gzN7NOJJ2q4RlgxBF497103c8=
Received: by 10.143.3.7 with SMTP id f7mr456053wfi.303.1210583932710;
        Mon, 12 May 2008 02:18:52 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 02:18:47 -0700 (PDT)
In-Reply-To: <402c10cd0805111901q2e934e44w45938ca4a85f240b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81840>

On Mon, May 12, 2008 at 4:01 AM, Sverre Hvammen Johansen
<hvammen@gmail.com> wrote:
> I am having trouble getting git send-email to work:
>
> [sj@black patches]$ git send-email --smtp-server=smtp.gmail.com
> --smtp-user=hvammen@gmail.com --smtp-ssl --to=hvammen@gmail.com

<snip>

> Command unknown: 'AUTH' at /usr/local/bin/git-send-email line 744,
> <STDIN> line 1.

Heya,

I  get the exact same error when I try to send an e-mail like that
through git-send-email. I resolved to sending the mail through my ISP
without supplying a username/password. That is, all I did was
configure: sendemail.smtpserver=smtp.myisp.nl  If you find a solution
to this I'm interested in hearing how you solved it :).

-- 
Cheers,

Sverre Rabbelier
