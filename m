From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: User Authentication ?
Date: Sat, 11 Oct 2008 18:41:33 +0200
Message-ID: <912ec82a0810110941t33343fe1mfe1bce58739f79fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 18:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KohYE-0005jg-IM
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 18:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYJKQlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 12:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbYJKQlf
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 12:41:35 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:51720 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbYJKQle (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 12:41:34 -0400
Received: by yx-out-2324.google.com with SMTP id 8so297839yxm.1
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ap2iCVjTgu4j3klxupsLkUapdaKdDZAAahdfgGst9jo=;
        b=UbaUGvEIoa5zPGGfmxfxwH49Cv8Z7DS9/XXqM/3sx3jz42ReR20LsBK3sqKvv60ECv
         U0Py8dkTZIJwTzbNMOh2mauazy8fpRUmJowgw+9fSX8Yuhc+I+4GL/aRvZB2OzgyNucW
         8DxGMn1nMuOiLw46j2UWjjdWUa1HaPFpjB7Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=BmChrjHWWSymnP8y7oKee+1IDy5IlSyACEBFvyFkIwSA66RVvDjNUeaOGwG9tcDJM4
         AkofUIRpANIXq1vUUAkd1I9CXMsEvz+0SiFhy4+g4Wv//G5A3pQTfI6pW8eQoLquarTe
         HwRYvAUPeHOplommcFmeLCW0M+jKGAt2DpbkU=
Received: by 10.100.152.19 with SMTP id z19mr3874289and.45.1223743293638;
        Sat, 11 Oct 2008 09:41:33 -0700 (PDT)
Received: by 10.100.93.12 with HTTP; Sat, 11 Oct 2008 09:41:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97983>

Hi All,

I want to setup a git server on the web but I need user authentication.

>From what I understand, currently git-daemon does not support authentication.

Is there any way to achieve that ?

I really don't want to give ssh logins for people who I just want to
be able to access my repository...

Thank you,
Pnesh.
