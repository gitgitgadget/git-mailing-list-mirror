From: Douglas Stockwell <doug@11011.net>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Wed, 09 Jan 2008 13:06:14 +0900
Message-ID: <fm1h7t$nnr$1@ger.gmane.org>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 05:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCSGz-00069v-0u
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 05:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYAIEKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 23:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYAIEKI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 23:10:08 -0500
Received: from main.gmane.org ([80.91.229.2]:60139 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbYAIEKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 23:10:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JCSGQ-0002SG-S3
	for git@vger.kernel.org; Wed, 09 Jan 2008 04:10:02 +0000
Received: from ie186.opt2.point.ne.jp ([222.225.39.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 04:10:02 +0000
Received: from doug by ie186.opt2.point.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 04:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ie186.opt2.point.ne.jp
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69953>

Paolo Ciarrocchi wrote:
> " Mailing off a set of patches to a mailing list can be quite neatly
> done by git-send-email.
> One of the problems you may encounter there is figuring out which machine
> is going to send your mail.
> I tried smtp.gmail.com, but that one requires tls and a password,
> and git-send-email could not handle that "
> 
> From http://git.or.cz/gitwiki/GitTips.
> 
> Is this statemant still correct ?
> Is msmtp the only solution for using git-send-mail with gmail? (tls +
> autentication).

No, as of 34cc60ce2b48f6037997543ddbab1ed9903df4a8 you can use SSL and 
SMTP-Auth.

[sendemail]
         smtpserver = smtp.gmail.com
         smtpuser = <user>@gmail.com
         smtppass = <password>
         smtpssl = true

Can you suggest changes to the documentation if these options are unclear?

Doug
