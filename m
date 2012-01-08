From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] revert: allow mixing "pick" and "revert" actions
Date: Sun, 8 Jan 2012 15:40:42 -0600
Message-ID: <20120108214042.GR1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-5-git-send-email-artagnon@gmail.com>
 <20120108194014.GI1942@burratino>
 <CALkWK0mYbBsZN1UX9YM0VWQezZsBpJCcEgKirCggtNXs0HZ-8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk0P0-00019h-Hb
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab2AHVff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 16:35:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39542 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab2AHVff convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 16:35:35 -0500
Received: by iaeh11 with SMTP id h11so5770536iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 13:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lX5f57Z3iAnl56+LSx2y/olMYQfecoYV5g6VcXAfz+g=;
        b=CV++YIGVu5yY7wbqSU+2WFBC50Sve3bhoM69yKkl3TPMi+CzCWf6fEKRSLLQYjBIbj
         2SKvr6PGZy7qnr4cr4fkhRK4UBLyCdXWdh3h6ZL7IeS3FJyhskLduij98tYMxfOI9GXG
         tTXbe1YlKWcL5fj9+HAuIvyRHFd9r+yVh3p/8=
Received: by 10.42.153.6 with SMTP id k6mr13406826icw.30.1326058534445;
        Sun, 08 Jan 2012 13:35:34 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id rc7sm12281725igb.0.2012.01.08.13.35.33
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 13:35:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mYbBsZN1UX9YM0VWQezZsBpJCcEgKirCggtNXs0HZ-8g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188142>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Yes, I've always liked this one.
>>
>> Haven't re-read the patch to avoid wasted effort if there are change=
s
>> when the previous patches in the series change. =C2=A0Maybe it would=
 be
>> possible to send as a standalone?
>
> If I don't get manage to get the series right in a couple of re-rolls=
,
> I'll do that.

Splitting out unrelated changes (or at least putting the uncontroversia=
l
ones near the front) is part of getting a series right.  I'll pick up
this patch, play around with it and send separately.
