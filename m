From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling, textconv_object()
Date: Mon, 31 Oct 2011 18:57:04 +0100
Message-ID: <CAHGBnuPN9z_yntJPqGOWVFWc7PteWMfC8HV9UZoEYN-Z56xwyQ@mail.gmail.com>
References: <4EAACA1C.6020302@gmail.com>
	<7vlis5t8bf.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com>
	<7vhb2tt6ag.fsf@alter.siamese.dyndns.org>
	<CAHGBnuNpwZCpQxZQNRZ-pYpLMHMi1O4d0hsR9MKM3=7Hw5A=zw@mail.gmail.com>
	<7vd3dht4ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 18:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKw6j-0005MQ-Nu
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 18:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933624Ab1JaR5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 13:57:06 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34880 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933567Ab1JaR5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 13:57:05 -0400
Received: by vcge1 with SMTP id e1so5026983vcg.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Kix4fkoOUChGlKHum7TBZc6W4z3Gv7a4fGZ/SvF7/M8=;
        b=m5e+q1QCx9AFKXqYaYOcj/jZ8zEYvQXgENvmVd6KdW4jbPu++o9xVUdRtBHLSZPfTV
         qVNVj0WPXKNXb51MKfdEaUDYAIU/gtKrgdU6fQSOzwwLwCSNxVuVpSM7vPLvsbTHq7Ci
         mjVkIf8Teu/wHTorfnTCq8JLplWx9j6ufeR1s=
Received: by 10.220.142.73 with SMTP id p9mr2564594vcu.157.1320083824544; Mon,
 31 Oct 2011 10:57:04 -0700 (PDT)
Received: by 10.220.175.202 with HTTP; Mon, 31 Oct 2011 10:57:04 -0700 (PDT)
In-Reply-To: <7vd3dht4ms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184510>

On Fri, Oct 28, 2011 at 19:20, Junio C Hamano <gitster@pobox.com> wrote:

>>>>> Thanks; do you have no addition to the test suite to demonstrate the
>>>>> breakage?
>>>>
>>>> Not yet. I'll try to come up with something.
>>>
>>> Let's do this.
>>
>> Thanks, but that does not seem to work for me. The test breaks both
>> without and with my patch. I'll look into it.
>
> Thanks. I suspect the difference is because you are on a crlf-native
> platform while I am not...

I've got a test now. However, that test revealed some more related
issues. I'll come up with a v2 of the patch this week.

-- 
Sebastian Schuberth
