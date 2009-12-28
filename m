From: Sergio Belkin <sebelk@gmail.com>
Subject: Re: Set the repository as it was on an earlier commit
Date: Mon, 28 Dec 2009 01:19:29 -0300
Message-ID: <8c6f7f450912272019t4b9c721dt2630a8d32607013e@mail.gmail.com>
References: <8c6f7f450912251509i67da4665t78be0bb79f2c40d6@mail.gmail.com>
	 <adf1fd3d0912251536kbf25272ob0ab8ee90e53861d@mail.gmail.com>
	 <vpqiqbt95e7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 05:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP74z-00035i-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 05:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbZL1ETd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 23:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbZL1ETd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 23:19:33 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:63501 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZL1ETc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 23:19:32 -0500
Received: by ywh6 with SMTP id 6so10147141ywh.4
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 20:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=mOJ98R60OU9K3foP8K7YjjrovRP4XIJ1c6kYaf2l88U=;
        b=gq1W0mG43LbLIm1Hbz7nAVPBfPscm5iZrbkCVu3UuUdNp/oVuBjaanyRhJYY6AKw/3
         NiW5IGlbv1c1JpAN39dO05Qc5evwV5sdxDaL7SvlfbpIV6NuxsXX06E436hCGryyWQ1N
         rdUD/WkGIiiwchiiN1XOdEfFLQ+hq7ywbM0hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=R9j5pMtVTW0qC9LDXKBjct2ggNrt+OoX/77NdYkudhgKUMbHxlLght9YFEqhPEn5xi
         oT+3pokV63SPQZrZgc/Evw3nu+JZD4J51BJUvRGpgyaewhHYuH9MLF75JJOLpVYO6hEn
         0aXlkOOfpQKGFV7EiocL//kvwuoJOO7xL6/WU=
Received: by 10.150.28.27 with SMTP id b27mr22117401ybb.59.1261973969963; Sun, 
	27 Dec 2009 20:19:29 -0800 (PST)
In-Reply-To: <vpqiqbt95e7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135725>

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

--=20
--
Open Kairos http://www.sergiobelkin.com
Watch More TV http://sebelk.blogspot.com
Sergio Belkin -
