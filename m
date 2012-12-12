From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Wed, 12 Dec 2012 18:12:58 -0500
Message-ID: <CABURp0qCv9aaORMFnVTjaJ_QYD3h-=aOnu9BC8ZgUqRT3678hw@mail.gmail.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org>
 <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org>
 <50C24ED7.90000@xiplink.com> <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
 <50C25539.9010206@xiplink.com> <7vobi5fu3c.fsf@alter.siamese.dyndns.org>
 <50C4FD00.4010003@gmail.com> <CABURp0oc_g3T3n0A4on=n8443sTFR6SKf1xcgN2EAFcx9eU_Ng@mail.gmail.com>
 <7vehiv3vjm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivUf-0006j5-5C
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab2LLXNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:13:20 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:39436 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2LLXNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:13:19 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1196683lag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 15:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=36o7iN026Aq+vnwlleMvcHSNajbLvKb7VJ2Rm3QwxD0=;
        b=bk+KkOw3K0dHRcE5pD+vd2yqtxWsIzDEt93mKaUoZdJa1TJqH/IHYjjCprioOqfZKu
         gkR+H6/BFIfnMxRemb60dTrSVwWIz09xCZ7xSC/vnXTolKGcW2ATodZ0n/peKoWi9rJN
         jUqGrOWRqco0hMk6YvthQg2ofH/STDGVaWBpKZZGiLuOCkZy5ek9DJGz/zhwYAX1p3Ye
         /uabPzDLRVOQ2HkKPonzsVWc4+lrIhxP96VcikWa7nV5kcCUX/cmQi7uHbCoPG+zPTot
         UKZ0/JXuDUxpKsuCPrAbxxo3Mo59/RSqldUk3/HxlNGLoYfhSHXJi3FOzhVzkRq1cdKl
         TUPg==
Received: by 10.112.50.201 with SMTP id e9mr74695lbo.82.1355353998327; Wed, 12
 Dec 2012 15:13:18 -0800 (PST)
Received: by 10.114.38.3 with HTTP; Wed, 12 Dec 2012 15:12:58 -0800 (PST)
In-Reply-To: <7vehiv3vjm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211416>

On Wed, Dec 12, 2012 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>> [2] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/141481
>
> None of the ones listed seems to me a bug.  Rather, I see it as a
> sign that the reporter does not know POSIX shell well and only
> learned his/her shell through bash.

You're probably right.  I run into enough problems with 'dash' as
/bin/sh that I always have to disable it early after a new install.
In particular, an third-party embedded linux kernel build script fails
in cryptic ways with dash.   But it is probably the third-party's poor
understanding of POSIX shell which is to blame.

I think git's 'make test' previously would also fail under dash, but
it seems to be happy with it atm.

Phil
