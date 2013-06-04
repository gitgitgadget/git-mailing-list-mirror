From: Janusz Harkot <janusz.harkot@gmail.com>
Subject: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 11:36:14 +0200
Message-ID: <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 11:36:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjnfN-0007Aq-58
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 11:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab3FDJgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 05:36:21 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:51492 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab3FDJgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 05:36:19 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so423442lbi.11
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=FEjjKf2P8xri75AORm3UBq6L8kp8aUeyDSPBbvn8QJY=;
        b=ZBLKr+7u0wJbsuQEJRnDyrVQGCgMz6C6Wat2KURju8wwrW4h762hdsSo8f8ImkJZDr
         ghUSNutXdEBzbawD8uDJbcggt/w0DaPbEDQeYp1+evjHxjVWf8ZiJRyFnnEXOgakUTcK
         L0vK5TOmjXpg2BcpIYD3rhmy02OznIgMFBZ7A5wqPFtNGJzpyTpwPjha34zRx7NoMRbA
         ZGessuWyoQQgnSLaF/X4n7Qr9zYdUmNz9Z3vuTHRrAOZVkT70Z43WckweehFpQSrQtgC
         JYmYnbFuoVEDN4y/fMxYt6rU1UzEFGcliDLaJ5odGDwSOop1nqJ6Wnp6xMDz5az/Ss+/
         iIew==
X-Received: by 10.112.89.200 with SMTP id bq8mr864794lbb.104.1370338576926;
        Tue, 04 Jun 2013 02:36:16 -0700 (PDT)
Received: from [10.0.1.200] (77-252-124-82.ip.netia.com.pl. [77.252.124.82])
        by mx.google.com with ESMTPSA id w8sm4898427lbi.14.2013.06.04.02.36.15
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 02:36:16 -0700 (PDT)
In-Reply-To: <DC851F5EA18E478DACB62178624BF5B7@gmail.com>
X-Mailer: sparrow 1.6.4 (build 1178)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226334>

I was trying to to a push some repo over https and after few unsuccessf=
ul tries I've managed to find a problem - multiple virtual SSL servers =
on one IP address=E2=80=A6

Strange was, that initial communication was OK (http GET), but when the=
re was http POST - git reported error (incorrect certificate).
The only workaround was to disable certificate verification.

My question is: does git support SNI on the https? If so - are there (u=
ndocumented) options to make it work?



Thanks!
Janusz =20
