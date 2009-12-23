From: Jan Zalcman <zalcman@9livesdata.com>
Subject: Atomicity of git-push operation.
Date: Wed, 23 Dec 2009 12:51:38 +0100
Message-ID: <4B32044A.7010601@9livesdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 13:03:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNPud-0006a5-NK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 13:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbZLWMBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 07:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbZLWMBv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 07:01:51 -0500
Received: from cwl245.internetdsl.tpnet.pl ([83.19.119.245]:34182 "EHLO
	9livesdata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750899AbZLWMBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 07:01:50 -0500
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2009 07:01:49 EST
Received: from mailhub.9livesdata.com (localhost.localdomain [127.0.0.1])
	by mailhub.9livesdata.com (Postfix) with ESMTP id B88B36B6FCDC
	for <git@vger.kernel.org>; Wed, 23 Dec 2009 12:51:35 +0100 (CET)
Received: from cezary.9livesdata.com (cezary [192.168.7.1])
	by mailhub.9livesdata.com (Postfix) with ESMTP
	for <git@vger.kernel.org>; Wed, 23 Dec 2009 12:51:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
  I have a simple question about "push" operation but I couldn't find an
answer: is git-push (also with --tags flag) atomic ? Especially: if refs
changing (during push) is atomic ?
Thanks,
Janek
