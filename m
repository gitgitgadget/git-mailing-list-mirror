From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: git-revert doesn't run commit-msg hook
Date: Mon, 21 May 2012 14:29:46 +0300
Message-ID: <CAGHpTBJBxVcSX_0qqfFv==qyP4cpoY+U5yK-SB1Firo_uwqX3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 13:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWQoD-0000gj-3i
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 13:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab2EUL3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 07:29:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59181 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab2EUL3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 07:29:47 -0400
Received: by bkcji2 with SMTP id ji2so3845415bkc.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kJ7tLPJUNILt3ufocVUNVd/SY8ZemN/kQZQjE08T7zc=;
        b=yUWb7czHG+ptjAqfhehbfVR7F77SBEk9oWhkJUBTN9f/B5r1m7x6+Y68i2YuVv5sT/
         cOw2GotNy+oSJWltpvcDjVe3gA67B1lZwdpFif/mAT2XqFZZJBi+LyZcJ3WBPnWJTOeS
         wIUnmeG5NCM5BP1Ja6VQEtPHqu5BRAjunHi0kccJG5Z5YKp3IuiC/ZY3YfibjRnw9Whf
         0vtTW+Wv7+/DTD75ccuNKPwR+8etwq2YVJ/cAeHxEqVItRpVriUSWFT6Awxs6fgRxKOY
         O48kMaX0UlNHv2WTVEHKJvPhXeQ4yve3dtPlII0mDvc0IaIJxtY3XA+594+f3jfpNzyV
         fz/Q==
Received: by 10.204.130.194 with SMTP id u2mr7250865bks.2.1337599786286; Mon,
 21 May 2012 04:29:46 -0700 (PDT)
Received: by 10.205.82.9 with HTTP; Mon, 21 May 2012 04:29:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198100>

Hi,

Running git-revert opens commit editor, but doesn't run commit-msg
hook afterwards.

- Orgad
