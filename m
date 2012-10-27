From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git config error message
Date: Sat, 27 Oct 2012 10:10:04 +0200
Message-ID: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:10:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS1TO-0000oX-P8
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 10:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab2J0IKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 04:10:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56991 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2J0IKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 04:10:05 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3247489pbb.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=l+vMMSTSha2GmKqZDuYwlPkJpYvnR95xfowD5/vEO2A=;
        b=G0DDvM/m1uqsJsgr9kEKDkLJZ39mSFo3qYBazpf9DtV6SfiHigog4il+6QydRww4+k
         fS+NLz1StF73STuF/2exZzpGoHn+M9U4FI/mNad2BcSfyeQpyJ2LYntFEUn/KTHA0dV4
         HeV7JlisQnffJUuj9mdWXnStk64I0Vv0ArF71K2cVgIMru6sOij5C+Af7wlAiGBRlV2A
         5L4WeW47RkTY5+rcBiN6b3Euhj0BISHYpu8cbs88+IxE3imUGelbGVYPN8fKmabXuCID
         oyvYvz9X7Dk+/tpDxwKBemF8VSgUcmWBJf30BSWi6xNn2r0K6L4X7Dh4MATVcJDjdD8o
         mC9Q==
Received: by 10.68.129.72 with SMTP id nu8mr76327679pbb.29.1351325404976; Sat,
 27 Oct 2012 01:10:04 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Sat, 27 Oct 2012 01:10:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208498>

Hello,

git config --get issues an error message when the specified value
contains a section that does not exist, but does not issue any message
when the value contains a key that does not exist while in both cases
returning a status 1. E.g.

$ git config --get xxx
error: key does not contain a section: xxx

$ git config --get xxx.yyy

Proposal: to issue an error message also when the key does not exist.

-Angelo Borsotti
