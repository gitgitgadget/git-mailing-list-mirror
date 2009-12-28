From: Sergio Belkin <sebelk@gmail.com>
Subject: Fwd: Set the repository as it was on an earlier commit
Date: Mon, 28 Dec 2009 02:18:03 -0300
Message-ID: <8c6f7f450912272118x384cd840j238b39efa9a87a3b@mail.gmail.com>
References: <8c6f7f450912251509i67da4665t78be0bb79f2c40d6@mail.gmail.com>
	 <adf1fd3d0912251536kbf25272ob0ab8ee90e53861d@mail.gmail.com>
	 <vpqiqbt95e7.fsf@bauges.imag.fr>
	 <8c6f7f450912272019t4b9c721dt2630a8d32607013e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 06:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP7zg-0004eB-Kk
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 06:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbZL1FSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 00:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbZL1FSH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 00:18:07 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37348 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZL1FSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 00:18:04 -0500
Received: by yxe17 with SMTP id 17so9108803yxe.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 21:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Ye9kHblePwua+HIEwDCd2QdhtgXqFikd8/ES1NyE5pw=;
        b=Zu67O7H61JXt1QhnX59LqNl9rrON7iqLxkrSjYM0jUNTt5ycs/fK8TJK5zqciNu8Md
         ghFplat3nwaDsPa3hEVqaKfl2BzEj45xzzwtqTmdJhdegWsxOw2Qstt/E5bZBOEP9O2J
         bwWUKkRgr/2bY7DCDiRBSH09oW8Z0VzHMLhJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=JbRvDOsfsYVCt/0WXWHbo4LmU7E9wDyrH4jrzyv+MPxHKKgWwJYqCI/v1lmukq3/hP
         ++deAn74HVt4lQrbw22raIe86e9kmc0h4u0gPJAkIPtbLoR4bl2gD5gKHqHIpgsEiA9/
         mqKcRh02HWh1iYD5POQJ85oTwyIDmxHXf0SGE=
Received: by 10.150.129.28 with SMTP id b28mr21749655ybd.318.1261977483498; 
	Sun, 27 Dec 2009 21:18:03 -0800 (PST)
In-Reply-To: <8c6f7f450912272019t4b9c721dt2630a8d32607013e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135728>

Ooops I wanted to say Santi answer was the best


---------- Forwarded message ----------
=46rom: Sergio Belkin <sebelk@gmail.com>
Date: 2009/12/28
Subject: Re: Set the repository as it was on an earlier commit
To: git@vger.kernel.org


2009/12/26 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> I don't know if it is possible with porcelain commands, but with
>> plumbing you can:
>>
>> # begin with a clean working dir
>> git read-tree B
>> git commit
>> git reset --hard
>
> I guess
>
> (at the root of the repo)
>
> git checkout B -- .
> # git status if you want to check.
> git commit
>
> does this. The "-- ." part of "git checkout" asks Git to checkout the
> files, but the path limiter prevents it from updating HEAD, so the
> HEAD still points to the tip of the branch.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>

Sorry but really answer given by Steven was better, because last one
omit the case when B had less files that D for example...

Thanks everyone

--
--
Open Kairos http://www.sergiobelkin.com
Watch More TV http://sebelk.blogspot.com
Sergio Belkin -



--=20
--
Open Kairos http://www.sergiobelkin.com
Watch More TV http://sebelk.blogspot.com
Sergio Belkin -
