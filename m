From: Ilya Holinov <holinov@netvoxlab.ru>
Subject: [BUG] git svn geotrust certificate problem
Date: Fri, 5 Jul 2013 19:16:01 +0400
Message-ID: <CAOfgeSaRmqRj3gCGy0q9ehr=znzyPONa-Ze03hTo69QLHMuQjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 17:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv7k1-0002xO-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 17:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011Ab3GEPQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 11:16:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65069 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab3GEPQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 11:16:03 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2115927lbi.5
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 08:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=FFBB3XznxnYTfiL33EHTF3jkX4S63TIbhKNJkicUiDA=;
        b=SrycYtmfnQu2LJwImixdtYRabqQfvT8zYg6QOXk11PHyvLFwWpGxc31prD5oq/1i3z
         1/51C9ZFw4YU2d1vGXz0O4I4P/nTdvwPCDHqfGbejb0UJ7OjjBPwkZDACSXbRZCsm7dG
         9hUwLEPyhoG9U07xH/tpkVKEjJjfm8KO3LMFk1KcvyXkDG9+MVIzQBHgBeJkf6DjiNbt
         elvzBR4SD3bcw/oVnjKgh1jzG1HoNVJn8FOEeVCwS1Wf07DzyHUntfXOWyo+ZdF5wylh
         /FjoBxs9OaMncp43eUpq/Pih3Ge0e57btp48nGuRrPYCm3sRgZ0WasDbNmrz2XhYYH6h
         V1yA==
X-Received: by 10.152.8.103 with SMTP id q7mr5258760laa.64.1373037361320; Fri,
 05 Jul 2013 08:16:01 -0700 (PDT)
Received: by 10.112.74.47 with HTTP; Fri, 5 Jul 2013 08:16:01 -0700 (PDT)
X-Gm-Message-State: ALoCoQm6xlkk97ty1g/R9n6S8ammE/+eTpRr/EFy3zvBK5LpZMFUjgjVr3XwvFG2YxtrF5hZiOzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229667>

I have svn repository on https singed with GeoTrust issued certificate.
Every time i try to access this repository i have message :

$ git svn rebase
Error validating server certificate for 'https://svn.egspace.ru:443':
 - The certificate is not issued by a trusted authority. Use the
   fingerprint to validate the certificate manually!
Certificate information:
 - Hostname: *.egspace.ru
 - Valid: from Apr 28 01:38:17 2013 GMT until Apr 30 12:00:40 2014 GMT
 - Issuer: GeoTrust, Inc., US
 - Fingerprint: b2:8d:f8:3b:7c:d2:a2:36:e2:1d:c3:5c:56:ec:87:6f:22:3e:4b:a8
Certificate problem.
(R)eject, accept (t)emporarily or accept (p)ermanently? p
Authentication realm: <https://svn.egspace.ru:443> VisualSVN Server
Username: holinov
Password for 'holinov':

Even if i choose permanently every next attempt to access in i have
same issue. And this happens on svn rebase on every commit. I mean if
i have 10 commits in local repository i will be asked about cert and
user login\passwor for every one of them (and that's is verry
annoying).
But if i use TortoiseSVN i have no problem with checking that cert.

P.S.: I'm using Windows 8 x64.
P.P.S: I like git very much but in this case it makes me impossible to
work in this way.
