From: Perry Smith <pedzsan@gmail.com>
Subject: git 1.6.1 on AIX 5.3
Date: Mon, 26 Jan 2009 14:02:15 -0600
Message-ID: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 21:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXgQ-0007I9-Sx
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbZAZUCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbZAZUCV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:02:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:21242 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZAZUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:02:21 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2904857qwe.37
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=GMH03LUR4Q2l11QtNsFjU62y/2qEoqhIbzY/pI2snqA=;
        b=lgfZyAEm7x1cl5A6EB7PA1whZltlWueAze6+8phx3qsDAy1GBu4venazH8M/Ocfnoy
         mdCSr99RvEikQpQhl6ROxQirOKMX/sEiZ5hxeY1L4dcoL0g46WZkqxeWmFMI7ngvb3TM
         WmMGLYpljynWG7R/tr42n1ohqaAR2e5hHh6fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=WWbGcCKaAHGr8v0PuNy2Y89ogXeEu3xs0xomgkpkjpfEKUUTpLeUOTFUAp54pdjnTl
         08iy4tNTdHjSIpIiR+k+k8mDHb11/OoZRWbPFgx+YLT7sl2RWB5YtFB/0uf9bQTwZTaq
         SyjNpmG5aXCXpxkmtXIoq8HlD377tANZ1lJ+Q=
Received: by 10.214.181.12 with SMTP id d12mr6391783qaf.140.1233000139017;
        Mon, 26 Jan 2009 12:02:19 -0800 (PST)
Received: from NewToy.austin.ibm.com ([32.97.110.64])
        by mx.google.com with ESMTPS id 6sm424379qwd.54.2009.01.26.12.02.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 12:02:17 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107263>

I tried building git 1.6.1 on AIX 5.3 as an "out of tree" build and it  
does not seem to be set up to do out of tree builds.  If that is not  
true, please let me know.

The install process wants to call install with a -d option.  AIX has  
two install programs but they are pretty old -- neither takes a -d  
option.

Is there a GNU install program I can get?  I've not been able to  
locate one.

The curious thing is I installed git 1.5.6.4 on a similar AIX system a  
few months ago and succeeded.

Last -- just so I know for future reference, is this list a 'text only  
email' list?

Thank you for your help,
Perry
Ease Software, Inc. ( http://www.easesoftware.com )

Low cost SATA Disk Systems for IBMs p5, pSeries, and RS/6000 AIX systems
