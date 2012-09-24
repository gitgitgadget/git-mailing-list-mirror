From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Tue, 25 Sep 2012 00:19:04 +0530
Message-ID: <CALkWK0nzvam=VEpsBviTw3EECsz3UYiE5XR_7s1FakyGd-ZcJg@mail.gmail.com>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
 <7v8vc13ilc.fsf@alter.siamese.dyndns.org> <505F489B.1000309@web.de>
 <50607748.6000204@xiplink.com> <7v7grj1jkr.fsf@alter.siamese.dyndns.org>
 <CALkWK0mpDp652Hmgx2-KCw+SdFmFKHMLAOya=vRy-fsV_YH4MQ@mail.gmail.com> <7vbogvz2d9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: marcnarc@xiplink.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDip-0000tk-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655Ab2IXSt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:49:27 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54269 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757617Ab2IXStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:49:25 -0400
Received: by qcro28 with SMTP id o28so4597631qcr.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/+OLj3YhX2BzIfWijWIKufGztxa7QBt9tZoahzBvjr0=;
        b=SUkZbjKq7kow29aOnseymSPECzmVQQubx7Dy9piMfPt8HybIfiM6xGI3wZ0XNkJw8u
         hOrQyejdEUbb6dfPnibMx2NHJVcWmJ0CYMM2EqTTaiLAOFukyzjO8lKpKUV6flDdS1+a
         1M1Nn1LVbyeegmL+ryh/9r4SVSVYwcL5QP2XB+WQK+3vwhIzTWEl+21YN//oJfqLAC7J
         qElQokZV0hQum8nLS9HAN7cB0pIPr4s6Hbq+XcP9kzdqfCpuiv1ruxT03GwbZSmAjido
         UtTjfMM2ajz40SZVJoVxaloVG4oFVKKe51Ve7P7j2fMm3MsXTdVv+Y9YeAf6gW+1L01D
         TFVg==
Received: by 10.229.136.136 with SMTP id r8mr9525656qct.35.1348512564906; Mon,
 24 Sep 2012 11:49:24 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 24 Sep 2012 11:49:04 -0700 (PDT)
In-Reply-To: <7vbogvz2d9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206310>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> OK, I do not think Ramkumar's patch hurts anybody, but dropping the
>>> "nothing on the command line defaults to 'status' action" could.  So
>>> let's queue the patch as-is at least for now and leave the default
>>> discussion to a separarte thread if needed.
>>
>> Please don't do that, because it breaks test 41 in
>> t7400-submodule-bash.  I'll add a hunk to remove the test and send a
>> patch tomorrow.
>
> I personally see no need waiting for something trivial like this.
> Isn't it sufficient to squash the following in?  Is anything else
> needed?

I think this is sufficient.  Thanks.

Ram
