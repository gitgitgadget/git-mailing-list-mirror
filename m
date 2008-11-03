From: "David Syzdek" <syzdek@gmail.com>
Subject: Re: [PATCH] Make Pthread link flags configurable
Date: Mon, 3 Nov 2008 09:18:42 -0900
Message-ID: <9a0027270811031018t2b90ee64kcd2ef5e9afa73f6a@mail.gmail.com>
References: <1225669400-79505-1-git-send-email-david.syzdek@acsalaska.net>
	 <m3hc6pf8k6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:20:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx41s-0002JZ-TF
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbYKCSSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYKCSSo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:18:44 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:12406 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYKCSSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:18:43 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1161960rvb.4
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fQhD2cP3532XRTqurr92C0IPBB8mrsCO+DuodheRXrY=;
        b=vLcJLZPI6DiaKVw1mw+y0Ka0U2QfdApH11XZCoYfBgb5xdNAu6/jA+fL4teWtLhDuV
         2OKmTRxjIJxqnbH3x8o4fAr27dtbXksmwZvmIEUErEzxh/dHwc2SxnpWQs+Z4dd2+sxt
         /oSSnPusjNDleoZb5xys7LuaN9emTxGui/KzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UWhlfx1UVK1WRZ4/XwA1NlWbUlgMiBuLED6xFHHsQ2H4VV8D8lp29IeiXO4CshlV8t
         N/An2N4LDbXo91MvYAXyIf/qb4AIfFGnynPc9iZ9GlSBu8rLgLfzgjrCH0ZU9tAvLaxd
         YS1+n4Gq4ESGswgIYiu717gN5q0bcpCSJxsbc=
Received: by 10.141.42.10 with SMTP id u10mr253491rvj.141.1225736322567;
        Mon, 03 Nov 2008 10:18:42 -0800 (PST)
Received: by 10.141.77.7 with HTTP; Mon, 3 Nov 2008 10:18:42 -0800 (PST)
In-Reply-To: <m3hc6pf8k6.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99969>

On Mon, Nov 3, 2008 at 12:44 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> david.syzdek@acsalaska.net writes:
>
>> From: David M. Syzdek <david.syzdek@acsalaska.net>
>>
>> FreeBSD 4.x systems use the linker flags `-pthread' instead of the
>> linker flags `-lpthread' when linking against the pthread library.
>>
>> Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
>> ---
>>  Makefile |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> Would it be possible to add support for this also to configure.ac
> (and config.mak.in)?
>

I just sent a patch to the list that adds autoconf tests for pthreads.
 If the test is able to determine which flag to use, then it also sets
THREADED_DELTA_SEARCH.
