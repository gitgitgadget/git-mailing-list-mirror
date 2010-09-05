From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Sun, 5 Sep 2010 17:13:39 +1000
Message-ID: <AANLkTikwKgMy4x3n7jUKmpbxvpwtwHD-KBynu87WM==Y@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
	<AANLkTimf_EJcZtJk_X7FiKqQy-oRU4NvZsXMCEcsB=Wa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 09:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os9QA-0007RF-4N
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 09:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab0IEHNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 03:13:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42947 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab0IEHNk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 03:13:40 -0400
Received: by wwj40 with SMTP id 40so4919893wwj.1
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vJlNqFPaHF0Yns+QFWymgF7z49ARe0sTI5qIJF4dLGk=;
        b=wzZrOXRDBmAnBxUPo/lpEcoznAnGUK/lulI5o7EKAPpZOMw0y3j2iB965YvWjXy7Kp
         VupZPjs0x1KjPMCWMiWhZAMU747NRgKlTt5LeZf/dWLnjavzSJAKZc2EaGZgcFtT50bT
         UwcrcxTalInm3jqbHmBSl4HRHFAmRvpSvUNws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NBTRN/UkQ7WSepuODwVdVrPEcjHtEQP9YWs5Hvu7ciY76VgoUWysjbsnj4uwxblSmz
         ZSmoNU1ih8EXjhJKO9vwPatavVq1QCX2gwRyGhygcG9eGHQGe7jVoTspwkc/sVhkjVBg
         S41lPrJtsJZtQoIaEI/sKsvHowksRMcD7bQRE=
Received: by 10.216.164.199 with SMTP id c49mr1813988wel.107.1283670819645;
 Sun, 05 Sep 2010 00:13:39 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sun, 5 Sep 2010 00:13:39 -0700 (PDT)
In-Reply-To: <AANLkTimf_EJcZtJk_X7FiKqQy-oRU4NvZsXMCEcsB=Wa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155446>

2010/9/5 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> Tree generating from index, Elijah merges the base tree inside
>> write_cache_as_tree() while it does it inside commit_tree(). Again t=
he
>> principle is pretty much the same. I'll see if I can resist from
>> stealing some more :)
>
> Why don't you two combine your series instead? :)

Hm.. the two series have different, conflicting goals. I think we'll
end up sharing a lot though.
--=20
Duy
