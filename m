From: Andy Parkins <andyparkins@gmail.com>
Subject: git-fetch fails if remote is detached HEAD
Date: Fri, 19 Jan 2007 11:44:32 +0000
Message-ID: <200701191144.35773.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 19 22:58:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H81kk-0006T2-4v
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 22:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXASV6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbXASV6K
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 16:58:10 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:46011 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbXASV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 16:58:09 -0500
Received: by an-out-0708.google.com with SMTP id b33so322988ana
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 13:58:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OpxpMBK5BCTo/DpMQ++cBDc53bhnGZsjcv75yFxlaJkqlC2X4DTG1PDjNn9nExlLquwsVUSE+O9r+6uYE3wbGlvw9VlpZx8W8GChKajj1kIMGfE8wydcREzIpmRcCyn/pGzmHFpYMUC7A72Dj9sDt9XTrKp2goM3bVNMR4wt13U=
Received: by 10.78.185.15 with SMTP id i15mr215437huf.1169207244214;
        Fri, 19 Jan 2007 03:47:24 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 37sm2330781hub.2007.01.19.03.47.23;
        Fri, 19 Jan 2007 03:47:23 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37206>

Hello,

Running git-fetch from a remote repository that has a detached head 
fails with:

fatal: '/path/to/repository/.git': unable to chdir or not a git archive

A simple checkout at the remote end, and everything is fine again.

I can't quite see why fetch is interested in the remote HEAD at all?  
The only time that is ever needed is during a clone isn't it?


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
