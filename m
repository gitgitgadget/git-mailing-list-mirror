From: Jerome Vuarand <jerome.vuarand@gmail.com>
Subject: Git config from a Python script
Date: Tue, 7 Sep 2010 14:45:31 +0200
Message-ID: <AANLkTinUi-c+Vo36EYjKoH-0Ye-J0ZFtqeMySdmnHf2L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 14:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsxYm-0003cM-9G
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 14:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab0IGMpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 08:45:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54286 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab0IGMpw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 08:45:52 -0400
Received: by qyk33 with SMTP id 33so5271578qyk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=jwDzkgB8cplqE1Y3oASWR9S/8llAB/rV2T5phrM4xXI=;
        b=w55C8VNonH+SQ/Z8RUppY4p4T9yrO8mA3B1+BCCveca7WpfpOC1fLKqOoRzL55tnq6
         AcRgdCqChWXUFpbGg0GHBAwNj02w0zMTDi7tNWCTsHNR/G5rqWKvT9xIBzSOjjBl6hkW
         so2UB1LLlchslq1tXqMpe41ERPR9AE4JXyiD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=RvfbJCQElWE3mXuIsVeNlnX4Gpa9WX3HGfr7p97OG3i74ffYiGebwLsveLi0L6a72b
         z6tPu3Ef3PHW7q7mHCnwJrDlIvIDW0SYVcWZcdSwqolsK+OYtDuV/s9jKsMdREwl9j1N
         kBvyM8Ff9L9zqHa8liAVtw9wUMEAIIgcpsGNA=
Received: by 10.229.246.141 with SMTP id ly13mr4643001qcb.80.1283863551176;
 Tue, 07 Sep 2010 05:45:51 -0700 (PDT)
Received: by 10.229.68.83 with HTTP; Tue, 7 Sep 2010 05:45:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155700>

Hi,

I'm trying to write Git hooks in Python. I'd like to run some git
commands from the hook, so I'm using the Python subprocess module.
When running the "git config" command, I can only get access to local
configuration, while the exact same command from a command line give
me access to both local and global configuration. I already checked
that environment variables from a program run by python are the same
as when run from the command line. So I'm wondering what else could be
the source of that difference.

I'm on Windows XP, using Git 1.6.4.msysgit.0 and Python 2.6.2.

Regards,

J=C3=A9r=C3=B4me Vuarand.
