From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Wed, 11 Jul 2007 16:31:20 +0200
Message-ID: <81b0412b0707110731n4ffa25afoea5395a856869325@mail.gmail.com>
References: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "pradeep singh" <pradeep.rautela@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 16:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8dDy-0004lv-Gu
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 16:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761962AbXGKObX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759391AbXGKObX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 10:31:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:7997 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727AbXGKObW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 10:31:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so125197ugf
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 07:31:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H5v2tM2A0hAWbBXJG4o79wWo+Z5gDbl87mUXnZFq5IcWge84ApIglFomjyjv7Wq41NzRSDX/Ga5rW3bU33uBlBij14L93OhAiB5NyOdV43ZsiNunapH+TW/8fNoC8+LlmEduqTWNmtcXlIYP2cToLGACr3NqjU+9z6jqBq1gE7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3PcwAkE8aJocKHm6Jj7EORYbjyfLBDe+1HnEPsucz0YXEQjjMvFC0EeJIBFG7yoboi62pEWgNO4a/+zm6seZKYcwnxXUm3NgsKowTYMdDL0uNqWGw4RvgnmW3zir7iUUmW1ZfRsSOj09JGl7UnGKQC/UDPDvE4HsKdQqb3bJqM=
Received: by 10.78.149.15 with SMTP id w15mr2431462hud.1184164280571;
        Wed, 11 Jul 2007 07:31:20 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 11 Jul 2007 07:31:20 -0700 (PDT)
In-Reply-To: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52163>

On 7/11/07, pradeep singh <pradeep.rautela@gmail.com> wrote:

> I followed the howto instruction for setting up a git repo over http
> using the HOWTO  given in the /usr/share/doc/git-doc/howtos .
>

You may want to consider an upgrade to your git installation.
But it is unrelated to your problems.

> 1. I already have a source tree controlled by git on the same
> machine.I want to make this as the master for the new public
> repository. I created a bare git repo in it as per the howto. Now i
> want to commit my local git repo to this public repository.I failed to
> do so sadly :-/.Can anyone point me to the correct place or link?

Try Documentation/everyday.txt in git source distribution

> 2. Even when i did a (from another machine)
>  $git-clone http://100.121.232/work.git work
>  It says,
>  Cannot get remote repository information.

Well, you can try this link in your browser.
Does it show something?
Does http://100.121.232/work.git/objects/info/packs work?

>  Perhaps git-update-server-info needs to be run there?

Yes. But it wont help unless your web server is setup correctly.

> Can any one help me with this?

Any reason you cannot use ssh?

> I ll appreciate some good documents or howtos on setting up git
> repository painlessly.

Usually it is as simple as "git init" in directory where you want it.
