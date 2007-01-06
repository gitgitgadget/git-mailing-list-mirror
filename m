From: Len Brown <lenb@kernel.org>
Subject: Re: fatal: unable to create '.git/index': File exists
Date: Fri, 5 Jan 2007 22:01:39 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200701052201.39727.lenb@kernel.org>
References: <200701051150.09968.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 06 04:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H31p7-0000xA-9b
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 04:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbXAFDCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 22:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAFDCP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 22:02:15 -0500
Received: from hera.kernel.org ([140.211.167.34]:57995 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbXAFDCO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 22:02:14 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l0631jDJ026865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 6 Jan 2007 03:02:12 GMT
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200701051150.09968.lenb@kernel.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/2415/Sat Jan  6 00:59:24 2007 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36072>

On Friday 05 January 2007 11:50, Len Brown wrote:
> I kicked off a pull.
> Realized I was on the wrong branch
> and immediately did a ^C
> 
> Now I can't change branches:
> 
> # git checkout release
> fatal: unable to create '.git/index': File exists
> fatal: unable to create '.git/index': File exists
> 
> git reset --hard
> does not help.
> 
> curiously, moving .git/index to /tmp and repeating
> results in the same error.

rm .git/index.lock
seemed to do the trick.
Hopefully nothing is toasted by this...
