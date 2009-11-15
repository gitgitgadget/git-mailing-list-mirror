From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sun, 15 Nov 2009 20:52:52 +0100
Message-ID: <4B005C14.8090607@gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com> <4AFF3EB7.5080606@gmail.com> <7d4f41f50911150156x4cc07dcch977c90e5bd134d17@mail.gmail.com> <200911151433.54797.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Victor Engmark <victor.engmark@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Nov 15 20:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9l9q-0003AN-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 20:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZKOTw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 14:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbZKOTw6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 14:52:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:41700 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbZKOTw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 14:52:58 -0500
Received: by ey-out-2122.google.com with SMTP id 9so855190eyd.5
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=K/igDMvXqMiEjBG4LibrKFBx8qgjzmcwPI2CQr4N3gc=;
        b=bItrn3JREhTRVZ94KywIxtOIrt2c7uWpzXE7q8WbL8//hRD97R4l7U2XtYWScpS7zG
         j32kJlj7SCXlhKYzVwcSkLlrlOuH5AxwF5KBAFLJLgAavHl9WtC0A9Y+Gu/eyw2AHq0P
         9e4t5jvc76TffAaGYCsXLDMN5T+P9T1d6Rm3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=ekuVQhqtXfgn/8cI5dJnL55Gm6BIgiCydtmXgn1u04XvHFzC83nhboGDOD0Hf3nIZB
         PNJo6kPZJdb0yH6I7nh1Tp0oNeSHF+EcJ2Vm9poo2BYMMZBtPnnp6SoZIaVmmoY+fqxq
         XBdLZJhbwtNSotdeWyQqqEcsIzcyhJkHMuWZs=
Received: by 10.213.23.195 with SMTP id s3mr1434747ebb.5.1258314782776;
        Sun, 15 Nov 2009 11:53:02 -0800 (PST)
Received: from ?192.168.2.101? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 5sm5150083eyh.34.2009.11.15.11.53.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 11:53:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200911151433.54797.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132956>

Thomas Rast schreef:
> Victor Engmark wrote:
>> On Sun, Nov 15, 2009 at 12:35 AM, Johan 't Hart <johanthart@gmail.com> wrote:
>>> Sverre Rabbelier schreef:
>>>
>>>> $ git rebase git-svn
>>> Why not just
>>> $ git svn rebase
>> What is the difference between the two?
> 
> 'git svn rebase' magically[*] picks the right remote branch to rebase
> against, and also first talks to the network to update said branch.
> 
> 
> [*] actually it looks at the first git-svn-id line found in git log
> --first-parent.
> 

I didn't even know you could also do
$ git rebase git-svn
Unless git-svn is a ref...
