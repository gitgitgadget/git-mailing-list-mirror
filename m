From: Anton <forshr@gmail.com>
Subject: XSS in search form at git-scm.com
Date: Fri, 11 May 2012 16:28:39 +0400
Message-ID: <CANurz1edia5ctzRn9b=H-VZX6o=bmEiS2WMbqyQTXN0VrhYtcA@mail.gmail.com>
Reply-To: forshr@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSoxi-0001J1-8q
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687Ab2EKM2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:28:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40310 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab2EKM2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:28:40 -0400
Received: by yhmm54 with SMTP id m54so2506925yhm.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=juCMGB/6dXoAxs8czKLDvUWP/N1jxEKiPhA+oLJQPfI=;
        b=yLTw+hLtxxMv+Z8HeEQkkKHIrOHgL3TDcsOyb+95YGeoR4mEci+OfUGUm5ruXPxYXw
         ruC3EgaZTjBJ+qq+12/WMrnzsWUr0Wr373bW/aZe7qei1dpp0PxChCaUSr//rOyfT0wp
         mJJaG41jO1XvM55wSlENgiIe6rsyLPZ8z62dNa46RuFufethv1Hwg+T+VIewytLXuBEY
         9Eng/a4Z80XoioEVZbomt6F7E6JrueGJlAYnqCfIO1sBMlcPfcs7BQwXLEaGhoJPrLJP
         A0HkQRdpPnF3GG/QfIr838s7rSIhnEFpio+9fcailz84ZJiEn9dzhwWSCW0IwfLNUktq
         rK4w==
Received: by 10.50.45.167 with SMTP id o7mr1771985igm.22.1336739319788; Fri,
 11 May 2012 05:28:39 -0700 (PDT)
Received: by 10.231.37.138 with HTTP; Fri, 11 May 2012 05:28:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197670>

Hello.

Search form at git-scm.com is vulnerable to XSS.

Short link

bit.ly/KQ2Tcd
http://bit.ly/K7VvJM

Real links
alert
http://git-scm.com/search/results?search=%3Cscript%3Ealert('privet%20Lambda%20:peka:%20_/')%3C/script%3E
Google logo
http://bit.ly/K7VvJM
