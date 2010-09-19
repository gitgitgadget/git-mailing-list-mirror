From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git am should recognize >From
Date: Sun, 19 Sep 2010 17:24:55 +0300
Message-ID: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: Russ Allbery <rra@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 19 16:25:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxKpF-00040x-GH
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 16:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab0ISOY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 10:24:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35547 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab0ISOY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 10:24:56 -0400
Received: by iwn5 with SMTP id 5so3462525iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=owIA3lFFWvFeEm80sSpywbHSaf+d2sRKmWnV6xXdfNY=;
        b=QtDHIE5MjDj1eVNP6ddE2hmX4HcA6PckJ0/NZh1wwHIsay9SobmVJbSpuexpT5CXsH
         kWIThe+NeEA7c99Fgj82aUyWU1B10Q5LZoG/MxYV0MuMcRB3wh8ErOwcyMYxnOzzNoO6
         9X6kKSBsgTvi1uMiAWvs+43C0AqvwUil+3f0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=wAcn8kqnd+5r+a2sjG6ZQqTDHg07APDnF/8poIzqi39tJ7LoRXrHAgWpxhBfFCejo2
         XXeuIOJeki4/KXU63w/iypItCCS5Q36YNLO6xmlBhNgDYi54RsVmvbWZKNfYhWgfIAfi
         TA7dovsKx4MHGeMwfskEP0fDKCN84hwVch4n4=
Received: by 10.231.154.73 with SMTP id n9mr8786724ibw.10.1284906295845; Sun,
 19 Sep 2010 07:24:55 -0700 (PDT)
Received: by 10.231.15.12 with HTTP; Sun, 19 Sep 2010 07:24:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156499>

(+cc: some "git am" people. Unfortunately I will probably be hard to
reach for another week or so.)

Russ Allbery wrote:

> I process a lot of git format-patch patches as attachments, but it's
> common for mailers to mangle the leading "From " line by adding a >.
> This causes git am to not recognize the patch

Ignoring a leading ">" sounds sane to me at first glance; thanks. (The
file to patch is git-am.sh, hint hint. ;-))
