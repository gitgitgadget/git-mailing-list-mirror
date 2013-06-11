From: Chico Sokol <chico.sokol@gmail.com>
Subject: Exact format of tree objets
Date: Tue, 11 Jun 2013 13:25:14 -0300
Message-ID: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 11 18:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmROA-0001KC-5t
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 18:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3FKQZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 12:25:37 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:51899 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3FKQZf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 12:25:35 -0400
Received: by mail-ve0-f176.google.com with SMTP id c13so5853739vea.21
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=QUdnLjgpo/GFvRlyUVtcQKD9iwYYY3VoWzY9E/QwUUw=;
        b=BAR1FpjnrJobMzDnrvQp53SK7ngEsmQM8Q/Mys0ZjEnJLQsXQrsWVE5A4lwJwc0knv
         BrQJWAzKGoyo3cf1MwlQceYB6sIKfS0MnC8AexkS7ohFmmOSvCvlxc5EzU1FNz02gG5p
         +hxnwXmqDgK3MV7DYOT32P13SQjq5gP4uQ9s8yz7fBeKlnP9b6FJIDWXmWT/6J6VBYgg
         UXmkGSW08l4hP6PgpVNsNzQn8z2D6xrp9HXaxRjbUfGHRnNO0f30zrT/N5sYDhtu45k4
         uwxnfYooCPdYo55kTpyMXiTOzQHPrMbo3thOag2Roy4Aj5mEeBNgc8m6map35ZCO9CEY
         AYjA==
X-Received: by 10.220.76.137 with SMTP id c9mr8204470vck.48.1370967934615;
 Tue, 11 Jun 2013 09:25:34 -0700 (PDT)
Received: by 10.221.2.134 with HTTP; Tue, 11 Jun 2013 09:25:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227460>

Is there any official documentation of tree objets format? Are tree
objects encoded specially in some way? How can I parse the inflated
contents of a tree object?

We're suspecting that there is some kind of special format or
encoding, because the command "git cat-file -p <sha>" show me the
expected output, something like:

100644 blob 2beae51a0e14b3167fd7e81119972caef95779f4    .gitignore
100644 blob 7c817960e954f0278a6eee8d58611f61445167e8    LICENSE.txt
100644 blob 30e849cba985d74bfd29696f6dee5a40abaacb03    README
=2E..


While "git cat-file tree <sha>" generate an strange output, which
indicate some kink of encoding problem. Something like:

100644 .gitignore+=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD,=EF=BF=BD=EF=BF=BDWy=EF=BF=BD100644
LICENSE.txt|=EF=BF=BDy`=EF=BF=BDT=EF=BF=BD'=EF=BF=BDn=EF=BF=BD=EF=BF=BD=
XaaDQg=EF=BF=BD100644 README0=EF=BF=BDI=CB=A9=EF=BF=BD=EF=BF=BDK=EF=BF=BD=
)


Thanks,







--
Chico Sokol
