From: "Pavel Raiskup" <xraisk00@gmail.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Tue, 22 Mar 2011 17:43:42 +0100
Message-ID: <op.vsq7e4og2m56ex@localhost.localdomain>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
 <20110321012708.GA18323@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>
To: "Vicent Marti" <vicent@github.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q24gs-0002wA-FO
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 17:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab1CVQoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 12:44:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1CVQoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 12:44:12 -0400
Received: by bwz15 with SMTP id 15so5996166bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:content-type:cc:references:subject:to:date
         :mime-version:content-transfer-encoding:from:message-id:in-reply-to
         :user-agent;
        bh=z42ISG/ikP+Km93C0CT7/eh1JE70ju9mvrO+24tTzx4=;
        b=mKezS7o8kFE4eyjjSw88kihesDl3H1Hum61a7F1TxQIhdmpVp0Yd5CwpvArxBkLw8F
         WX59AATJvizqCm3VK3V02lrBtJMFvIYw98L8rWGMbfDM8sc6MA32Gmo26OEaSX7L+1pR
         /7+H1rHDXM37e6vuMZuuwiAYbopaEFt9Go4HE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:references:subject:to:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        b=C+9y2G8WJGq5h8xFsP3eSnjR6UJy1xGZl1QWcp40OyqPcTiCczGUGZWoQjkrAF4odj
         2g+nxQrkw4h7p+Af2KCpGAzB84zdHWfi+1txszsDb4XHBnhLjAcntQNVJS+EmilmApVE
         zn1j+INZ5eaJcyHaUWoYm1yE/S2p6WPxbRpnY=
Received: by 10.204.231.66 with SMTP id jp2mr5180301bkb.134.1300812251211;
        Tue, 22 Mar 2011 09:44:11 -0700 (PDT)
Received: from localhost.localdomain (ip-89-103-132-159.net.upcbroadband.cz [89.103.132.159])
        by mx.google.com with ESMTPS id k5sm5266205bku.16.2011.03.22.09.44.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 09:44:02 -0700 (PDT)
In-Reply-To: <20110321012708.GA18323@elie>
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169748>

Hello,

Jonathan Nieder wrote:

> Vicent Marti wrote:
>
>> -- I'm
>> personally doubtful of anybody succeeding on doing that project during
>> the SoC,
>
> ...
> If someone wants to work on this, I'd be glad to talk over what would
> be needed to make a realistic proposal.
>
>> so I have very little interest on mentoring the task.
>
> That's okay, of course.  What's probably important for people
> considering this project is: would you be willing to answer questions
> and consider patches from a person working on this?  That is, do you
> consider the goal even worthwhile?
>
> I am probably not the best person to mentor this but if no one else
> wants to then I would be interested.

As I can see now, it could be quite too heavy for me to produce
results as good as would be needed. This is probably quite difficult
task for starting with git contributing. Rather considering the other
git-topics for now (but I'm not rejecting this idea yet).

> A good place to start is the initial commit e83c516 (Initial revision
> of "git", the information manager from hell, 2005-04-07).
> ........
> Heh, probably I didn't choose the best example. :)  A short article
> about this in Documentation/technical certainly wouldn't be a bad
> thing.
>
> In addition to "git log -S" as used above, I tend to find "git blame -L"
> helpful FWIW.  And people on the list can be helpful, too.

This "short" article is very helpful, thank you for that! I think
it can help all contributors (not only students) at the beginning
of their git journey.

>> b) Write a minimal Git client using libgit2. Peff keeps bringing this
>> up and I think it's a bangin' good idea. Write something small and
>> 100% self contained in a C executable that runs everywhere with 0
>> dependencies -- don't aim for full feature completion, just the basic
>> stuff to interoperate with a Git repository.
>
> I agree that this would be very neat, too.

The idea of git client based on libgit2 sounds VERY interesting. I'm
going to ask for some details in neighboring sub-thread.

>> Best of luck with your application process with whatever project you decide,
>> Vicent
>
> Seconded. :)

Thank you both, I'm not going to try other projects, there is not enough
time now for researching other projects and git is my only choice and desire.

Pavel
