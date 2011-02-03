From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Also seeing the "problem with cherry-picking a commit which comes
 before introducing a new submodule"
Date: Wed, 02 Feb 2011 21:08:37 -0700
Message-ID: <4D4A2A45.3060804@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 05:08:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkqV0-0004de-FH
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 05:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab1BCEIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 23:08:31 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58648 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab1BCEI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 23:08:29 -0500
Received: (qmail 22681 invoked by uid 399); 2 Feb 2011 21:08:28 -0700
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Feb 2011 21:08:28 -0700
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b3pre Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165948>

Described in this thread, http://lists.zerezo.com/git/msg737184.html, 
and this thread, http://lists.zerezo.com/git/msg705275.html, is a 
problem similar to what I've been seeing today.  It seems I can resolve 
the "conflicting" submodule(s) and continue on, but it is a bit painful 
as there are a small number of them.  I also tried an interactive rebase 
and assigning a 'pick' entry with the commit I'd like to cherry-pick, 
and the same problem manifests.

In any case, it seems Jonathan Nieder has potentially identified the 
problem at http://lists.zerezo.com/git/msg737401.html.

Has a patch come through that addresses this?  If one did, did it make 
it into 1.7.4?

Thanks!

Josh
