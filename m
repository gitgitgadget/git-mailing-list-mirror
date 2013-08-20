From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Notes and submodules
Date: Tue, 20 Aug 2013 10:39:10 +0200
Message-ID: <CAC9WiBiJQ-kafY5xD9nAnxKPQTyhp5sL49szHQj4C4P_UbBmYg@mail.gmail.com>
References: <CAC9WiBj-ij1o6JL-FtUuCgdf8ZqrhJb2=dQcSXjRMEwwL4VWFA@mail.gmail.com>
	<CALKQrgfGUMrcR+EPTvN9+mFPcW6Q-zv1JM6MJK-61BvF3yYpbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 20 10:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBhTK-0003ve-AS
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 10:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab3HTIjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 04:39:15 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:63467 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3HTIjL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 04:39:11 -0400
Received: by mail-vc0-f177.google.com with SMTP id gf12so71451vcb.36
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oBhrB1DvGI4ue9npffnC8ugcWU+Ove0jXjQSOlU0aBY=;
        b=JHgYTMCLPv398cIzricyipeJKn3YORnflvzioRvgA/iz3onYHjfg1nRTroClj1bVm6
         6ijtNbKuVhq5rEsbrcpKR7pk3lwYjm+6KWgpCN2HOC3WNyF4tc/c8nKcF6NDm5zF3zdT
         fTQV4NPE/2pxViliweUVFDaM+Xczvyt47ercDJkFnVBssJQmVY/GuRvsjuB498ZMDNa7
         tjS9CW3YT9Pf+1r+H8A71mdAcDg8hEmo5F2xeCyYWYq5NOCDejnsniUbfCe5Ac6u8Q46
         BBsig0dtiC74pMk7ncSshVzQumYZ9WSTEPir0a7SCpqiETeVvAQatIPED9SUM48kBxzF
         uR9w==
X-Received: by 10.58.118.130 with SMTP id km2mr177790veb.0.1376987950824; Tue,
 20 Aug 2013 01:39:10 -0700 (PDT)
Received: by 10.58.96.109 with HTTP; Tue, 20 Aug 2013 01:39:10 -0700 (PDT)
In-Reply-To: <CALKQrgfGUMrcR+EPTvN9+mFPcW6Q-zv1JM6MJK-61BvF3yYpbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232589>

Hello,

On Mon, Aug 19, 2013 at 3:55 PM, Johan Herland <johan@herland.net> wrote:
> On Mon, Aug 19, 2013 at 10:13 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>> Hello,
>>
>> Is it possible to keep submodules notes in the super project  ?
>
> Not easily. I guess it depends on what you want to use the notes for.
> In order for notes to be generally useful (i.e. show up in logs,
> surviving a notes prune, etc.) they really must reside in the same
> repo as the annotated objects [1]. Now, if all your interaction with
> notes happens through scripts that you control, then I guess it would
> be possible to hack this in some sort of semi-workable way, but you
> would still have to make sure never to run "git notes prune" in the
> super project. I guess the real question here is: Why would you want
> to do this? and is there maybe some other way your use case can be
> accomodated?
>

Well, I'm tracking different foreign git repositories as submodules.
Those repositories which tracks different projects are not mine
therefore I can't save my own stuff directly in them. I need to
annotate some commits in each submodule.

One option would be to clone each repository in my own place, but I
though it would be simpler if I could store the anntotion in _my_
super project.

Thanks for your time.
-- 
Francis
