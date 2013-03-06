From: Yves Blusseau <yves.blusseau@gmail.com>
Subject: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 09:12:30 +0100
Message-ID: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 09:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD9T8-0000td-0x
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 09:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab3CFIMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 03:12:31 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:40328 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab3CFIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 03:12:30 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so5705864pbc.28
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 00:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=FK9PtdOMWQcdikyEnFL6ZQ+zkJG1F9QOIxflh2uE2CE=;
        b=hnQWZOmN9M2ibxk8hG5YqsrrL5wrSZBH6xYyVVeQTK/RqTzeQ5oMrNKQwE0dVodDb/
         x43JP4LEarTl3uOFqlUuPKDATSfF4Jxw/gilBLZSN2VpzKNmRIRqaMYGFRo2tFC9DOAs
         DExtD9m0zf4dx26/f3ur6gCvepBfviIGyJOI4UgryXBKw4WaX0j1set5QeqHzLw3DPwx
         +pR3zudYu68Gy45d54sAT+SA6puYmWGbFv2sVj2Z7nLSctfFoSyeBBZ2drJWDjnaOs1j
         LBr05ceij8y2EH7W/CsxVwVg35wlINLagsixKH5CEPsIsXNXGN+DRwBkMdqRCPatcSLo
         LFJA==
X-Received: by 10.68.220.230 with SMTP id pz6mr44115941pbc.46.1362557550390;
 Wed, 06 Mar 2013 00:12:30 -0800 (PST)
Received: by 10.68.136.225 with HTTP; Wed, 6 Mar 2013 00:12:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217503>

Hi all,

i have a socks proxy to access internet.
I successed in configuring git (with GIT_PROXY_COMMAND) to use the
socks proxy for GIT transport protocol.
But how to use this socks proxy with git for HTTP(S) transport protocol ?

Best Regards,
Yves
