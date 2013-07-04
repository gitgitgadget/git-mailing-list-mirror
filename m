From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 0/6] Corrections to the mailmap file
Date: Thu,  4 Jul 2013 16:04:13 +0200
Message-ID: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 16:04:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuk98-0001uf-1C
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab3GDOE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 10:04:26 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:50186 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab3GDOEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 10:04:25 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf17so676062bkc.35
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tsRIXm07/olkEjTQXJ0jaVza1aNKIITdMF1PE+yDe0I=;
        b=jTLt7Wo3O1fN27+xR/MS2aAR4Tk0bkbrldEoe8ODMKzPRygOTZguLQlyiBI9vvjjdH
         WSQjgtMcZ82COMo+/YNlWEJUriFOjH6fRiGXYSt15XklCI4mQj/pmeonfMRTN8KSNIbj
         Zds5+Nw+SHUFWYcFF3i4t6aeTdptv6OIWmCkQmyNIULXLwhh0A+58G3SzCV8tGRiStXM
         HTSQI6oLZ4MJsmWPDiZ+pe+hfjavfjqLIGdf5yg1zaQTtV8yDxx7GXxGFNhuylzG162y
         1fGSDLm5Ia1S0u2fBwS7ygUqQZOT04Wz7Ixk6tk6BuRxw0Xgvddeac63+nTWDcdykGof
         2Yag==
X-Received: by 10.204.228.207 with SMTP id jf15mr1135938bkb.16.1372946663305;
        Thu, 04 Jul 2013 07:04:23 -0700 (PDT)
Received: from localhost (eduroam-74-151.uni-paderborn.de. [131.234.74.151])
        by mx.google.com with ESMTPSA id de17sm1069241bkb.5.2013.07.04.07.04.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 07:04:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.636.g7943f03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229582>

Hello,

I noticed many duplicates in email addresses but having the same name b=
y
running:

    # Finding out duplicates by comparing names:
    git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d

Most of these entries are most probably the same person, but we cannot =
be=20
sure, as there might be different persons having the same name, then th=
ey
are only distinguished by the mail address.

However I suspect most of these to be the same person, having changed=20
mail addresses.

Here comes an initial batch of corrections to the mailmap file, which
maps people with email addresses of different capitalization onto
the same entity.
(Example Name@MIT.EDU is the same as Name@mit.edu)

I intend to contact each of the persons individually and ask whether=20
just their mail address changed, or if they are indeed different person=
s.

Stefan Beller

Stefan Beller (6):
  .mailmap: Multiple email addresses of Alejandro R. Sede=C3=B1o
  .mailmap: Multiple mail addresses of Alex Riesen
  .mailmap: Multiple mail addresses of Paul Mackerras
  .mailmap: Multiple mail addresses of Keith Cascio
  .mailmap: Multiple mail addresses of Johannes Schindelin
  .mailmap: Multiple mail addresses of Toby Allsopp

 .mailmap | 9 +++++++++
 1 file changed, 9 insertions(+)

--=20
1.8.3.2.636.g7943f03
