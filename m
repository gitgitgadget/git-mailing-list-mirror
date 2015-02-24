From: Phillip Susi <psusi@ubuntu.com>
Subject: Import git log into a spreadsheet
Date: Tue, 24 Feb 2015 15:06:01 -0500
Message-ID: <54ECD9A9.4090507@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 21:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQLkd-0006vf-QA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 21:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbbBXUGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 15:06:33 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:43646 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbBXUGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 15:06:32 -0500
Received: by qcxr5 with SMTP id r5so18643602qcx.10
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 12:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=WektHCO/LCxFIFThTCdXup6mL/+tlHGMFDEW1UHDOAw=;
        b=zUPbsj4IHQFimWkixi8WJ58mQHiilCfogZaWHSug1SekjVA/C93+oycq0eShoM3H0i
         IeRCrFvriRqe9tRnzn2c0Fd8z7UFG4/O7HxrmlERuK/kAowkZst9PhIfM4iAcdi0QUxo
         yyDkk3fEAlpvYUjK3mjNJrnZfNlhCJuVIisMq3lzcxpSgq/ERI4/Fvtbvt0CWG3lz/0+
         Qrou2taaejL5nAzk/2zsyoyjgddRxLenvntxz65dK1+yncb8/C3OokPTZg1K4r/up4ki
         h1WEcMnb+b3i0Gqybh10evadohlgd0BrVc7uKW/XLgiTvkIYTybdMSJUk1a5+3OyA4Cp
         UBxQ==
X-Received: by 10.140.201.84 with SMTP id w81mr41257112qha.19.1424808391595;
        Tue, 24 Feb 2015 12:06:31 -0800 (PST)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id 63sm20130371qhw.30.2015.02.24.12.06.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 12:06:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264340>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm trying to import a git log into a spreadsheet.  I used a simple
- --pretty=format: switch to select the fields I wanted and separate
them with commas to generate a CSV file that can be imported.  The
message body, however, is presenting a problem.  The first problem is
that it contains newlines itself, which normally signal the start of a
new record.  It turns out that even when quoting the field, MS Excel
still fails to import it properly ( good grief MS ), but openoffice
calc does.  The second problem is that the body itself may contain quotes.

I can't figure out a good way to deal with these quotes.  It seems
that replacing them with a pair of quotes should make the CSV valid,
but how can I replace only those quotes internal to the field without
replacing the quotes that actually bracket it?  Is it possible to have
git log use a NULL terminator between records instead of a new line?
Or is there a better way of going about this?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJU7NmpAAoJENRVrw2cjl5RWFEH/Re8o38zp+EqQxrOM7ZfypUy
Ebaqf8Sa3dIs57iJINnNNsy6kTyPGCxPphdI5zbN5DVuduYKldZSMIeQ1S3sysRq
SPH+E0KL1yxWEv8A0s5CKN/THvPHoUMpl0D7850LBrEmfQzyYNBE4NRBLHSPUL2w
pbAaDeQQwmTigwF6J1AYdz3FlZZznVGzR6ST/Tios64G33wePzPOulF8QyXjpQJq
R1QNRc9EmMz+FC1X/BwrPMX0e8YeTipjW+X/s6uMUXB6F9cln0VcNR5QOhDO1JDp
avbdSwl7nQWRX244cKPfX+eujBgC8RnyrLyz74vSsn1vO8BHtSrLMQ5+1Lbymjo=
=MTpF
-----END PGP SIGNATURE-----
