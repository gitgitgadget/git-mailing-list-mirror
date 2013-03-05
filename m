From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Fwd: Strange remote interaction
Date: Tue, 5 Mar 2013 10:46:20 +0100
Message-ID: <CALZVapkk2bugkSuqQ0EU7Zu9fjHGqrtAeArbG-ycJdS=morMLQ@mail.gmail.com>
References: <CALZVapm32S2XqA48KCmfr8O5PVSNMgRj=JfRm_yyYz6N6wE0=A@mail.gmail.com>
 <CALZVapnDyF7m=R7xrjUJUtyr9xVUeDnL4tQSCoM2ze8GSuUUyg@mail.gmail.com> <7v1ubuwhec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 10:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCoSj-0003ZL-VB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 10:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab3CEJqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 04:46:43 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:64890 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540Ab3CEJql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 04:46:41 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so5618631vea.30
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 01:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6dIfXWqA2hd50MpWwEetQWvbi5lYTVc25iEEgCSn3ZM=;
        b=hJc0ewZPFeQ00WQYAio8fUmntUOgtlvFWEfx4UvIpfrxGsw6THWtnIriBzkpgZ361j
         xdA0XUXqpESrkhwnmbn8hPNT8mKXRIUkgbnCeHGnrcYt3FJ8lQRddmr5dvvAKZSJWn+s
         8/HFrdCBkkrfznYRqJMIBYp2cNPCtvZnEICQmjNtIqCpRHPvk6nprGGWUUwZQoDhkXeX
         rA6nsCBGz+wpPmaugsNXjPMry+67tImpuIZCTsNUCy66nS5lZ5p+oqtUFv1ZFpTVyzrn
         64jtUwjfVh8drOo+K8w0kkYH7Yc9KvmAgl+/BQmrGLLkSCxEgiuTaLWjOfF8jSYmoHeB
         nWmw==
X-Received: by 10.52.19.65 with SMTP id c1mr8009395vde.36.1362476801021; Tue,
 05 Mar 2013 01:46:41 -0800 (PST)
Received: by 10.59.12.35 with HTTP; Tue, 5 Mar 2013 01:46:20 -0800 (PST)
In-Reply-To: <7v1ubuwhec.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217440>

> In a usual set-up, an access to git@server:javier/pfc will first
> locate the home directory for the user "git" (the token before "@"),
> and then its subdirectory javier/pfc, e.g. /home/git/javier/pfc,
> while an access to server:javier/pfc will first locate the home
> directory of whatever username the ssh connection uses by default
> (typically the local user but ~/.ssh/config may have "User"
> directive for the server) and then its subdirectory javier/pfc,
> e.g. /home/javier/javier/pfc.  These two may be different locations.
>
> Do these two commands show the same output?
>
>         $ git ls-remote git@server:javier/pfc refs/heads/master
>         $ git ls-remote server:javier/pfc refs/heads/master
>
> If the above conjecture is correct, I suspect they don't.

I have a gitolite setup there, so it is imposible the give the same
output. Anyways, as I don't have a user in the server machine, the
second fails.

$ git ls-remote git@server:javier/pfc
22692a2d69d3138b7ccebd64e72c66ea8bf69e9f HEAD
22692a2d69d3138b7ccebd64e72c66ea8bf69e9f refs/heads/master

It is the first time I encounter such a problem.
