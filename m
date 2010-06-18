From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: git pull (Your local changes to ... would be overwritten by  merge)
Date: Fri, 18 Jun 2010 09:44:27 +0200
Message-ID: <BFBC3418-44C5-484D-8508-60813675409D@gmail.com>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com> <AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com> <4C19FBF8.6010709@drmicha.warpmail.net> <vpq4oh1zzfs.fsf@bauges.imag.fr> <AANLkTinWS0zWhh0d-yrb7eWMEeQenoAF8tA6-l9BRP_q@mail.gmail.com> <4C1A0DCD.2070906@drmicha.warpmail.net> <vpqbpb9ofby.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Daniel Blendea <bdaniel7@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 18 09:44:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPWFi-0005Sz-Ua
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 09:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972Ab0FRHod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 03:44:33 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:54004 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0FRHoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 03:44:32 -0400
Received: by wwb18 with SMTP id 18so559766wwb.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=Je5021lU//N9dwaVUIVAv2kbxgkzyRUb41vHgMBtTUA=;
        b=J0pB2D2TYGUREU5dLmT3ktE10a1PSyrfyGFpEkisHmNJdLjFaH1MbRgvdE8EtAZ3Au
         +DtOJOAX+GPsA2p4IKxeLmkvZzZO87+ER5pf808cr61EOP4hxwZtPuitsPV2+wMxB9xx
         g9NZFE5GwUeLTQ8TLcAe2kGaToheo6x9/ZNyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=NNqV1F9JFbw/SR0V8oZA5x78iX/xWhqG7nid2FR7NUkZJc3D43lqO491nZ58htqlJv
         aCQybzqOfCouPoDBENd6yDJfNR8rt7X+8aiMinC5XRXebU1QQZNlN+//RA/DajQ/i8QK
         2abeUsIgIu3Efi/05PNxe6yTZBdD4qMiLgQUU=
Received: by 10.227.151.77 with SMTP id b13mr656381wbw.13.1276847069898;
        Fri, 18 Jun 2010 00:44:29 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id b17sm71030873wbd.13.2010.06.18.00.44.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 00:44:29 -0700 (PDT)
In-Reply-To: <vpqbpb9ofby.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149337>

On 17. juni 2010, at 17.21, Matthieu Moy wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I guess this shows that correct diagnostics is not a prerequisite for a
>> successful therapy ;)
>> 
>> (The diagnostics really indicate a work tree with local uncommitted
>> modifications.)
> 
> I'd bet for this kind of issue:
> 
> http://kerneltrap.org/mailarchive/git/2010/3/9/25215/thread
> From: Johannes Schindelin
> Subject: core.autocrlf considered half-assed
> 
> Didn't follow the outcome in details, but some patches were proposed
> to improve the situation.

Finn Arne Gangstad's "safe autocrlf" patch (c480539, currently in next) solves the problem by disabling conversion for files that contain CRs in the repository.
-- 
Eyvind Bernhardsen
