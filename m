From: "Thomas Hager" <duke@sigsegv.at>
Subject: Re: git submodule delete?
Date: Thu, 10 May 2012 08:56:16 +0200
Message-ID: <20120510085616.138349f77tk1gplc@webmail.moger.at>
References: <4FAB0D32.3000503@palm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 10 09:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSNxZ-00021y-KX
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 09:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab2EJHip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 03:38:45 -0400
Received: from minbar.sigsegv.at ([83.64.197.38]:48973 "EHLO minbar.sigsegv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756066Ab2EJHio (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 03:38:44 -0400
X-Greylist: delayed 2547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 May 2012 03:38:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sigsegv.at; s=default;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:References:Subject:To:From:Date:Message-ID; bh=37fJrMulnkTPwi5QLkq0//ODGFm7zDo3+vrB1PGzCro=;
	b=Je7YPufaA5Wdslk3WNFJNVF+9ZQO/KvVC9tYLGaUdcr2LB5gLmD1LT6JDbXZHdRztQ39fYAxqIQUgDE7xSo8BhSnSwTOMZDW9BXeCNujleLuNFPXhycjZmRC3yh82AYeYKvqRG2TnebFWtVyknQrQv8mpIb6u/ZFS2qC+WuS68ovtJjzhyKL48bwCuIs2LIbD2ceygYqTSKN5KmJDIHjspzQnbZz9IXpSwMpgnxaF6HiJLqY3OcvE/TRbhARJxkDwYYQkqAPccakAGdPS3ne6TmnYf7pczX0Iua0Qqo70tbY9Rslve6PAzvZz1moAwJ5O2iQ6ja/TqG297ub24rDxA==;
In-Reply-To: <4FAB0D32.3000503@palm.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197552>

Quoting "Rich Pixley" <rich.pixley@palm.com>:
> How do I remove a submodule?
got to your superproject and:

- delete the submodules's section in .gitmodules and .git/config
- run "git rm --cached path_to_submodule"
- commit the superproject
- remove the submodule files.
- remove .git/modules/your_submodule

hth,
tom.

-- 
Thomas "Duke" Hager                               duke@sigsegv.at
GPG: 2048R/791C5EB1            http://www.sigsegv.at/gpg/duke.gpg
=================================================================
"Never Underestimate the Power of Stupid People in Large Groups."
