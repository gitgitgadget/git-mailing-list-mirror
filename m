From: eric liou <accwuya@gmail.com>
Subject: is this a bug of git-diff?
Date: Wed, 15 May 2013 14:23:07 +0800
Message-ID: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e011776577ee65d04dcbbc8a5
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 08:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcV7J-000879-9d
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 08:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab3EOGXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 02:23:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43963 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab3EOGXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 02:23:08 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so1546919obb.33
        for <git@vger.kernel.org>; Tue, 14 May 2013 23:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=1VbzyEH7cWW4tO5y0RxaT+RldTRXvWFpSzAoeD9y6kk=;
        b=jrB+CzWeRiXRJ7eE/l6SdblLmlk+786h8t4kItqIOeByO13AeiywLyOOYTEJDVlZMu
         FNnn8MyNWTVnzr4pieE4t8UyfzSu8kZ3nyRNMMYYhJOUtLIeJBqgqnMgPJicudJjOyAZ
         PRJMel2KQzflcW+d9fKodAhT7ctpN+oQht6BJDzIZL1WprFg+ziKuOJhgdpHjpMiLkF3
         QS4ci6oOWa6aiSDz7pbeG9UswhbBgLO+yxx9QHZJj0LIou7/pmCfS0b+Ku+D3VjgnECj
         u9Ih+5JzPLuzqG8uoooDyexdAZbZxeL6XdIspY6LvzBsHUCclSo5rsFIGoOcTv9VhuZd
         bzlg==
X-Received: by 10.60.179.72 with SMTP id de8mr14409935oec.66.1368598987595;
 Tue, 14 May 2013 23:23:07 -0700 (PDT)
Received: by 10.60.62.165 with HTTP; Tue, 14 May 2013 23:23:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224382>

--089e011776577ee65d04dcbbc8a5
Content-Type: text/plain; charset=ISO-8859-1

The output of git-diff is different from my expectation.
It may skip some lines of context.
For the case of the diff result attached here, a blank line and a line
with a leading slash is skipped.

Please check out the attached files for details.

Thanks.

--089e011776577ee65d04dcbbc8a5
Content-Type: application/octet-stream; name="ab.patch"
Content-Disposition: attachment; filename="ab.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgq4h3t00

aW5kZXggMWVmMmJmNS4uZWYyMjA2YiAxMDA2NDQKLS0tIGEvdC5jCisrKyBiL3QuYwpAQCAtNCw1
ICs0LDYgQEAgaW50IGEgPSAxOwogICogMQogICogMgogICogMworICogYWRkZWQKICAqLwo=
--089e011776577ee65d04dcbbc8a5
Content-Type: text/x-csrc; charset=US-ASCII; name="b.c"
Content-Disposition: attachment; filename="b.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgq4h3to1

aW50IGEgPSAxOwoKLyoKICogMQogKiAyCiAqIDMKICogYWRkZWQKICovCiA=
--089e011776577ee65d04dcbbc8a5
Content-Type: text/x-csrc; charset=US-ASCII; name="a.c"
Content-Disposition: attachment; filename="a.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgq4h3u62

aW50IGEgPSAxOwoKLyoKICogMQogKiAyCiAqIDMKICovCiA=
--089e011776577ee65d04dcbbc8a5--
