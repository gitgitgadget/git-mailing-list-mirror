From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Running git on ARM systems
Date: Thu, 1 Mar 2012 16:11:16 +1100
Message-ID: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 06:11:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2yIo-0002Td-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab2CAFLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 00:11:38 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:46717 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab2CAFLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 00:11:37 -0500
Received: by wejx9 with SMTP id x9so99608wej.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:11:36 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.80.8 as permitted sender) client-ip=10.180.80.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.80.8 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.80.8])
        by 10.180.80.8 with SMTP id n8mr6917745wix.14.1330578696460 (num_hops = 1);
        Wed, 29 Feb 2012 21:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Tl/aUihOc0aogFv69SuV5CFOdannirS+qGVhuHHox5E=;
        b=KSrZ0yRt+JsknPyuoIR7VsIQeIDOxtlpVskvq7RuSTJ4WTHR12w89WqJ/cikUUN2py
         MBkavcYLwAzaY+LtderD7kbRtgOtE5wvyR9wWoI4c90tnPgrHpS12AJtRHCwU71kbVP4
         QfKlUy0nfTdhq/HnjErhzAtT/Xr4Cx2h144vo=
Received: by 10.180.80.8 with SMTP id n8mr5546354wix.14.1330578696424; Wed, 29
 Feb 2012 21:11:36 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 21:11:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191894>

Hi everyone,

You may have heard of the Raspberry Pi [1], a fully programmable
computer the size of a credit card for $25-$35. It will run a linux
(debian/fedora/arch) distribution on a 700 MHz ARM1176JZF-S core
(ARM11 family) [2].

My one of these is on order, and the first thing I intend to do is
install and test git. Has anyone had any experience running git on
ARM, or know if there are any potential issues? I will also try
compiling on the device itself, and was wondering if there is anything
I will need to do especially for that architecture. I have done a
preliminary google search and nothing striking came up, so any help
would be appreciated!

This device was designed to try and get kids into programming, and if
we are going to teach them how to hack we should give them the best
tools available. Hopefully git works out of the box, but if not it
would be great to get it up and running before the education launch
(probably later this year).

Regards,

Andrew Ardill

[1] http://raspberrypi.org/
[2] http://en.wikipedia.org/wiki/Raspberry_Pi#Specifications
