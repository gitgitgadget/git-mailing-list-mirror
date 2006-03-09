From: Ming Lei <mlei@brocade.com>
Subject: fsck-object --standalone got errors
Date: Wed, 08 Mar 2006 18:35:08 -0800
Message-ID: <440F945C.2010401@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 09 03:35:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHAzo-0005B8-PS
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 03:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWCICfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 21:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWCICfR
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 21:35:17 -0500
Received: from mail55.messagelabs.com ([216.82.240.35]:8165 "HELO
	mail55.messagelabs.com") by vger.kernel.org with SMTP
	id S1161001AbWCICfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 21:35:15 -0500
X-VirusChecked: Checked
X-Env-Sender: mlei@Brocade.COM
X-Msg-Ref: server-6.tower-55.messagelabs.com!1141871709!72676214!1
X-StarScan-Version: 5.5.9.1; banners=-,-,-
X-Originating-IP: [66.243.153.112]
Received: (qmail 16116 invoked from network); 9 Mar 2006 02:35:09 -0000
Received: from f112.brocade.com (HELO blasphemy.brocade.com) (66.243.153.112)
  by server-6.tower-55.messagelabs.com with SMTP; 9 Mar 2006 02:35:09 -0000
Received: from hq-ex-2.corp.brocade.com (hq-ex-2 [192.168.38.63])
	by blasphemy.brocade.com (Postfix) with ESMTP id 0E1B41425C
	for <git@vger.kernel.org>; Wed,  8 Mar 2006 18:35:09 -0800 (PST)
Received: from brocade.com ([192.168.78.243]) by hq-ex-2.corp.brocade.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 8 Mar 2006 18:35:08 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-OriginalArrivalTime: 09 Mar 2006 02:35:08.0945 (UTC) FILETIME=[1526C810:01C64322]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17395>

I have a repository created by GIT itself(not cognito, etc). It has 
branches called base, master and origin. When I did git-fsck-objects 
--full there is nothing shown, but when I did git-fsck-objects 
--standalone, it displayed following:

error: refs/heads/master: invalid sha1 pointer 
ea51c414519ffe78c5bf95c488e94e82d3603472
error: refs/heads/base: invalid sha1 pointer 
4b75aaeb5af2dc69374ad080020758e4de6a45d2
error: refs/heads/origin: invalid sha1 pointer 
f4c9503abb2ad52752004e8e9b77b72e23d18d3e
fatal: No default references


The question is:
what's the purpose for this standalone check? what's these errors about? 
Do I need to care these errors?
what's the step to ensure my repository always be in a good shape? Is 
running fsck-objects --full sufficient?


Thanks
Ming
