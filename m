From: Jonathan Nieder <jrnieder@gmail.com>
Subject: User manual: "You cannot check out these remote-tracking branches"
Date: Tue, 19 Oct 2010 14:04:16 -0500
Message-ID: <20101019190416.GH25139@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
 <20101019182845.GE25139@burratino>
 <AANLkTi=DXH1WwGJ-h6s3dFfWZZ3tpu_jQgV1Y9O7c6Xf@mail.gmail.com>
 <0B20EFC4-E613-4D4A-B4F8-8B1750AA8AFD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:08:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8HXX-00035a-Nt
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab0JSTH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 15:07:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50999 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab0JSTH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:07:57 -0400
Received: by gyg13 with SMTP id 13so34558gyg.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fDld4pMRyKkkoX2eAoRGXIOqG6cetldo8TdFGmyQnMg=;
        b=HNkTJNNSJtVl1FDoHoKoWPExsoOg7nuVDPu+C3OJv+6SUI/0DueF32uU1tBtbE/Ekt
         TT0DS7nzEH+pFWwGW+AWrKU2FhDP1wgQXgiuWH7Nr02Q08L6rq0j3mpOm0WLcZcWb1Pj
         /h0JidEvzxvaWRz5J7OSEU+Y+WRUq72oM3Wt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qpzAMUHqsKLi65Wwz1BinTW9eqUw5AiodFwILHZsZ8BGMlCXPaQmCWH+J13sNVsQQs
         3OMdT81g1OUnlx10UxuX5nhfnPJ3hWM0qJV8pymefFA2WSTQwNmqMsghQwodBWUEYXmp
         1Ugn9i1ZEVMDXk67jJ1ShID7qFjSdSce9NQ4g=
Received: by 10.103.229.19 with SMTP id g19mr629582mur.59.1287515276289;
        Tue, 19 Oct 2010 12:07:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id c40sm967457fay.0.2010.10.19.12.07.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 12:07:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0B20EFC4-E613-4D4A-B4F8-8B1750AA8AFD@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159355>

Thore Husfeldt wrote:

> Also, in the user-manual.txt:
[...]
>>   origin/todo
>> ------------------------------------------------
>>=20
>> You cannot check out these remote-tracking branches, but you can
>> examine them on a branch of your own, just as you would a tag:
>
> That=E2=80=99s just wrong, isn=E2=80=99t it?

That's historical baggage, I'm afraid.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 77eb483..9f82fa6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -359,13 +359,16 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
=20
-You cannot check out these remote-tracking branches, but you can
-examine them on a branch of your own, just as you would a tag:
+You might want to build on one of these remote-tracking branches
+on a branch of your own, just as you would a tag:
=20
 ------------------------------------------------
 $ git checkout -b my-todo-copy origin/todo
 ------------------------------------------------
=20
+You can also check out "origin/todo" directly to examine it or
+write a one-off patch.  See <<detached-head,detached head>>.
+
 Note that the name "origin" is just the name that git uses by default
 to refer to the repository that you cloned from.
=20
