From: Intland Software <info@intland.com>
Subject: Tip for Eclipse users: how to make Git ~30 times faster in Eclipse
Date: Thu, 20 Jan 2011 15:49:09 +0100
Message-ID: <4D384B65.7020205@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 20 15:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfvp8-0006Aj-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 15:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726Ab1ATOtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 09:49:12 -0500
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:37601 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab1ATOtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 09:49:12 -0500
Received: from [192.168.1.67] (catv91EC0523.pool.t-online.hu [145.236.5.35])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail01d.mail.t-online.hu (Postfix) with ESMTPSA id 1BAD3758D47
	for <git@vger.kernel.org>; Thu, 20 Jan 2011 15:49:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165314>

Dear Git users,

A team here at Intland Software recently looked into EGit performance optimization opportunities, and managed to achieve 
some impressive results. You might be interested to get our results before the next official EGit version gets released.

In our optimized plugin version, the time required to synchronize a medium sized repo dropped from 10 minutes to 15 
seconds. (It is 40 times faster now on that particular repository.)
The Eclipse CDT team reported similar results: their synchronization time dropped from 32 minutes to 1.5 minutes 
(roughly 20 times faster now).

Read here how: http://blogs.intland.com/main/entry/20110120
--
Intland staff
