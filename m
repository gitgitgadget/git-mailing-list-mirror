From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: git branch diagram
Date: Fri, 18 Apr 2008 09:07:55 -0400
Message-ID: <1c5969370804180607q675eb528na431ecdce99c49fd@mail.gmail.com>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Sat Apr 19 15:02:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmqKc-0002si-1C
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYDRNH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 09:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbYDRNH7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:07:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:34775 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYDRNH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 09:07:59 -0400
Received: by wr-out-0506.google.com with SMTP id c48so322726wra.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CztxLvViWEXbxoIJ/aAZ7EEusejKz/zeKUmXBGci9wc=;
        b=eQ5GNTLwf5h96Vk7sD3xhkd2SQahXdmcWthPfcfGI5nw4DQsybmQDzsxSEc99Lg5NTQs0b9knmdRyrLLrDuXDWnxj9Cr/HYdY3Vaz8ZL5yMjwYmJnJo8N/CI+u0iTGg0S59uFvnaVfnt15Wb+BQfOcRsMtjTwsurnAEJPdD/T9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ckiAtmYlvO3Nd30hTxsOFJ4J6Om4m8PioV2kKYWIVx57rkSpYPEXPgdnx8fdPW73rJld706N20py+QxQWjJel62ks3gitFueOlYcfs+AVg17agXPRUH3wTlPG3EK9FnYol6H2V7fHhebu/mSicNzqvHieF+uLsKDm9DVkHarREM=
Received: by 10.142.140.14 with SMTP id n14mr636002wfd.192.1208524075688;
        Fri, 18 Apr 2008 06:07:55 -0700 (PDT)
Received: by 10.142.179.14 with HTTP; Fri, 18 Apr 2008 06:07:55 -0700 (PDT)
In-Reply-To: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79885>

Full disclosure: I'm a git newbie.


On Thu, Apr 17, 2008 at 1:00 PM,  <Patrick.Higgins@cexp.com> wrote:
> I am trying to get my employer to start using git and have found the distributed model and git's branching to be one of the hardest parts to explain and understand. I put together the attached diagram (done with graphviz so some things are not in the most logical place) to help explain things to my coworkers.
>

A worthy goal.  It seems like a good corporate work flow for git is
either yet to be devised or yet to be documented.


>  In my diagram, I am assuming that most developers work in master, and make branches for their own long-lived projects and experimental things.
>
>  Does my diagram make sense? Are there any suggestions or corrections?

It feels more complicated than it needs to be.  My reaction is that
there should be a simpler way to represent it.

In the dev repos, do the remote branches and local branches have to be
in separate boxes?  It seems these could be put into a single box.

It's not clear who's doing the pulls into the project repository or
who is doing the integration.  My expectation would be that pushes
would be involved at some point, is it not necessary?

matt
