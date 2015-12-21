From: Julian Andres Klode <jak@jak-linux.org>
Subject: Applying attached patches with git-am fails due to leading > in patch
Date: Mon, 21 Dec 2015 18:21:25 +0100
Message-ID: <CAEA6rAyhsuVvji=KjX3q+rq-tF4TTRfAgxjpTcPFU_YkNE-gfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 18:21:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB49e-0002xT-EC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbbLURVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 12:21:47 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33002 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbLURVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 12:21:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id p187so77004761wmp.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=mrHT/VWP+L7IU/qJD4LCCg1p7eRWek2nj7nCdmVXv0w=;
        b=Dhb+sQJNbzgyZyA8XHzt1EHW0BJXozvBPOSzn5Vhv7heaOp0LI/n4NMHMFJEwEWHIe
         M6O5ihBbxxI/8ffZFfGjb4+Ee2VWVfZ/4rJTsH4Cnq+KL/+kDpA/PV6GzgqqHJ2cEsiL
         e+BcGomh9tFRXaAo9xElda+n2bu1AgnpAnoyJRSErKZd0bX6kKsXSC583CNof1wqvV0t
         wVg95Y0J8YFnEuSTaobAu1Cw+szeRLx7cxtbknlmVslTUTBrL+La0XYqg8ymZmm4PM+f
         0yc/2v+LzPM9WtHy0eaf+I9IE4pkMLU2nw6uIHdfkbjCoiXhLCDj1PJiepZwcQGjbIVV
         ou6Q==
X-Received: by 10.28.211.205 with SMTP id k196mr21221896wmg.13.1450718505188;
 Mon, 21 Dec 2015 09:21:45 -0800 (PST)
Received: by 10.28.4.151 with HTTP; Mon, 21 Dec 2015 09:21:25 -0800 (PST)
X-Google-Sender-Auth: z3-BMmO-TWssdz5HjVpS-KLVxqk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282800>

Hi everyone,

when I get an email with a patch attached, instead of inline, and save
the attachment; the first line "From <hash> ..." has a ">" in front of
it, which causes git-am to not recognize the patch format.

Would it be possible to just ignore the > on that line and then read
the patch correctly? It's a bit annoying to have to remove one byte at
the beginning of the patch before I can apply it.

Thanks,

Julian
-- 
Julian Andres Klode  - Debian Developer, Ubuntu Member

See http://wiki.debian.org/JulianAndresKlode and http://jak-linux.org/.
