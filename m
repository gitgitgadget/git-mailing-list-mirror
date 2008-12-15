From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Interactive rebase encoding
Date: Mon, 15 Dec 2008 15:42:08 +0300
Message-ID: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 13:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCCnP-0002Zs-Eo
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 13:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbYLOMmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 07:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYLOMmL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 07:42:11 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:33290 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYLOMmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 07:42:10 -0500
Received: by bwz14 with SMTP id 14so1768732bwz.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 04:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=cqYXlzQqU42bBD9Vju0gFb36pr7JrmIxb4Pu3t7MLaA=;
        b=A9Yxu9I32h5nJ0l6Hsgnz1McdV88+bkc8LimkxFMRe3SkfOOKj44E5nlzpLs5EpqSn
         0dsGPexpWWn0pP/BZWy4jZzzbaA3WIsBYpYCk66yjlm8mNUOlZePxG43OSo50K6vX1fz
         d9aiywT8OWLKsYSwF/DUxxhOdGPI/md275iXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=P8eeQHuFLr/Y1e+N32EVei6/ESZ58TvPzC4E1akeyQYR93+m8vWVBQvLGNDYIjsLTc
         /Q4s/e4F1lIKsswIDpi3nxI815NyaW/nUixgerSrBPDA6qk0Q2GaZWfgwhdBSXbFCBxm
         wHf6hADdcWNfDp67Hj/0ZqjEIe1WzJZEIIsuA=
Received: by 10.181.226.19 with SMTP id d19mr2523323bkr.35.1229344928277;
        Mon, 15 Dec 2008 04:42:08 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Mon, 15 Dec 2008 04:42:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103159>

The interactive rebase command builds a text file and passes it to
editor specified as environment variable or as configuration
parameter. However the man page for rebase operation says nothing
about which encoding will be used for that file. Apparently
i18n.logoutputencoding is used. I think that the man page for rebase
operation should explicitly specify it.

Also it might make sense to use explicit encoding parameter for
interactive rebase operation.

Constantine
