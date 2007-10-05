From: Andreas Ericsson <ae@op5.se>
Subject: Re: Correction for post-receive-email
Date: Fri, 05 Oct 2007 10:54:02 +0200
Message-ID: <4705FBAA.50302@op5.se>
References: <449c8cfc0710050014j9bbf057ka108ee27dea49a89@mail.gmail.com> <200710050913.58835.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Mertens <emertens@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idiws-0001OM-2z
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbXJEIyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbXJEIyI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:54:08 -0400
Received: from mail.op5.se ([193.201.96.20]:58391 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbXJEIyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:54:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2A01D194454;
	Fri,  5 Oct 2007 10:54:06 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7iMQCmsVeNgQ; Fri,  5 Oct 2007 10:54:03 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 91B6A194412;
	Fri,  5 Oct 2007 10:54:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <200710050913.58835.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60055>

Andy Parkins wrote:
> On Friday 2007 October 05, Eric Mertens wrote:
> 
>> I noticed that my mutt wasn't correctly detecting the signature block
>> on the end of the automated emails I was receiving from the script in
>> contrib. I've made this trivial change in my local copy of the script,
>> but I figured that if I was going to be modifying the source code I
>> should share my changes.
> 
> That change has been in my pending queue for a while.  It's technically 
> correct, but I've never submitted it.  The reason I haven't is that it adds 
> trailing whitespace.
> 
> Perhaps one of the shell gurus can offer a nicer way of having a trailing 
> space be output in a heredoc that doesn't add a trailing space in the source 
> script?
> 

space=' '

cat << EOF
--$space
EOF

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
