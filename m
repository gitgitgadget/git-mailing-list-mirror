From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Problems using cg to clone Dave Millers repository
Date: Wed, 19 Jul 2006 17:35:31 +0200
Message-ID: <44BE5143.70005@uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: davem@davemloft.net
X-From: git-owner@vger.kernel.org Wed Jul 19 17:36:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3E5a-0000JZ-DS
	for gcvg-git@gmane.org; Wed, 19 Jul 2006 17:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWGSPfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWGSPfv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 11:35:51 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:25761 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S1030188AbWGSPfu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 11:35:50 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id 33CB11AB18E;
	Wed, 19 Jul 2006 17:35:49 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 6BEAC1AB16E;
	Wed, 19 Jul 2006 17:35:48 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24003>

Hi,

I'm having trouble cloning Dave Millers kernel repository:

takis@issaris:/tmp/a$ cg-clone 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git
defaulting to local storage area
Fetching pack (head and objects)...
fatal: unable to connect a socket (Connection refused)
cg-fetch: fetching pack failed


takis@issaris:/tmp/a$ cg-clone 
http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git
defaulting to local storage area
Fetching head...
Fetching objects...
Getting alternates list for 
http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/
Also look at http://kernel.or
error: Couldn't resolve host 'kernel.orobjects' (curl_result = 6, 
http_code = 0, sha1 = ae1237750a9178b81d61308f9228f4f92a7402b2)
Getting pack list for 
http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/
Getting pack list for http://kernel.or
error: Couldn't resolve host 'kernel.or'
error: Unable to find 27fd37621255799602d74e94d670ff7a1658d40a under 
http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/
Cannot obtain needed blob 27fd37621255799602d74e94d670ff7a1658d40a
while processing commit 322045cc61d1dae9ff9e9ba2d7d4768fe1b3385d.
Waiting for 
http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/objects/d3/a269671c4c20a942bda04579d8d0e6ebf82c73
progress: 8 objects, 6468 bytes
cg-fetch: objects fetch failed


takis@issaris:/tmp/a$ git clone 
http://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

takis@issaris:/tmp/a$ git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git
fatal: unable to connect a socket (Connection refused)
fetch-pack from 
'git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git' failed.


With friendly regards,
Takis
