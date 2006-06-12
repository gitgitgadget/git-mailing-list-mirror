From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 21:04:00 +0200
Message-ID: <f36b08ee0606121204q1f9dfb5dv3c09c4e9e6a16a0f@mail.gmail.com>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
	 <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
	 <9e4733910606112039p7aff60c7w7a074d0e35c7b0f@mail.gmail.com>
	 <Pine.LNX.4.64.0606112056440.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 21:04:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fprhm-0005TD-J3
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbWFLTED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbWFLTED
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:04:03 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:3399 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752174AbWFLTEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:04:01 -0400
Received: by py-out-1112.google.com with SMTP id x31so1779932pye
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 12:04:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C60wm6YfU5A3YSSwUeaUU14CH5/4jbpZxKEWbLww/VZPnUwzwOzqcHwebTRwBwOmhd51tdScdmxPCEdsT7mDOxA0KyHMK8Y5uLWGtIXwoxsf0PTWOTC9snaH6YiJAupsNjVvPNbHnckfiiPOxyK4ILGV02qXNumtu+RWUk4QOV4=
Received: by 10.35.34.18 with SMTP id m18mr4643563pyj;
        Mon, 12 Jun 2006 12:04:00 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Mon, 12 Jun 2006 12:04:00 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606112056440.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21726>

On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Sun, 11 Jun 2006, Jon Smirl wrote:
> > I have it stopped and I am running the repack.
> > There are 1.27M files in my .git directory
> Yeah, that would do it. That's ~5000 files per object directory, so I
> assume that your directories are 200+kB in size, and for every new object
> added, you'll basically have to traverse the old directory fully in order
> to find an empty place for it

Is this related to 1-level dir tree for objects (12/object)
vs 2-level dir tree (12/34/object) ? Does git employ more levels
for object tree for large projects ?

Yakov
