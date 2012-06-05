From: Stephan Peijnik <stephan@peijnik.at>
Subject: git smart protocol via WebSockets - feedback wanted
Date: Tue, 05 Jun 2012 20:20:49 +0200
Message-ID: <jqlim2$6vt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 20:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbyRX-0005ud-7A
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab2FESZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:25:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:37198 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab2FESZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:25:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SbyRF-0005Ry-GD
	for git@vger.kernel.org; Tue, 05 Jun 2012 20:25:05 +0200
Received: from 178-190-4-245.adsl.highway.telekom.at ([178.190.4.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 20:25:05 +0200
Received: from stephan by 178-190-4-245.adsl.highway.telekom.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 20:25:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 178-190-4-245.adsl.highway.telekom.at
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199275>

Dear list,

Since I have been working on a proof of concept showing that git's smart 
protocol can be tunneled via WebSocket connections quite easily [0] I 
wanted to ask for some feedback on the idea in general and on my 
implementation [1].

So, basically, what do you think about tunneling git's smart protocol 
via WebSockets (and thus HTTP)?
Do you believe that a full implementation of this, as opposed to the 
current proof of concept, is worthwhile?
Are there any issues with this approach I missed (apart from the missing 
authentication/authorization in the server component of course)?

Thanks in advance for your input.

Regards,

Stephan

[0] 
http://blog.sp.or.at/2012/06/git-smart-protocol-via-websockets-proof.html
[1] https://github.com/speijnik/gitws
