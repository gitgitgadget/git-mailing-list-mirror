From: Jakub Narebski <jnareb@gmail.com>
Subject: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 00:05:49 +0100
Message-ID: <200711190005.49990.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 00:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IttDP-0000Zi-3E
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 00:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbXKRXFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 18:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbXKRXFx
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 18:05:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:20670 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbXKRXFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 18:05:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1262134nfb
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 15:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2ewTQZd5riPcSuYt/GpNssN655BrCUx/oRF/ik602Gw=;
        b=iRJU8sRNlNF37mNgXytk8txvgiVUcO7bwaJJ55s9t5chvxh3KOdwdgC76aAY+lLCl2y8HdcYw0cPg540Jmr69eVyycdxIFgCDBqGXPwuoNq8ohjCZBEL40WIhKWjMhcsIScuZfrb0T0F5iAJxqjZthexIma52ESLR0GcmfE1W1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pl5lev0fLCZcuOpwrFEj21NAqCzDJD+vPp7YUe7Yy1AyDB6xkzLmSTtco1eaeN6/6rr7DfJXIPZ9hxPN7HVIyZJvPTewMMGaEbzdByXuEwT9K2nuvThIIELzWK5H5vsn2zL+V6oI2MKBtKhGKG3I7FsVeeIMdFrH+GqfHDEVNag=
Received: by 10.86.71.1 with SMTP id t1mr4374904fga.1195427151310;
        Sun, 18 Nov 2007 15:05:51 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.208.67])
        by mx.google.com with ESMTPS id 22sm7927548fkr.2007.11.18.15.05.49
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Nov 2007 15:05:49 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65392>

I use Stacked GIT 0.13 with git 1.5.3.5 (and Python 2.4.3).
StGIT does recognize old StGIT branches (and converts them),
but "stg branch -l" list only one branch. I guess that is
cause by the fact that all the rest of branches are packed.

So the question is: how to unpack branches, and how to prevent
branches from being packed by "git-gc"?

Another StGIT question: how to check if given branch is controlled
by StGIT (needed for my bash prompt)?

-- 
Jakub Narebski
Poland
