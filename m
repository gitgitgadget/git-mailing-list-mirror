From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 17:19:19 -0400
Message-ID: <46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsN87-0002MH-3C
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0CRVTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:19:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59259 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0CRVTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 17:19:39 -0400
Received: by gwaa12 with SMTP id a12so1069339gwa.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=n140q3xHx8w76JbHAt7P0Tm4QUOottlPIc0bqJKquak=;
        b=Y3xg5cqTUq19AfGOPISY9pUn15Se/XlH8C9dF1OluMaPLzDkmMY6QNQVeF+ZM3xGoG
         cDvTEPMYLCXmTDZJ+pUU74jGI6G9JatWDih5dxvnsLcBKF4dgkUn4TPtVYJ3tWoNzWVo
         N+ipH4OrFRfzjDrqcHv6F6B+EDWSC0VZfabMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EIt/6na8j4MgUJSuEY+mnMYz1xABs3rGOZ30Z1Jk4xB4tFZKdzbtYaQS7w8Vo8RIlx
         wf9ilHsPH2PN+HKGARPsBKJHnxV2VFdidC3tHp2negx+3f/rKhwVYKUi00lJXFEorCPi
         rdQWJcKRXCX8NpUxv9qxYKr43YCLYOx/m8gv8=
Received: by 10.101.144.26 with SMTP id w26mr5126601ann.205.1268947179108; 
	Thu, 18 Mar 2010 14:19:39 -0700 (PDT)
In-Reply-To: <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142521>

On Thu, Mar 18, 2010 at 5:12 PM, Michael Witten <mfwitten@gmail.com> wrote:
> This is all that I'm saying: Keep git exactly the way it is, but add
> one extra piece of identifying information for each person.

What's the value? For me it'll be "Martin Langhoff". I already have that.

> Nothing is being taken away.

But something is added.

Good design is not when there's nothing more to add, it's when there's
nothing left _to remove_.

Git is what it is thanks to removing superfluous crud from its core
datamodel. Don't be surprised that there is a very strong resistance
to adding anything to that datamodel.

> Essentially, the goal is to distribute the task of maintaining aliases.

Already achieved with mailcap. No need to mess with the secret of
git's success (the tight datamodel).

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
