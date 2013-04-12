From: Sivaram Kannan <siva.devel@gmail.com>
Subject: Re: Git crash in Ubuntu 12.04
Date: Fri, 12 Apr 2013 18:58:24 +0530
Message-ID: <CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
	<CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
	<20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 15:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQe1m-0003wV-5w
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 15:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab3DLN20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 09:28:26 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:56260 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab3DLN2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 09:28:25 -0400
Received: by mail-vb0-f54.google.com with SMTP id w16so2131856vbf.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sOpk/JyMlY+2dahDLNvOJYd7oIrgpeGw4BsTBP160NY=;
        b=kX0IEQrCZQsdrmui3Nd7TOtBHoYQeME7jp+yoiP8uXE6v5szl7Jf6goleFU0fkymjZ
         BOVPbJov/gE3w0XORuyiLZtnkjBTegSCUwxOEb9VnaEdT/Sxo/Ntnj8nWM+K1m8Bw4/t
         7nxtnITqMCT49GJylhvlAsXx9ebszHEbMi4iz3IdVhfcp+uCIMU6RL4WQxmkGSnqY0FM
         NltxbsLhciQ5aPIjoLV5ZNh4B7HrzbnsowJ3PAjlXV6A0X/4m2RDhYEKfVO2YjUYJnmy
         n/qq6DaWWxeJ84y0qGmoKytj3yBp3qgJnyfSbYd1SAXeJ32kCPWf5VGL89NOrh4skV+k
         mjug==
X-Received: by 10.58.12.225 with SMTP id b1mr1826887vec.20.1365773304702; Fri,
 12 Apr 2013 06:28:24 -0700 (PDT)
Received: by 10.221.3.131 with HTTP; Fri, 12 Apr 2013 06:28:24 -0700 (PDT)
In-Reply-To: <20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220978>

Hi,

>
> ^^^ Try to issue the
>
> $ ulimit -c unlimited

Have set the git user's crash limit to 1GB in
/etc/security/limits.conf and still getting the same error when
issuing gdb to the crash file.

>
> command in your shell before attempting the cloning -- this should
> remove the upper limit on the core file size.  And try look for the core
> file in the current directory after the crash occurs.  I'm not sure
> Ubuntu's "crash interceptor" won't kick in, but just in case...

You mean, /usr/bin/git? crash file for git is getting created each
time it crashes in /var/crash.

Can you please tell me what else I could try? Would upgrading to the
1.8.2.1 - latest in Ubuntu PPA would help?

./Siva.
