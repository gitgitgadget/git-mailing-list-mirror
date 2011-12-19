From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Big Mess--How to use Git to resolve
Date: Mon, 19 Dec 2011 18:04:24 +0100
Message-ID: <4EEF6E98.7080000@ira.uka.de>
References: <1324125130643-7103964.post@n2.nabble.com> <86iplf2oy5.fsf@red.stonehenge.com> <1324147247781-7104493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hs_glw <greg@hra.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 18:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcgcw-0004RS-UI
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 18:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1LSRDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 12:03:47 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:47979 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129Ab1LSRDq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 12:03:46 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Rcgci-0000VJ-0P; Mon, 19 Dec 2011 18:03:44 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Rcgch-0001W6-PA; Mon, 19 Dec 2011 18:03:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <1324147247781-7104493.post@n2.nabble.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1324314225.027637000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187458>

On 17.12.2011 19:40, hs_glw wrote:
> Randal, thank you for the comprehensive answer.  I have one follow-up:  we
> have the working files, then in our installation files we have .PL files
> that are worked on by some iteration of "make" to insert paths both into
> .cgi files and config files, should these installation files be setup as a
> branch? or is there a more correct way of implementing this?

If I understand you correctly the working aka source files are patched 
in place to adapt to a customer. I would suggest changing that a bit so 
that the source filename is different from the installation filename. 
Add the source file into the repo and add the installation filenames 
into .gitignore

That way you don't have generated files in the repository. Which is 
usually avoided because they easily get out of sync with their source.

The renaming should be done so you never erraneously add installation 
files into the repository in place of the source files
