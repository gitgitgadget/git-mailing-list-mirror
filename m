From: =?UTF-8?B?c2hpcmlzaCDgpLbgpL/gpLDgpYDgpLc=?= 
	<shirishag75@gmail.com>
Subject: Has there been any discussion about resumable clones recently ?
Date: Fri, 20 Sep 2013 04:48:33 +0530
Message-ID: <CADdDZRmufDTYYxHeAuPbCUn5iQHruAOXXho5KVOQ6McfSFvPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 20 01:18:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMnUn-0003Y3-4q
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 01:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab3ISXSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Sep 2013 19:18:36 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38045 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab3ISXSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Sep 2013 19:18:36 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so105lbd.16
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=3lGcUynhRwVwHuZQx+ZkRJRqV5gr8aBWTl1/OpKQmKs=;
        b=CODRt2FzRUJlPJiqI4EhZISGwlMOQp/eSEESsHSgPzJZA/706Ch4h00Du1IrTBlE82
         k2lnZuZrgyTxBNynX83hLNpC3ZM5b70/B+ofu/40rqb+u8b3YvWoEj8ycslOV94UmSns
         joBhxpAaDs1uafvunEtTKsgC0EEmaZl7nAat796oeOdylo16EnWdonOE0/m74oJjtJro
         HxbQYY13HVNxD8COSthS2kKvV38FF+a6/TU36lQeY4NvzxjCmWXgFAa+242lwY3QdMMW
         iXppM6gyMpMhdUbKGIJs9YXvFkUhEahLKz6JmdZwyKqLIQ2foofICUmz5dSwf/7g1Xiu
         BCRw==
X-Received: by 10.152.116.109 with SMTP id jv13mr3327261lab.30.1379632714504;
 Thu, 19 Sep 2013 16:18:34 -0700 (PDT)
Received: by 10.112.89.135 with HTTP; Thu, 19 Sep 2013 16:18:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235040>

Hi all,
=46irst of all a big thank you to all for making git. With it being fas=
t
and cheap (in relation to bandwidth and sizes for subsequent checkouts
as well as CPU usage) . Please CC me if somebody does answer this mail
as I'm not subscribed to the list.

The thing I have been failures number of times while trying to clone a
large repo. The only solution it seems is to ask somebody to make a
git-bundle and get that bundle via wget or rsync and then unbundle it
and then hopefully just sync it. The other way is to pray and hope
that somehow git clones ends in a success.

Somebody told me that there is/was some recent discussion on getting
something like :-

$ git clone --continue

which is/would be very similar to how wget works so you can continue
the large file download if the server supports resuming.

Is something similar being worked upon or discussed upon ? If yes,
please point me out to the discussion as it would be very beneficial
to people like me who have unstable network connection.

If not, then sorry to take your time.

in gratitude.
--=20
          Regards,
          Shirish Agarwal  =E0=A4=B6=E0=A4=BF=E0=A4=B0=E0=A5=80=E0=A4=B7=
 =E0=A4=85=E0=A4=97=E0=A5=8D=E0=A4=B0=E0=A4=B5=E0=A4=BE=E0=A4=B2
  My quotes in this email licensed under CC 3.0
http://creativecommons.org/licenses/by-nc/3.0/
http://flossexperiences.wordpress.com
065C 6D79 A68C E7EA 52B3  8D70 950D 53FB 729A 8B17
