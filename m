From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Not a valid object name refs/heads/t20050127-arm during git-cvsimport
Date: Fri, 07 Dec 2007 18:48:30 +0100
Message-ID: <4759876E.4080807@alum.mit.edu>
References: <20071204171833.GD29315@radix50.net> <m38x4auyga.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Baurzhan Ismagulov <ibr@radix50.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 18:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0hJ9-0003xH-5k
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 18:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbXLGRrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbXLGRrv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 12:47:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58601 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbXLGRru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 12:47:50 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.142])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id lB7HldNh014537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Dec 2007 18:47:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre) Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <m38x4auyga.fsf@roke.D-201>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67438>

Jakub Narebski wrote:
> Baurzhan Ismagulov <ibr@radix50.net> writes:
> 
>> I want to import a CVS repo myrepo into git. I copied CVSHEAD and myrepo
>> dirs from the cvs server to /home/ibr/tmp and issued the following
>> command:
>>
>> git-cvsimport -p x -k -o cvshead -d/home/ibr/tmp -C zzz myrepo/drv
>>
>> It fails [...]
> 
> You can try to use other CVS importers, for example parsecvs [...]

Or cvs2svn, which can now also output to git.  See these threads for
more info:

http://marc.info/?l=git&m=118592701426175&w=4
http://cvs2svn.tigris.org/servlets/BrowseList?list=users&by=thread&from=624393

Michael
