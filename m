From: Austin English <austinenglish@gmail.com>
Subject: Please add a git config option to make --show-signature the default
Date: Mon, 23 May 2016 17:34:16 -0500
Message-ID: <57438568.60707@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="irvp546gQmeKhcdunSsBvXcDf1S3jqASr"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 00:34:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4yQa-0003XI-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 00:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbcEWWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 18:34:20 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:32892 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbcEWWeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 18:34:19 -0400
Received: by mail-qk0-f176.google.com with SMTP id n63so118753704qkf.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=55yAOWqTtFUtw39ImrZzc9htreW2ZJadc/6Uq8QAE38=;
        b=r9jiST0ZCQHCrcyJSQObt42MlgmR+Ynug3ijP9YK9I4aU2kyziNOH8+hVpC9anxOBC
         a9eCHANK2UqefSVPEW4y5gREVr2VrYkY4OQAjj3IJlXBwnl8oV2f04AlVkF6b2JGYaXp
         FBVayTDZqatfLg/WDkiVDhu+cVB6Pskv8pe4Dr6ffR9byq0pR3R+oHyKZnANMlH0H37K
         xLEWRD3gUmxlII48POB2GBuz1yhO6v6ltjAvAro/6VSEaJxi+4MVXuk5OsH58CmUJIGt
         WZQBQOORzty0ZhA/MIftv4JBmXGEqZjaovqGZxxCg8j7Ykzb8j3FVXVZ11IWWm/stj+p
         tgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=55yAOWqTtFUtw39ImrZzc9htreW2ZJadc/6Uq8QAE38=;
        b=lFgaXKGZYtuY8ujt0XDBFMyDjqKQXZOmtfTD+ae3/cgLcEa4zz80knaiZYPw6GdKK/
         tZLyuD6rxeJk+0JIayr5lH3H086V9O89DAEisynP21zJrJMD0w2/blTMTfPGV5CJTSwq
         Vc/nHILIJhyNDXU4zknNJYOwdHWpwPt/Fx4RlzwFxftki7QFs5sTWIOBPKWssdDoLyhQ
         K9ukhu1X9nqBYUBVcZoHWdxkw5vKdPB3+oKvYp9TWPrKDvT2fobuBSy1Q1//qqzV7kiP
         +JIhMylNFiqz/adSG5Ucd6ey3cxDkTHhgiy2hk3d3WJ8HAgVUx1JQN8hLMpvgdteXijp
         GsxA==
X-Gm-Message-State: ALyK8tJ+JgV9/f7VIi0LhEJ0ZCZUzxai74aGpZtdB/YqVeo8EiXwiKH1d5XmvlPQi3g6ug==
X-Received: by 10.55.158.20 with SMTP id h20mr532444qke.94.1464042858729;
        Mon, 23 May 2016 15:34:18 -0700 (PDT)
Received: from [10.128.99.33] ([100.42.103.4])
        by smtp.gmail.com with ESMTPSA id v6sm14184495qhc.34.2016.05.23.15.34.17
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2016 15:34:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295405>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--irvp546gQmeKhcdunSsBvXcDf1S3jqASr
Content-Type: multipart/mixed; boundary="j1voDhwAKdD1MQgUoSC1r1kOvBEWsq4h1"
From: Austin English <austinenglish@gmail.com>
To: git@vger.kernel.org
Message-ID: <57438568.60707@gmail.com>
Subject: Please add a git config option to make --show-signature the default

--j1voDhwAKdD1MQgUoSC1r1kOvBEWsq4h1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As stated in title, I'd like to see an option to enable GPG signature
by default. I find this feature very useful and would like to enable
it by default on my machine, without having to resort to an alias in
my ~/.bash_rc.

I asked in #git and checked the git repo, but I didn't see an option
listed for this.

Thanks in advance, and for git itself! ;)
-Austin


--j1voDhwAKdD1MQgUoSC1r1kOvBEWsq4h1--

--irvp546gQmeKhcdunSsBvXcDf1S3jqASr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXQ4VoAAoJEBT71+qgQZN7+AUP/0FsTHuQokBI/riuBcDRTkyB
rR3FppVize4CauSqDY9eNynXXZHDCT0BsUwwV6guI+Gpl94G3Xq0f94HpdTkKHEe
ISlPavO0WzUrk3IhElNP+fOTXHQjaQF1lGoaEDukskkvuClw2oP8UnUzMDO4pQ87
Y7bs0eBJKmfnzU5AESXJ0bSdXuBqpJDOr9a6eoJA7tM9BwdoQSYiieOKgZigO58W
7AIeuB/RgW2svYWYmWcqsycdRDSn6PoyjcNIJxE+SJUEpCgMwTfEwtTdO19T9QjW
8ijeGcc/4znRK1Ck7o+oNr5YWiQ56c0oNs52omTFQX/Wp7dwB8tOudcuJoNSlhjb
OzfIvRAg6o/nCNJjO9Z0fP3++GHoVoMH/xUUoTzgr2cFPOGj/5kduWr2Opvn2ZUH
XP3xfRFy6omztMNqGw+SAZZmwkaYgOp/AxegYxDCFEo6Rm+DpI+Rc+IFkvAfLL0A
xmLXKWLzrqMvceJb+8nSrO0QF5lkj/sAoP08LE+nSIZ96kz7vxnP07iv5aaVPKb4
w6qPSft/3EnmEVs3sqvi9U6prkfYioLzbWa1EBXgIHv9w49a8P0O8byeyJKV3Jkb
CB1bV2UKiiMZ6/mzc4NJD5+5N0jEtAGHlnMsuX1EyRmofjRzX76Lq9quVhOUTEK0
7lVTKuRpQ3pUk8RqG0wu
=8xVO
-----END PGP SIGNATURE-----

--irvp546gQmeKhcdunSsBvXcDf1S3jqASr--
