From: Andreas Ericsson <ae@op5.se>
Subject: Re: remote diff
Date: Thu, 20 Jul 2006 14:06:33 +0200
Message-ID: <44BF71C9.4080206@op5.se>
References: <f36b08ee0607200454k7aa98454rd2a8a566b0ea4582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 20 14:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3XIo-0000YV-H6
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 14:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWGTMGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 08:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWGTMGg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 08:06:36 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:58076 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030280AbWGTMGf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 08:06:35 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 159A16BCC6; Thu, 20 Jul 2006 14:06:34 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0607200454k7aa98454rd2a8a566b0ea4582@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24029>

Yakov Lerner wrote:
> I have local repo, and remote repo ssh://x/y/.git.
> 
> I tried to diff local repo against remote, with naive
> 'git-diff ssh://x/y/.git.' But this did not work. How do I
> diff with remote repo ?
> 

Pull it to a new branch and diff the two branches. This should be a 
pretty cheap operation unless either of the two repos has seen a lot of 
development since you forked the code.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
