From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: gitweb: in-page errors don't work with mod_perl
Date: Sun, 27 Nov 2011 05:05:55 +0100
Message-ID: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 05:06:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUW0V-0002eq-Mz
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 05:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab1K0EGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 23:06:19 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33877 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab1K0EGS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 23:06:18 -0500
Received: by wwp14 with SMTP id 14so6487426wwp.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2011 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=+TzTouGJFGgJv/BYVgkYSpL3j1Q0rIpqGp+XjbcYntM=;
        b=aE8PxhabTc8xAQvARYFmaFJtK2NPh6C4xWdDJi/i5E4QKi8082rN9ZhEF3ZTfA4DHS
         A+jQmCJJ/Ozcf3Aj+IidXhEQTcwMCnLhfqE7FPeTiZ4liHEkCMk3ErleGigpbB23LU5S
         gkP5nPcRR1zeB5IBf0XfVtU+J9siCNSTlXzvQ=
Received: by 10.180.74.141 with SMTP id t13mr39589092wiv.68.1322366776370;
 Sat, 26 Nov 2011 20:06:16 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sat, 26 Nov 2011 20:05:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185966>

Hi

when gitweb.perl (208a1cc3d3) is run with mod_perl2 (2.0.5-2ubuntu1 on
Ubuntu 11.10) custom error pages don't work: Any page with status !=3D
200 shows the plain Apache error document instead of a gitweb's error
page.


J=C3=BCrgen

--=20
http://blog.blackdown.de/
http://www.flickr.com/photos/jkreileder/
