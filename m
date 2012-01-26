From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git version not changed after installing new version
Date: Thu, 26 Jan 2012 17:52:44 +0100
Message-ID: <4F2184DC.6070804@ira.uka.de>
References: <loom.20120125T173801-500@post.gmane.org>    <loom.20120125T181639-351@post.gmane.org>   <1327517841.31804.75.camel@centaur.lab.cmartin.tk>   <loom.20120125T202642-92@post.gmane.org>  <1327521489.31804.85.camel@centaur.lab.cmartin.tk>  <loom.20120125T211638-609@post.gmane.org> <1327530594.31804.87.camel@centaur.lab.cmartin.tk> <loom.20120126T144828-400@post.gmane.org> <loom.20120126T161101-463@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: freefly <free.fly@live.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 17:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqSZF-0000VJ-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 17:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab2AZQwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 11:52:53 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33124 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180Ab2AZQww (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 11:52:52 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RqSZ5-0000ax-4I; Thu, 26 Jan 2012 17:52:51 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RqSZ4-00035e-W4; Thu, 26 Jan 2012 17:52:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <loom.20120126T161101-463@post.gmane.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1327596771.931208000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189153>

On 26.01.2012 16:13, freefly wrote:
> that doesn't seem to change the path :(
>
> which git =>  /usr/bin/git
>
> version still points to the old one  :(
>
> This is my current path that I changed, as you told me to do...
>
> /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin

Put /usr/local/git/bin in front (it is easy to overlook the "git/" in 
there as software often uses /usr/local/bin)
