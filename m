From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 23:17:31 +0100
Message-ID: <CA+EOSBmTjwmf+dO-dgU+rGQaVEKDZw7u9ujrh5jYZkPM2zisOA@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<CA+EOSB=Rr8czjVJfA+F6DmHjDUBy0QQ-wd4t-3Uwb1Ksoadr0Q@mail.gmail.com>
	<20121030070152.GA13324@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:17:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTK84-0001ac-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757848Ab2J3WRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:17:34 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38402 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919Ab2J3WRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:17:32 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so568270iag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=J5vsc4mc3o8kYYY0+1QoYCAGtyqhCxLBOn5i5AECNLI=;
        b=U3gGZ4YrupztFJDNc3Na398/dYXUlKtSlKXLtS98cQZSTNyYjJilM8BlVNUfYrGe6E
         oXaU1BzRkJzrD7TxJNSjYJ4qyLgHlFgrkNpIL4SmcneJLe67qPF0NjxGocBe7FZ1OYUC
         4zE/uhoDvIQm6uTdM/a3DGSx6cHTsIBxwkuKYIGyftevQ2Mo23s/KAINJ6i5UGzZ/MnY
         iBxtXKM2HLKcDOOOmrb76JYGApjzG6U6+WQu4UUGNzrtSnEyXzwd8yt1E5MKozipBa+g
         tPktQ7oAmiPMLrROUTldTg6/1T39XEtzopuUG3wxD403OQfisU9nzTt4r4kGZHnvX6uN
         kJ2Q==
Received: by 10.50.7.135 with SMTP id j7mr2918608iga.34.1351635451764; Tue, 30
 Oct 2012 15:17:31 -0700 (PDT)
Received: by 10.64.176.237 with HTTP; Tue, 30 Oct 2012 15:17:31 -0700 (PDT)
In-Reply-To: <20121030070152.GA13324@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208758>

Thanks. I know that posix support these usages, but exists some
traditional shell that not support it. These are described in the
autoconf manual, last time i have checked. As the construct ; export
var = x should be portable, but it is not. If this is important these
days i don't know.


Best

2012/10/30, Jonathan Nieder <jrnieder@gmail.com>:
> Elia Pinto wrote:
>
>> The shell word splitting done in base is a bashism, iow not portable.
>
> No, ${varname##glob} is in POSIX and we already use it here and there.
> See Documentation/CodingGuidelines:
>
>    - We use ${parameter#word} and its [#%] siblings, and their
>      doubled "longest matching" form.
>
> Thanks for looking the patch over.
> Jonathan
>

-- 
Inviato dal mio dispositivo mobile
