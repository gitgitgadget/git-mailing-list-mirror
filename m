From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Tue, 31 Aug 2010 23:38:57 -0300
Message-ID: <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 04:39:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqdEN-0002Kv-9W
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 04:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab0IACi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 22:38:58 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54763 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab0IACi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 22:38:58 -0400
Received: by qyk36 with SMTP id 36so151321qyk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 19:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=stl+OKo9oOGkt2roswqQhQnnfxOzcbYepNW37bioSOU=;
        b=pC7QnJ665Dl0PbwqLCnXnyV/lkv3S6wrp0XnO/5KegLG+kSOqecxpjaL6GhGePj7at
         bahK2kZsbj3n6p3Z6YQ4vCLUmTV6ccAtX6kN3mNd92dxIN9BWwE+ePPrMYzRFPCguHiZ
         FTBaCwiVWeVb5wMNVKJgHIltAvDeULYXmrnqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FuYJoFFSNTU3lsrTa7wqhZVoyVF7ForfBsLiPoTMGau8PsABLKdgZZ5w3FCJaBljjA
         FnXdOum/FynK3V2otLF+kwwfv56QLsIHojg08q5A0cLKFzpH8QalhlTU45kXufUvapYD
         sDpF2QlvtnjBEJaIDpBZAVxfc/Jv8nMSNcPK4=
Received: by 10.224.54.13 with SMTP id o13mr4609656qag.228.1283308737071; Tue,
 31 Aug 2010 19:38:57 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Tue, 31 Aug 2010 19:38:57 -0700 (PDT)
In-Reply-To: <20100830024020.GB4010@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155005>

On Sun, Aug 29, 2010 at 11:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>> Thiago Farina wrote:
>>
>>> Promote cmd_version to a builtin, by moving it to its own file
>>> in builtin/version.c
> [...]
> So for what it's worth,
>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>

Ping Junio.
