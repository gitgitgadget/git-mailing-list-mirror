From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 14:36:32 +0100
Message-ID: <442152E0.4020604@op5.se>
References: <20060322025921.1722.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 14:37:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM3Vt-0006WP-0K
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 14:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCVNge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 08:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWCVNge
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 08:36:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53181 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751239AbWCVNge
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 08:36:34 -0500
Received: from [172.25.1.201] (unknown [62.119.65.226])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EFDC06BD03; Wed, 22 Mar 2006 14:36:32 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20060322025921.1722.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17815>

linux@horizon.com wrote:
> If someone feels ambitious, you can detect this condition automatically
> by searching for a file that you know won't be there and seeing if you
> get a 404 response to that.
> 
> To avoid punishing good servers, it would be nice to defer the test
> until reciving the first corrupted object.
> 
> I'm not sure what the best "object that's not supposed to be there" is.

.git/objects/00/hoping-for-a-404-or-webadmin-should-fix

It has the right number of chars so it should fit in wherever a real 
object name does but is obviously bogus anyways.


> It could just be a random hash, or would a malformed object file name
> be better?

A malformed object name is infinitely better. Otherwise we'd end up with 
a wild guess that hits home some day, to much surprise and a bug-report 
I wouldn't want to track. Not to mention the embarrassment when 
explaining why that object-name was chosen.

> 
> (As an aside, I suspect this is all caused by Microsoft's "friendly HTML
> error messages" invention.)

The body of the 404-page has absolutely nothing to do with it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
