From: gitlist <gitlist@myword.co.uk>
Subject: "Resetting" a repository
Date: Tue, 27 Sep 2011 16:24:23 +0100
Message-ID: <4E81EAA7.5030708@myword.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 17:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ZWH-0008Uq-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 17:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1I0PYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 11:24:25 -0400
Received: from mail3.anu.net ([83.96.156.167]:34387 "EHLO mail3.anu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1I0PYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 11:24:25 -0400
Received: from Roddie-Grants-MacBook-Pro.local (cpc3-warw13-2-0-cust132.3-2.cable.virginmedia.com [86.17.75.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail3.anu.net (Postfix) with ESMTP id 17538319B0E
	for <git@vger.kernel.org>; Tue, 27 Sep 2011 17:24:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182243>

I have a project with a test repository and a live repository (and a 
development repository).

Over time, the test repository has had merges which were in a quite 
different order to the live repository, so it no longer fulfills its 
role of being pretty much like the live repository and therefore a good 
place to test. The two have diverged too far.

We've reached a point in the project when it would be good to reset the 
test repository so that it is exactly the same as the live one. We can 
then merge new work from the development repository.

I think that if I just merge the live repository into the test 
respository it will not remove extra (non-conflicting) code. On this 
occasion I want to remove all extra code and resolve all conflicts in 
favour of the live repository version.

I'd appreciate advice on the best way to do this.

Thanks

Roddie Grant
