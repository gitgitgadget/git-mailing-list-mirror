From: Steven Vancoillie <steven.vancoillie@gmail.com>
Subject: gitk error on checkout of branch
Date: Mon, 10 Jun 2013 16:44:46 +0200
Message-ID: <CAJxqeJ8gNBVm=1Z_oKfOXGGrP_Sf+FwoQm1ABhZv8e-OB3M=9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 16:44:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3L1-0002Rd-M4
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab3FJOor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:44:47 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33978 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab3FJOor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:44:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so1670368pab.36
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AFl60iZ1VSxGsvuZZhbPx5FdsMJwdO46yaxnJ4uhx1c=;
        b=bb52rKzfUcn7OHPGBLnt8Ld7v7flzupkHykKAScP1FQzCcOrw2Up4qMttOG9qQdsPZ
         D6gmlcdNeA+EqVyKPuyheh+3q+V8+JBIs4PwBpavkPkqV+lnhnSey8Fee+ukub2hmyS6
         laMWT2+17KJefHEKdOETah05lM1MTJMLqrYxTYd6PS38tWLiwpHz3061LLZPY34GufDz
         KSBepw0f5X2TZZXRaZnxoVstqHeYtBnpuBfFYOX3w5Hido9ACAdNIyJqyOksicIR/BLl
         Au1V4Zia6I8TziBJVG36Rqlvh3ZmWr8N9WgaLgOYgd/ko2CDQRbUtK1SoflmrAH/+zo1
         +yjw==
X-Received: by 10.66.159.195 with SMTP id xe3mr14263701pab.49.1370875486736;
 Mon, 10 Jun 2013 07:44:46 -0700 (PDT)
Received: by 10.70.124.232 with HTTP; Mon, 10 Jun 2013 07:44:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227297>

Hi,

using gitk (git 1.8.3), the program gets stuck when checking out a new
branch if the last checked-out branch was the bottom left branch. The
error occurs consistently in this repository, but unfortunately, I
cannot reproduce the error on another repository. The message reads:

invalid command name ".bleft.bottom.ctext"
    while executing
"$ctext conf -state normal"
    (procedure "getblobdiffline" line 10)
    invoked from within
"getblobdiffline file6 5f7f5bd07fb3de12ce64dee4f19e060c9d62cc54"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)

any suggestions on what to do are appreciated.

kind regards,
Steven
