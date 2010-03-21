From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 14:05:42 +0800
Message-ID: <41f08ee11003202305k229466f9w6f137f759df4efa4@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de>
	 <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
	 <alpine.DEB.1.00.1003201432410.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 21 07:06:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtEIH-0004eJ-MQ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 07:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab0CUGFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 02:05:44 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:21029 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0CUGFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 02:05:44 -0400
Received: by qw-out-2122.google.com with SMTP id 8so921263qwh.37
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tp0+jJZd2QGamjRTFY/3C6tLLtu8t/Ws8YFUJd7NfWQ=;
        b=KYGJNoajU2EY0WLSbF7liv/XavWnkiB4iFeqLW0LoUPjzMrBPnqkP3+0GKKktMqMly
         nd0F+j+LLArfsygljf0qpHML5x72nTYp/3+LaycXQN7rsvoHbpTIO8BKzlHc2zlOxQVA
         7ahnZWJ9wHKAxMv/3HnGuVQW65PjQ3cbG5XjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aaybRGMqtL6gZEpR7Grc9IlUPCqKXhsrZlKs3vioJlNUPonMrGaLKHLUuaZGJksm5r
         I3+Htbw6ppYPUkYzk1TwEydyRhT6kC2kRuEZsjSbN9F5SQaFQT7w+KW6LUKBilHzFZxk
         WJ8FS7uvJZJag5bnO16JYy8zUxWgZdmhEFtKU=
Received: by 10.229.218.204 with SMTP id hr12mr1453599qcb.101.1269151543002; 
	Sat, 20 Mar 2010 23:05:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003201432410.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142791>

>>
>> So, I think add some new options to 'git log' is preferred.
>
> Yes, I think that this should be the target for the user interface.
> However, the logic should be different enough to merit a completely new
> file for the code (think "git add --interactive").

So, a new file builtin/line-level.c will be added.

>
> Yes, it is much more difficult, and it is more expensive. So: there are
> several steps in the project (you could also call them "milestones"), and
> fuzzy matching end lines would come later than simple code movement. And
> still later than code movement between files.

Ok, I will add some milestones on my next version proposal, thanks.

Regards!
Bo
