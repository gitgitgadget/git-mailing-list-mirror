From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of name
Date: Thu, 21 Oct 2010 13:05:25 -0500
Message-ID: <20101021180525.GA11501@burratino>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org>
 <1287535323-20347-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:09:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8zZo-0003ql-1V
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab0JUSJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:09:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49764 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0JUSJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 14:09:14 -0400
Received: by vws13 with SMTP id 13so1540vws.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p/z8oYsFpP/8iMlBnLxUrDbzHk1/WGpCZhJnz/PQHEI=;
        b=lEBnMs53u6tLtlswfs2NmHFkSLdNJBoaOMMUBFbygvZNyQ5BiChfwfn+qK6JddWe2i
         i2noDK4blbs3wMyw0H1VNu1r19As7CcJ7xNRAhEzWM362oxtKwcar92/B4RycZ6fCTik
         l3sYjA2D9BGiJe5B/03GGlNzDkEqKbCvH5uhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mkHt3IgdLg7oBe3s+qr8bkRZ/yr5hQlwM0LFDbrfXJZwBfp9i/p/FYj8unQKVMDuT1
         5W24bmGbxR9WiLaJ613jWOW59yMIpTw8A2ykfW8NIvd22PWDH3I0wNjmuKQsXI6eF4S1
         vFDDy5eogLC4I74CrH8u70WaIrCITrbZ2ERsA=
Received: by 10.103.181.7 with SMTP id i7mr1920633mup.135.1287684552656;
        Thu, 21 Oct 2010 11:09:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k4sm973204faa.32.2010.10.21.11.09.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 11:09:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287535323-20347-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159529>

Kevin Ballard wrote:

> +++ b/t/t8002-blame.sh
> @@ -6,4 +6,9 @@ test_description='git blame'
>  PROG='git blame -c'
>  . "$TEST_DIRECTORY"/annotate-tests.sh
>  
> +PROG='git blame -c -e'
> +test_expect_success 'Blame --show-email works' '
> +    check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1
> +'
> +

Bonus nit: does this belong in annotate-tests.sh or does it only apply
to "git blame" and not "git annotate"?  If the latter, a note in the
commit message would be helpful.

Thanks for your work.
