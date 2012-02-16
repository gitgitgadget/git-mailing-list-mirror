From: Chris Leong <walkraft@gmail.com>
Subject: diff -G with case insensitivity
Date: Thu, 16 Feb 2012 11:18:54 +1100
Message-ID: <CAJ6vYjejtZkupy750rvz6HW_0SNPyBVTa78DO4nY8Bi368neQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 01:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxp4C-0008Td-VW
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 01:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab2BPATQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 19:19:16 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51677 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab2BPATP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 19:19:15 -0500
Received: by bkcjm19 with SMTP id jm19so1475510bkc.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TojPFlpUAmMt0Q76gIe8mSRWMPVRhTC/MIbKXKHZkQI=;
        b=afGxVNhX2sNh+Zmgn1LxMUXNJ4SxhnArwCQCoMuus4uZr4gTvJb4GzI5W+528OTNs6
         x+jzQ+D2saRtwH699ATqS6IACepD7gkuXbS26A6yV/X428sVpBL8hr2ZagrBWiPlgCC4
         K23QP7ast4GnC/ax9gxGiQ9Fyq+07FuU1PEEk=
Received: by 10.204.156.77 with SMTP id v13mr98134bkw.112.1329351554278; Wed,
 15 Feb 2012 16:19:14 -0800 (PST)
Received: by 10.205.34.200 with HTTP; Wed, 15 Feb 2012 16:18:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190867>

Is there any way to run diff -G with a case insensitivity flag?
