From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sun, 7 Sep 2008 22:45:30 -0500
Message-ID: <5d46db230809072045u7ade2d62i514aac49149a463d@mail.gmail.com>
References: <20080906150723.GA31540@dervierte>
	 <m38wu5p9q4.fsf@localhost.localdomain>
	 <e06498070809060912q2f7ed0cflb02e3efc7b81976e@mail.gmail.com>
	 <200809062101.28672.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 05:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcXiF-0005xt-SF
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 05:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYIHDpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 23:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbYIHDpc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 23:45:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:42524 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbYIHDpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 23:45:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so713507yxm.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 20:45:30 -0700 (PDT)
Received: by 10.151.110.14 with SMTP id n14mr20578280ybm.80.1220845530386;
        Sun, 07 Sep 2008 20:45:30 -0700 (PDT)
Received: by 10.150.57.11 with HTTP; Sun, 7 Sep 2008 20:45:30 -0700 (PDT)
In-Reply-To: <200809062101.28672.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95212>

On Sat, Sep 6, 2008 at 2:01 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> [Back on git mailing list]
>
> On Sat, 6 Sep 2008, Steven Walter wrote:
>> On Sat, Sep 6, 2008 at 11:36 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> >
>> > First, a question: how your yap porcelain differs from efforts of
>> > EasyGit (eg) and Pyrite?
>>
>> In the case of EasyGit, it differs in that yap's interface does not
>> have the requirement of being fully backwards-compatible with core
>> git.  Dropping that requirement gave me more freedom to simplify and
>> clean-up the interface.
>
> I can understand this.  EasyGit is more about making git self
> documenting than anything more, from what I understand.
>
>> To my knowledge, Pyrite does not support plugins.
>

Depends on what you mean by plugins.  There is a way to load what I call
extensions that you can use to add commands or modify the way existing
commands operate.  It is crude at the moment but it works.  I have a
proof of concept extension/plugin that adds different ways of specifying
revisions.  I assume you mean something similar.

> As far as I know Pyrite is one-man work.  Why not to join efforts,
> bringing those two projects together?  Both share the same language,
> Python.
>

Sadly, yes.  It is still just me.  I would welcome any help or additions.
I don't have as much time as I would like to work on it.  But as it stands I
have a web interface (no push/pull yet, I am waiting for the git http
push/pull to be done to make sure I have compatibility.

If you want to look at it, you can find it here...

http://gitorious.org/projects/pyrite


I am currently not doing much work on the command line interface since
people seemed to object to my ideas.  Instead I am focusing on the gui
instead.  Since you say you are not going to keep the command lines
compatible, what do you intend to do differently?

Good Luck.
Govind.
