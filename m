From: Anthony Baire <Anthony.Baire@irisa.fr>
Subject: announcing git-svnsync (server-side =?UTF-8?B?R0lU4oaUU1ZOIHN5bmM=?=
 =?UTF-8?B?KQ==?=
Date: Mon, 02 Nov 2015 19:11:59 +0100
Message-ID: <5637A76F.4040600@irisa.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 19:09:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtJYC-0001w6-1i
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 19:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbbKBSJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 13:09:44 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8344 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215AbbKBSJn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 13:09:43 -0500
X-IronPort-AV: E=Sophos;i="5.20,234,1444687200"; 
   d="scan'208";a="185680861"
Received: from halfoat.irisa.fr (HELO [131.254.16.11]) ([131.254.16.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES128-SHA; 02 Nov 2015 19:09:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280706>

Hi,
today we are announcing the first release of git-svnsync

http://git-svnsync.gforge.inria.fr/

Git-svnsync is a bi-directional server-side synchronisation tool between 
a git and a subversion repository.

It is based on hooks and it is designed to allow a smooth transition of 
projects from a subversion repository to a git repository. Git-svnsync 
guarantees that any branch update ('svn commit' or 'git push') is 
applied atomically in both repositories, thus providing a seamless 
experience to the developers.


At the moment the tool is minimalist (syncs only one branch), but quite 
useful in projects where everybody commits in trunk and it is 100% free. 
We have used it internally since 2013 without any major issue and hope 
it will be helpful for the community.

Best Regards
--
Anthony Baire
IRISA/University of Rennes 1
