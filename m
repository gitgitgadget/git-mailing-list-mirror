From: Markus Elfring <Markus.Elfring@web.de>
Subject: Speed of conversion from Subversion repository to Git
Date: Mon, 01 Feb 2010 19:05:19 +0100
Message-ID: <4B6717DF.8020004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 19:05:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0eU-0004iZ-Tp
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab0BASF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:05:28 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:37625 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab0BASF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:05:27 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id F1BF113CF0E4B
	for <git@vger.kernel.org>; Mon,  1 Feb 2010 19:05:25 +0100 (CET)
Received: from [78.48.67.5] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nc0eL-00072l-00
	for git@vger.kernel.org; Mon, 01 Feb 2010 19:05:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/ObEgCs4Kx5R2Exjbnckk2zk4YnB5AYX92HIjP
	6JecAVGHn3DCthwgm1ck+osx3UUokWsi1kEoqALliDDvop5sM/
	t0qzCGyAT4rTb1cONvEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138634>

Hello,

I am trying to convert the YaST Subversion repository into a Git variant on my
system. Unfortunately, a command like "svn2git
http://svn.opensuse.org/svn/yast/" does not finish this attempt after 1,5 days
(> 715:13.24 CPU time) here. I would appreciate suggestions for improvements of
the execution speed.
(Renicing of the process "git-svn" does not help to increase its processor
utilisation in noticeable ways.)

Regards,
Markus
