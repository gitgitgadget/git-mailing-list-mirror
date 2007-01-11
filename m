From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Removing files
Date: Thu, 11 Jan 2007 14:25:46 -0800
Message-ID: <m2k5ztciad.fsf@gmail.com>
References: <87bql5cok3.fsf@morpheus.local> <20070111213645.GA6058@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H58Mu-0005o4-L6
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbXAKWZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 11 Jan 2007 17:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXAKWZy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:25:54 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:9597 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbXAKWZx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 17:25:53 -0500
Received: by wx-out-0506.google.com with SMTP id h31so643920wxd
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 14:25:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=Z9RTGPeN02N6X8CRz2uB3jM/kg+vyfcWbftINK6Gpam+2pyy42XYHC9NwVq0lm6RPcdDCxi5FUYKFV6NDO8JQVSMjJBBrvhXwv0ofXT5XsWukrnf5UWsXEJ2E8FXEBViDxYxIDO4mXRLvT9w6c6npe8QDzSwSBvfvClpNeyy7qw=
Received: by 10.70.80.6 with SMTP id d6mr3832514wxb.1168554352810;
        Thu, 11 Jan 2007 14:25:52 -0800 (PST)
Received: from ziti ( [140.107.181.15])
        by mx.google.com with ESMTP id 11sm2555813wrl.2007.01.11.14.25.51;
        Thu, 11 Jan 2007 14:25:52 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20070111213645.GA6058@steel.home> (Alex Riesen's message of "Thu, 11 Jan 2007 22:36:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36626>

fork0@t-online.de (Alex Riesen) writes:

> David K=E5gedal, Thu, Jan 11, 2007 21:10:20 +0100:
>> I'm wondering what the best way to commit the removal of a file is.
>
> git commit -a :)

:-(

I just ran into this very same thing.  I would vote for 'git rm'
and/or 'git add' doing the right thing here.  I'm probably missing the
reason they don't already.

Perhaps the doc should also highlight git's globbing, as opposed to
shell globbing as it is particularly useful when you have already
removed files and want to do:

git update-index --remove 'the-old-place/*.txt'=20


+ seth
