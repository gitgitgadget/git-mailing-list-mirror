From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 19:20:14 -0400
Message-ID: <4C3E462E.9010205@gmail.com>
References: <loom.20100714T180615-173@post.gmane.org> <AANLkTimdVvKYPQn84IQvk7yxMo-gtrjWWqzN-ypXV78X@mail.gmail.com> <loom.20100714T195109-665@post.gmane.org> <AANLkTilo4TnMQcr7p1dfAeQ4tESHjO4Nbr8274hqxOnD@mail.gmail.com> <loom.20100714T232116-579@post.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brock Peabody <brock.peabody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 01:21:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZBGB-0008KR-To
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 01:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab0GNXUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 19:20:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33164 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab0GNXUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 19:20:51 -0400
Received: by gyh4 with SMTP id 4so264583gyh.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wl08IVAtmEAAbcQlZpnrw1Oq0xs1nkUyf+Z7bx1QQ5c=;
        b=kWERQ9rGj4T1CgvNzLSxQD7Eito1xalT2k6S14VUmWLDNPUEioRC9jL5LHz7p42sBf
         128seD+ROjYEMNu2giRyM3/gOI0bIhRDIo9el/SDEDmcbtxfy16NqehioF5aAnTDP47/
         3cOKkRd9mGrnR++4KF4X6ag9lRVaX7jYuEaZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=H2cD8hZDXNl7EFwIQMJzWoFcEwLJp76WQQIDe3muZJ3/e6uLWwoc+/SocMCx8c/w1E
         DeKKDKCqqUg96uoWLTf97PLaPiytxCNrNjpYBdR4ummSdPRDTpooiS6+CFQFibuN7Ydu
         FbxKd7XRNJslaW0t7oMaA+mVIZLxI8fur15zU=
Received: by 10.101.160.21 with SMTP id m21mr19087422ano.43.1279149621162;
        Wed, 14 Jul 2010 16:20:21 -0700 (PDT)
Received: from [10.0.1.133] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id 14sm3530075ant.21.2010.07.14.16.20.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 16:20:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <loom.20100714T232116-579@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151043>

On 07/14/2010 05:46 PM, Brock Peabody wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason<avarab<at>  gmail.com>  writes=
:
>
>> Well, consider that even if you push most patches through, the peer
>> review you get from having a setup similar to Git's own might very
>> well be worth it. Everyone makes mistakes, having a second set of
>> eyeballs to look at your code eliminates a lot of that.
>>
>> That may not be acceptable to your corporate culture, but consider
>> that most big corporations (e.g. Google) do detailed code review
>> before anything gets commited to the master repository.
>
> Yes, that's a good point.  We are trying to improve our code review p=
rocesses,
> and I think switching to git is going to help with that down the road=
=2E  I don't
> want to make the switch to git and a heavier (if better) process at t=
he same
> time, however, as it would decrease the chance of either being accept=
ed.

Have you investigated Gerrit Code Review?
