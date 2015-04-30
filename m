From: Thiago Farina <tfransosi@gmail.com>
Subject: CURLOPT_NOBODY
Date: Wed, 29 Apr 2015 23:20:55 -0300
Message-ID: <CACnwZYdCitEJ=pr=1+C_Wz5pKTbSYj4hD7mQHLC3gaDO8CqnrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 04:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yne7H-00041x-55
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 04:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbbD3CU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 22:20:57 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33721 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbD3CU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 22:20:56 -0400
Received: by oblw8 with SMTP id w8so34558544obl.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 19:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FtiAKNs8l2yKQfBemKu9JgdOvyFZ4zcmBZNWS/qz3+0=;
        b=iYElCHBTHJHPGmmfGrEr/0fbO9RIUiHFtKZ1XxV/5hOErY/fXi5T0YWZabi2f9pT1z
         GwoXgC2QKqIb28xSQxRuhnabIJNewzZ5+rHDkG/JrtwEOFdLj3UtGN9LOyA9SeyLfVuD
         m4K/iPCorYLlCOVd03w2vzPcKcPzM4wWtE2bL006foexCPwzv3YC7GJ7/47KJ2Y5x4bh
         X0qd7au7YujPYdNu8xkVYr57TGdO1V42zIuzjQj4Cgu+PN0gJkcQndH8d5m+p8eMC04c
         Gx7UnIR/0ia5UuD1wt3iSa6nHdVauoJL5qQai7MWAFSdYZfQd2QFuBFWAhidZ6kn1vMH
         pltg==
X-Received: by 10.182.186.70 with SMTP id fi6mr1607512obc.79.1430360455634;
 Wed, 29 Apr 2015 19:20:55 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Wed, 29 Apr 2015 19:20:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268051>

Hey there,

Do we need to set CURLOPT_NOBODY to 0 in
https://code.googlesource.com/git/+/master/http.c#1138? Do we do this
for the sake of doing, because it doesn't hurt?

According to the documentation in
http://curl.haxx.se/libcurl/c/CURLOPT_HTTPGET.html, if we set HTTPGET
to 1 it will automatically set NOBODY to 0, so the answer for the
above question would be no.

Also, according to http://curl.haxx.se/libcurl/c/CURLOPT_NOBODY.html,
it is 0 by default.

Bye,

-- 
Thiago Farina
