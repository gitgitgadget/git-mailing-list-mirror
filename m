From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 14/19] Document pull-all and push-all
Date: Wed, 13 Mar 2013 00:13:09 +0000
Message-ID: <CALeLG_mtN3WppXXva8cH8s6SO0nQThSq6pw-FHe47oFrXzeCRQ@mail.gmail.com>
References: <CALeLG_kdXMb8wAyAL7T9jXk3sT85uJeiNh+v3jz9tKcf25VA9A@mail.gmail.com>
	<513F45DE.6010304@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, David Michael Barr <b@rr-dav.id.au>,
	Kindjal <kindjal@gmail.com>, bibendi <bibendi@bk.ru>,
	Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 13 01:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFZKD-0000EA-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 01:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab3CMANL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 20:13:11 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33891 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3CMANK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 20:13:10 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so464339obh.16
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 17:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=tHYK/6OU/c/3W4ykRGyNCFqv6ElN9Hu/5N4caGaVRwA=;
        b=YpWcl3UTXWZqNWzJqJ5dsOvRWWTK8VGKChlhTVJ8hpSUDj8FycW7KLWvHx/PN9jp71
         m2AFnBLNsY/OPLkiECCNZhq+6czpbH9wGqn/vVy9Xr3lgGcsQLf6VhX0CGlg2TNuRIxw
         Av3cIjmaRlPFHujKnl14/jds8kdyhrPS52jU2NX15PjYCdethuN0d2XMyzMYw33a9Tba
         3u3qyaaSxu5Ybd8IaRup1YTWk0szpTWQcee6OnQrWbup7tcyPlU0Wy7f60/orRsgO+pM
         6wAp8zMuyUkjiFsWYRkz2xZ84rysfAJ+X5LvZhDslZROQmSlldxSDW+Irxd/zhj2/NN3
         j9YQ==
X-Received: by 10.60.25.65 with SMTP id a1mr13977821oeg.40.1363133589780; Tue,
 12 Mar 2013 17:13:09 -0700 (PDT)
Received: by 10.76.169.225 with HTTP; Tue, 12 Mar 2013 17:13:09 -0700 (PDT)
X-Originating-IP: [2.102.86.4]
In-Reply-To: <513F45DE.6010304@ira.uka.de>
X-Gm-Message-State: ALoCoQl/X5yj4sBJN9OaawocUr1cifI/80fzwEtspRAELl8xIQ3rQ3OmiUhJUpK7WxPnkxv9j6Xb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218013>

On Tue, Mar 12, 2013 at 3:12 PM, Holger Hellmuth (IKS)
<hellmuth@ira.uka.de> wrote:
> Am 09.03.2013 20:28, schrieb Paul Campbell:
>
>>  From 7dcd40ab8687a588b7b0c6ff914a7cfb601b6774 Mon Sep 17 00:00:00 2001
>> From: Herman van Rink <rink@initfour.nl>
>> Date: Tue, 27 Mar 2012 13:59:16 +0200
>> Subject: [PATCH 14/19] Document pull-all and push-all
>>
>> ---
>>   contrib/subtree/git-subtree.txt | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/subtree/git-subtree.txt
>> b/contrib/subtree/git-subtree.txt
>> index e0957ee..c8fc103 100644
>> --- a/contrib/subtree/git-subtree.txt
>> +++ b/contrib/subtree/git-subtree.txt
>> @@ -92,13 +92,19 @@ pull::
>>         Exactly like 'merge', but parallels 'git pull' in that
>>         it fetches the given commit from the specified remote
>>         repository.
>> -
>> +
>> +pull-all::
>> +       Perform a pull operation on all in .gittrees registered subtrees.
>> +
>>   push::
>>         Does a 'split' (see below) using the <prefix> supplied
>>         and then does a 'git push' to push the result to the
>>         repository and refspec. This can be used to push your
>>         subtree to different branches of the remote repository.
>>
>> +push-all::
>> +       Perform a pull operation on all in .gittrees registered subtrees.
>
>                  -----
> pull->push
>

Thanks.

>> +
>>   split::
>>         Extract a new, synthetic project history from the
>>         history of the <prefix> subtree.  The new history
>>
>



-- 
Paul [W] Campbell
