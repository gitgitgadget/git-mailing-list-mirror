From: Dmitry Bykov <pvrt74@gmail.com>
Subject: Probably a bug with "~" symbol in filenames on Windows 7 x64 in git 1.9.5
Date: Wed, 7 Jan 2015 18:26:50 -0500
Message-ID: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 00:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9008-0003ml-5f
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 00:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbbAGX0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 18:26:51 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:50066 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbAGX0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 18:26:51 -0500
Received: by mail-qa0-f47.google.com with SMTP id n4so5008477qaq.6
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 15:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+I07Y3X+MR06KcCWXQ4nsEFK09p2EblDVj2Z9za8xes=;
        b=LSyBwnhlORoYBODMoPejZPwVvNQWqTYLsS6VHOD7NFgI/Up3hGl+T+bRQUnitpTUGG
         /d+VIQMNdJ6TtjIHqxOPsE38hM5+UyhALn8CCYtrcJm9WRo1gZb6HWO8cNa528WSf6cg
         Y5kQDhh3bKNJ/hJEK8kQk/qsdu/hCiRVM1JAUMDGqQVZ3e/BAoE+pnVB1yaJRB9qcn5+
         2VNnybV+OGoRn4klk4FvU8F+NAgj4I/618lIV3HB6f+nO4KSflInd7nNrP29ddkJaV7G
         VjkIhHTP2QbmtY0chKx7iQVF4ZGz41tUm0bDGTAVy+Qz6tUf8eW7EcMidrZm86fMIINC
         Y5tg==
X-Received: by 10.229.212.67 with SMTP id gr3mr9502086qcb.6.1420673210379;
 Wed, 07 Jan 2015 15:26:50 -0800 (PST)
Received: by 10.140.42.75 with HTTP; Wed, 7 Jan 2015 15:26:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262166>

Hello,

Recently I installed 1.9.5 git version and faced the problem that one
of the files in my cloned repository with a name ICON~714.PNG is
marked as deleted even repository was freshly cloned. Trying to do
anything with that file resulted in constant "Invalid Path" errors.
Reverting back to 1.9.4. fixed that problem.

Thanks,
Dmitry
