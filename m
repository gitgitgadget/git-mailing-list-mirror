From: David Turner <dturner@twopensource.com>
Subject: Apple git missing source code
Date: Tue, 19 May 2015 14:57:42 -0400
Organization: Twitter
Message-ID: <1432061862.15896.5.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 20:57:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yumi5-0008Sz-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 20:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbbESS5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 14:57:45 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34099 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbbESS5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 14:57:44 -0400
Received: by qgez61 with SMTP id z61so8533969qge.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 11:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=Hs26+F8ZQHzLEyIRSVouTetDDiRX6g0zKxGPLw8TOw0=;
        b=IrQKsANIw/SzDXygx+fxptiYHZQhlp6c63MPmRy7MH2m4NGJ00llW9rOL/KhC9ckOR
         XWuCuxRrz7fo1xQG5lC1D/2mpeeB0MuNNRexXHQzK/vXBcSWaS+szQ/qOJWbhjc2Yej6
         dwCjefQt/lCS2+/mpYwYcb4+Fwlz5SLtRMOK7UF6ysfohiKhTAL8H8RON7FA3bGre2oT
         +tSxPws/0uXkVri6/VvirMwvl5y+7QKWC6JI/SAmVJgzD+gOExrr1Ca5eXA5CHsygaQv
         D3mkDF2L+w46y49IezwRZns1ViqeXHDJIjtRKGvyeSwflNUfTHkIQJk3HYcCR1CSwm4s
         NFyw==
X-Gm-Message-State: ALoCoQmhP0WXag18rMR41cBSmRjkB6Iyzt1e6ZzIIcraWu5Ka2pbNMj5SyFHAJ1/IGCzZ7eXrMVm
X-Received: by 10.229.193.7 with SMTP id ds7mr39288687qcb.8.1432061864011;
        Tue, 19 May 2015 11:57:44 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.145])
        by mx.google.com with ESMTPSA id c20sm9671014qka.21.2015.05.19.11.57.42
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 11:57:43 -0700 (PDT)
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269386>

http://opensource.apple.com/tarballs/Git/ does not include git version 
1.9.5 (Apple Git-50.3), from developer tools 6.2, nor 2.3.2 (Apple
Git-55), from developer tools 6.3.1.  Indeed,
http://opensource.apple.com/ does not seem to include any code for those
versions of developer tools.

I assume that some Apple developer is probably on this mailing list, and
thus can fix the problem at least for git.
