From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/11] add options to for-each-ref
Date: Sun, 14 Jun 2015 01:47:34 +0530
Message-ID: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 22:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rsO-0002ys-F3
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbbFMUR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:17:57 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36815 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbFMURz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:17:55 -0400
Received: by oial131 with SMTP id l131so5450419oia.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=X7M23OPGUvelk26DdsJE8qQVOhXlpHkcQaDhCqV4YfU=;
        b=Lg/qDG2fD/bTikIivmG+XNgTdjjKTK61Zd8+PjQ94Ch41XzyalCeGnvGribeOjmLUl
         fT9QLoL+8BKQRSWfLNzFzvjs1qZGpgFjRqSBBk853ABdBmWD6MTV0vfi5tzkLrjcS5v4
         IUJ9+OIJxyga1WE3SLglNo2cRdpKlwV6eg9KcMm6nlAWS0GC+OoplfpOMAe8lm0NhGK1
         zFU3MOcs/H+MKItkgkEEm369xYxHyjF8rMZ0wK0rzCCnowPeAnARA6XwRNlVsyy95cvl
         RxKY9JG2Xc0IsYGd85AtSxeXDLClW5CHsaBg1hbinzg5DE8I7Yy0JYqX/5l/B5bEbEjF
         4RrA==
X-Received: by 10.182.22.33 with SMTP id a1mr7664748obf.41.1434226674873; Sat,
 13 Jun 2015 13:17:54 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sat, 13 Jun 2015 13:17:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271575>

This is continuation of the patch series 'Create ref-filter from for-each-ref'
found at : http://article.gmane.org/gmane.comp.version-control.git/271563

The previous version of this series can be found at :
http://www.mail-archive.com/git%40vger.kernel.org/msg70929.html

Changes made:
* Added tests
* Added comments to filter_refs()
* Small structural changes
* Various coding style fixes

Thanks to Junio C Hamano, Matthieu Moy, and Christian Couder for all
the suggestions.

-- 
Regards,
Karthik Nayak
