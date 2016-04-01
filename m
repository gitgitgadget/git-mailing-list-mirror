From: Ron Isaacson <isaacson.ljits@gmail.com>
Subject: RPM spec file broken by README.md
Date: Fri, 1 Apr 2016 01:35:18 -0400
Message-ID: <CADrzLrOaeQXjWeCnZSJfWWyfr3kzgm59QvR6SeTiw_E2Xg7ugQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 07:35:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alrjw-0004Az-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 07:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758080AbcDAFfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 01:35:20 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33144 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758037AbcDAFfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 01:35:19 -0400
Received: by mail-ob0-f173.google.com with SMTP id x3so114442929obt.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 22:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=TkX1hJ2l/4Qa2ZVlggsbiXxmX5gweUxNuyWI3q8Fl0I=;
        b=KaWMrPD+g4CZD8b9i9ruDCIZLsib2LNAY3aIcn+2Yd+ztRf1YMo8rtwfPn3jkdpSx+
         Y71D9UUGIMrIkK+3iLmlcj6skCk555fXb6eun5IATkXKuzu2TWunCUAK7w1PXAmd5dZX
         6zIGnmDjJR3lbMHjru575t9Zn2/sfttTvJCIdlXaomqh+zU6fmmS8L+ybHwd0Mx1WBBy
         vbAIDstXbdU1q9jNNB1bdYZlKueUlPqBUe/3cuzrzZwLTAfAldqvOlD0iornlWXT0X5n
         2nORTK7a5ysBNoWNiGpueuNmGCt863NFseur1EkhbWeMjkhBKZ1OdB7QOmRuousBepx/
         ID5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TkX1hJ2l/4Qa2ZVlggsbiXxmX5gweUxNuyWI3q8Fl0I=;
        b=ZxbrsYNZRWYEw+JXg5mmMBTLgGj1MjsjIJs1K2CLZBov/Hn1eDNTqX7/WmUj0WOv0A
         yJR7vcPWrkhJSIjtYsYtWl+B6k/fQJ8KNCKwskZjJKai5PV7QW85dy1XFL0qr/tngPPp
         70ajJWNA2tqhmt/yFm73vQ1/3VDtW2+72m/IbLqEXKMu+aNfCNe/T4nmjpC10a6rHHdU
         GHY5rxYu3FxczVNbhgvFFtxyEeL87StBEzJ9VSiaxYSBUesA60meYIFbz52qjVWNGzff
         g9J7pIPOTJqWYEKU0n6qeJxVCpAmf3NQ/eLjn0mGlfO+aGGUmNOyAwVQHv8ers4EngB9
         QmNg==
X-Gm-Message-State: AD7BkJI99jeSLFp1YeRfdesuwHuxqzi/LOXLNs7Gv2ziamWXZ9sJb42z4ddFEvpltdsdPwz7Fqxiq8mkF+PRQA==
X-Received: by 10.60.142.230 with SMTP id rz6mr1638882oeb.5.1459488918888;
 Thu, 31 Mar 2016 22:35:18 -0700 (PDT)
Received: by 10.157.7.170 with HTTP; Thu, 31 Mar 2016 22:35:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290507>

Hi everyone,

I've noticed that "make rpm" is failing for 2.8.0 because README was
replaced with README.md. This line in git.spec is the culprit:

%doc README COPYING Documentation/*.txt

Would it be possible to change this to README.md to match the source
tree? The rpm packages build just fine with that change. Thank you
very much!

  - Ron
