From: Rudinei Goi Roecker <rudineigr@itflex.com.br>
Subject: Git config not working correctly with included configurations
Date: Tue, 12 Apr 2016 08:25:39 -0300
Message-ID: <assp.0910338c53.570CDB33.9020300@itflex.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 13:32:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apwYV-0000pG-MN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 13:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbcDLLcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 07:32:23 -0400
Received: from uni.itflex.com.br ([177.200.204.249]:46617 "EHLO
	mail.itflex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbcDLLcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 07:32:23 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Apr 2016 07:32:22 EDT
Received: (qmail 4006 invoked by uid 49); 12 Apr 2016 11:25:39 -0000
Received: from 127.0.0.1 (rudineigr@itflex.com.br@127.0.0.1) by web.itflex.com.br (envelope-from <rudineigr@itflex.com.br>, uid 89) with qmail-scanner-2.05 
 (clamdscan: 0.95.2/9450.  
 Clear:RC:1(127.0.0.1):. 
 Processed in 0.007921 secs); 12 Apr 2016 11:25:39 -0000
Received: from unknown (HELO ASSP.nospam) (rudineigr@itflex.com.br@127.0.0.1)
  by web.itflex.com.br with ESMTPA; 12 Apr 2016 11:25:39 -0000
Received: from rudineigr.itflex.lan ([192.168.47.195] helo=rudineigr.itflex.lan)
	by ASSP.nospam with ESMTPS(AES128-SHA) (ASSP 1.10.1); 12 Apr 2016 08:25:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291255>

I'm having a problem with included configurations in ~/.gitconfig, when 
using this command:

git config --global user.email

It doesn't return anything, in commits it works as intended. The 
configuration looks like this:

~/.gitconfig
[include]
   path = .gitconfig.user
# ... more configurations

~/.gitconfig.user
[user]
   name = My Full Name
   email = myemail@example.com

I'm using Fedora 23, git version 2.5.5
