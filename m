From: Preben Liland Madsen <prebenliland@gmail.com>
Subject: Ignore version update changes on git show report?
Date: Tue, 26 Feb 2013 20:53:34 +0100
Message-ID: <DEC76CB0-9E35-40A8-9D73-77617CC605A3@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 20:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQWL-0006Pv-8c
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729Ab3BZTsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:48:36 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:46294 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759991Ab3BZTsc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2013 14:48:32 -0500
Received: by mail-lb0-f175.google.com with SMTP id n3so3365947lbo.20
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=8AO/dscYpmqQzbqO/FHegT2PYexEkOS3cGqO76Qd4/s=;
        b=bbS6oCWY4WGNJAOKJaFlwzYr3wCKp+Sl2PPTBU+/deo5oDAZREwmn6uN5rpm06iw5Z
         qsMhlerrALdhgjLu9CXP6bi6P1+3UO9iYhbENNiEHUYsNwBnMPkCzywIpLTuqJc3bUiw
         s5bt0xGdCwcOVt4L7habdp2K0AsW/R1BXhOQhEhb5JPA6ARslYFzF6cKfYB8EwUDJrkV
         Hz1h70r1T/upKpovvnkT7AAFUUgzsJOAF7ek0jfB4+sTg4hqrLdZUThKcb9GqrSldXoZ
         iRI+Uy9BgLZjrz5IvLkwRunjzFzhzaMJWV+RdEWc0b8xk4uV5GWozLpQKPWU4PWtfll8
         XArQ==
X-Received: by 10.112.103.168 with SMTP id fx8mr1084716lbb.32.1361908110687;
        Tue, 26 Feb 2013 11:48:30 -0800 (PST)
Received: from [192.168.0.100] (ti0016a380-dhcp1358.bb.online.no. [83.109.133.81])
        by mx.google.com with ESMTPS id xw14sm1254563lab.6.2013.02.26.11.48.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 11:48:29 -0800 (PST)
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217168>

Hello, 

I'm trying to investigate some what changes have been done between two versions of a software with the name IP.Board. 

This proves more troublesome than I thought, since their release builder appearantly updates the version number automatically in all files. 

This causes a lot of files to have this as the only change: 

- * IP.Board v3.4.2
+ * IP.Board v3.4.3

Which is quite annoying to have to go through and therefor is responsible for more than 800 files being changed. 

Is there some sort of git command or command I can combine together with git show that will ignore files with only these changes? Something along the lines of ignoring files where the only change matches this change or ignore files that've only gotten 1 line removed and 1 line added? 

Best regards, Preben