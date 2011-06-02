From: Andrew Spiers <aspiers@vpac.org>
Subject: git status --ignored
Date: Thu, 02 Jun 2011 14:34:22 +1000
Message-ID: <4DE712CE.20509@vpac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 06:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRzlZ-00046M-6g
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 06:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab1FBEnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 00:43:20 -0400
Received: from mail.vpac.org ([202.158.218.6]:34887 "EHLO mail.vpac.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab1FBEnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 00:43:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vpac.org (Postfix) with ESMTP id 1F481C01A76FE
	for <git@vger.kernel.org>; Thu,  2 Jun 2011 14:33:29 +1000 (EST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.91 tagged_above=-10 required=5
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, T_RP_MATCHES_RCVD=-0.01]
	autolearn=ham
Received: from mail.vpac.org ([127.0.0.1])
	by localhost (mail.vpac.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VH2Xa-I0uw0R for <git@vger.kernel.org>;
	Thu,  2 Jun 2011 14:33:28 +1000 (EST)
Received: from [172.31.4.36] (cape.in.vpac.org [172.31.4.36])
	by mail.vpac.org (Postfix) with ESMTPSA id 68E1CC01A76FD
	for <git@vger.kernel.org>; Thu,  2 Jun 2011 14:33:28 +1000 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174925>

This looks like a bug in git 1.7.4.1.

git status --ignored does not show my ignored files and directories. git 
status -h suggests it should.
git status --ignored -h does show my ignored files and directories.

Also, git help status does not mention the --ignored switch.
