From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 13:19:36 -0800
Message-ID: <43ED0368.7020204@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Feb 11 00:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fgC-0003Iu-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWBJVTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBJVTp
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:19:45 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:37330 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751387AbWBJVTp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:19:45 -0500
Received: by xproxy.gmail.com with SMTP id s18so405352wxc
        for <git@vger.kernel.org>; Fri, 10 Feb 2006 13:19:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Eu5pqfD4bqaYD81Q8JKMUFICR8zSasMaXndqBWbCfWTjf6bdInQFyRJfI8EIq4svmUiml6nAJbrR4dSen5xqljW67ixED6SqWO/Xm0fi9W3dGHxfnn5JyBtl0gEBmw3Ya+sUzZmdH4NK/GpMz5pDVIG+i/OY4idKYbtulRpWoKQ=
Received: by 10.70.87.7 with SMTP id k7mr816407wxb;
        Fri, 10 Feb 2006 13:19:44 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id h15sm1821978wxd.2006.02.10.13.19.43;
        Fri, 10 Feb 2006 13:19:44 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15895>

Running "make test" from an account with an empty gcos field fails test 
6 of t1200-tutorial.sh.

If the gcos field is a single space character, "make test" fails test 3 
of t3500-cherry.sh.
