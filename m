From: Justin Dearing <zippy1981@gmail.com>
Subject: Setting the http proxy server in git for windows
Date: Tue, 7 Apr 2015 09:10:02 -0400
Message-ID: <CABsCM1M+bC4U243tdg-BY9h_WJ2hq+NpG-d8x878pox6pdzjLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 15:10:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfTGc-0005tF-A7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 15:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbbDGNKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 09:10:05 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:33871 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbbDGNKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 09:10:03 -0400
Received: by qcyk17 with SMTP id k17so19943867qcy.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=J6qrFR8wONJIAWIGu447Rt38/3EwTJSF45xHDOMvyJI=;
        b=s3CD3XsBkJrs6Utg6vsTqY9pdUydqwZRA+1cA2PxTu5t8WhZRftZEzfDnA65gxB06b
         VaKYIXiVIFhPxO++X6g+DTUFPqXNGWc8PGf4/zpHduxJh5kx/21nRR96mPY6UwsKnM6o
         1hV1eLFhh4++Ea+mAjeCcQ4RffzNECmPvNXi4LOOG+Cq6EOEuoChlyaPrPIxJseD7cSJ
         H02nEbKFdY4EL6aqNv7OtINjzgMSLtk7kDlG7LZmgSnY8nD+tF3rKS+33isdtkGWCe6y
         iePgeO+IfmuvcdVtSk0ryT1Q4WAkm2HEMscC/7Wtpnn/4+0XO4q4SF9zkGpwhypn9fJA
         XOaA==
X-Received: by 10.229.96.194 with SMTP id i2mr23910078qcn.1.1428412202738;
 Tue, 07 Apr 2015 06:10:02 -0700 (PDT)
Received: by 10.96.205.193 with HTTP; Tue, 7 Apr 2015 06:10:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266910>

According to the git documentation on http proxy:

http.proxy

Override the HTTP proxy, normally configured using the http_proxy,
https_proxy, and all_proxyenvironment variables (see curl(1)). This
can be overridden on a per-remote basis; see remote.<name>.proxy

On windows, proxy settings are traditionally stored in the Registry
and accessed via WinInet settings. Is there any way to make git
respect these settings so that, for example, I could transparently
intercept git traffic with fiddler.?

Regards,

Justin Dearing
