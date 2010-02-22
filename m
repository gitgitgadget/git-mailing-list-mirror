From: Jon Seymour <jon.seymour@gmail.com>
Subject: working out where git-rebase is up to?
Date: Mon, 22 Feb 2010 21:09:18 +1100
Message-ID: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:22:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVED-0005j9-9l
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0BVKJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:09:19 -0500
Received: from mail-pz0-f192.google.com ([209.85.222.192]:44491 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab0BVKJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:09:19 -0500
Received: by pzk30 with SMTP id 30so19431pzk.22
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 02:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=exS06fVaIEdzy8CnA7j6zhCfdVmp2hccqRn1nkK1e/8=;
        b=e5KCqgmH8zWeI/bTAzpHvlyhdGWiQUqkalcWnBrGkykbd71wWXuk1aSA9C0qM1eV8a
         0JP6udrydwu5OLBpD4gv7/7qv3WzF+ATisWZYHEJBq9ymNSSo9nsRNXoxgAZtzEM6dpn
         uRGq3KxseFhTCpjcu1gwjPgtCiosBaLgRNx5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wt0ihFIJuquaSuy6sL3xYd6+rtXjMz5LHi5S56LS1yldvihcHEIp8C7JyJ5zXroQ/x
         w285bJUN/M1DKhQAjM0LGdIElmODI5lHu82ZW0DyqCWm+SlZ/8fEM+2cc+yw0+UK+vUO
         +BGpms54YpMHCzLKf73nKXIyhRrUX3cbqxIHM=
Received: by 10.114.249.9 with SMTP id w9mr284596wah.199.1266833358239; Mon, 
	22 Feb 2010 02:09:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140661>

Hi,

For my funky "compensating rebases" I need to know where an automated
rebase has stopped. In particular, I need to know the sha1 of the
commit that caused the rebase to stop.

No doubt rebase is tracking this info, but is there a supported way to
discover it?

jon.
