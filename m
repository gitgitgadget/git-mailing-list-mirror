From: Jakub Narebski <jnareb@gmail.com>
Subject: git bundle magic, and other questions
Date: Sat, 24 Nov 2007 00:33:54 +0100
Message-ID: <200711240033.54953.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 00:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivi2V-0002pc-RX
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 00:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXKWXeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 18:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbXKWXeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 18:34:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:50522 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbXKWXeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 18:34:07 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2916261nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Ih6lbl3gKedb11stmCbtO5+NyUFUEcu75ZxjdhXgjoQ=;
        b=Hor0iPL5k29OpDPWW2v2dM4c9VDjCj9s1JoGTH6klFkEKFkPjOb1WRpmP+n2vHdOh664qEv7SvYkwVWdSdn7b2xaKXGR26nD6TAUeUhu6dv/cKU+hWTXKnoafg7Jp2qvvGgcT/bkPXEGlnmCLfgsSSylJFK8km2ETEzNPJCHUb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jpyMw4fY2kFpGT8bajCpG9Ov91w02qlwiZp5UpFEdtZvqy94W0i0Oy5gEISgGuc0ffZRI36WVA33Ii3cJzxYEWaApHSYna63sBx0PjcwtCoUTcqRVYCdhmRlCdtJAAWY7Ud3QxIENLYqn4R419gEyPkn73N89BOLj5/65jU6EBc=
Received: by 10.86.77.5 with SMTP id z5mr8025019fga.1195860844873;
        Fri, 23 Nov 2007 15:34:04 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.222.15])
        by mx.google.com with ESMTPS id d6sm3180416fga.2007.11.23.15.34.02
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 15:34:03 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65932>

Do there exists some agreed upon common extension for git-bundle, or is 
it just *.bundle (like *.patch)? Do bundles use some magic identifier;
can I add something (and what) to the 'magic' file, so "file <bundle>"
would return "git bundle data" (or equivalent)?

Can I view contents of bundle in gitk or qgit, or giggle?

-- 
Jakub Narebski
Poland
