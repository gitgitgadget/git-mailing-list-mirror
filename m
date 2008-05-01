From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Tracability in git commits
Date: Thu, 1 May 2008 19:34:55 +1200
Message-ID: <46a038f90805010034y3ffd3eb5hbee7c2200912eef3@mail.gmail.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <m3lk2vodw4.fsf@localhost.localdomain>
	 <1209551520.5010.20.camel@dax.rpnet.com>
	 <46a038f90804301826xaf5d73bl1d29a07bc930a716@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Richard Purdie" <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Thu May 01 09:36:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrTKt-0003r3-V7
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 09:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYEAHe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 03:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYEAHe5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 03:34:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:17356 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbYEAHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 03:34:56 -0400
Received: by wf-out-1314.google.com with SMTP id 28so745051wfc.4
        for <git@vger.kernel.org>; Thu, 01 May 2008 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ocTtrmPU9FlKNuKqeaNO7BWyCDCvB6q8U515sxSE2Qs=;
        b=CRuebv6vk3hS2FH0obAZN2QHG/DeqdVKTLwNQjCB1CV5Au829RrO9AI7+hsBJM7dymy4kr5j8W7FytKJLe2WaHJBq18dGllckCwly8Qjmp9SaBRjUcX/gRhT6JcT+45IEzeKEmqQWRgXD/n7MLyukekbPz49vf+VxhpC/gNzeFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IT3mJzBdizY0zirHatZSy1z1M/kMf/FF/m+ST7jm6QYkGYKi/K5KgiDQcWtCX8s9NgOiz3faRBYOH5vmIT+U3l8Rdk9J/kyeiFDGx0nv4HNMatv8t5zA24zrk45pZ4RmZwfB9Q1VZRzbyu7oKMtmzNcs/N7KQNblkxNnCFk0H+4=
Received: by 10.142.187.2 with SMTP id k2mr671822wff.119.1209627295650;
        Thu, 01 May 2008 00:34:55 -0700 (PDT)
Received: by 10.142.212.21 with HTTP; Thu, 1 May 2008 00:34:55 -0700 (PDT)
In-Reply-To: <46a038f90804301826xaf5d73bl1d29a07bc930a716@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80892>

On Thu, May 1, 2008 at 1:26 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
>   4 - A script "pushes" commits from the "incoming" repo to a
>  "verified" repo after checking that they are backed by a GPG-signed
>  list. For ease of use, this can happen on the server ASAP, and it can
>  be validated independently by any party. Notably, it is probably a
>  good idea that it is validated shortly before a release is tagged.
>
>  This way, you keep the flexible/fast properties of git

Note that with this, you *can* also keep the ability for someone to
push commits that they are not the author or committer for. This is
actually added flexibility - you can merge from a 3rd party tree, and
push it to the central repo, as long as you GPG-sign the list
including those commits.

I highlight "can" because the wrapper on the developer side and the
script on the server side can prevent this, or force extra steps in
such case.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
