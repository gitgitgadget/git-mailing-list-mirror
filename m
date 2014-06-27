From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: Tool/Scripts - For maintaining different branches on a repo
Date: Fri, 27 Jun 2014 11:57:51 +0530
Message-ID: <CAD6G_RQ9KpW4i5BPRNrSWmR5oZn0eAZsvM4S_erCXx0+Y7Oj2Q@mail.gmail.com>
References: <CAD6G_RRxj_tHhiGxP+ehNMBewqveUbbGuLLxgnHjUt96WkC_xg@mail.gmail.com>
	<20140620223047.GB856079@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jagan Teki <jagannadh.teki@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 08:27:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Pdc-0005TH-Du
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 08:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbaF0G1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 02:27:53 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:61396 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaF0G1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 02:27:52 -0400
Received: by mail-yk0-f171.google.com with SMTP id 200so2617200ykr.30
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=cSxhigZrJi45bg6YPI0sSU5XyOe1/buP38C8eIpOn/M=;
        b=qlxQ4XTqoEZ1cQvSOHrnzp4ZdnGwORRyxrd7xQ6vuueJSLCM560SV6DQaX/QGdbMA7
         gVNdh0gNYM/Rq6DGFT4TvScFIsPN3uyKCQPfCa/ASicYd5XQbT/bdkQdYApem2475AOK
         iLc4Fu7Shwq+o64yKRmG2BwTRXxTVK8jYNODOlCesQ195afwgn1yupQPxfvP7XyLERtd
         0iZs1hK8IInENBbRbJv57rYiMGxpJVWrTs/ckRSTjaWZT1W47vGxrAG+tLUx9MrBsApz
         YceqiIA21ifSYv94oek/VbGZhfFU/Og7JbQB9bsNuwivKTGxOYPCq8b1SGOgwnBq+F0m
         EWBA==
X-Received: by 10.236.98.103 with SMTP id u67mr28638879yhf.99.1403850471578;
 Thu, 26 Jun 2014 23:27:51 -0700 (PDT)
Received: by 10.170.187.84 with HTTP; Thu, 26 Jun 2014 23:27:51 -0700 (PDT)
In-Reply-To: <20140620223047.GB856079@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252533>

On Sat, Jun 21, 2014 at 4:00 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Jun 19, 2014 at 04:18:22PM +0530, Jagan Teki wrote:
>> Hi,
>>
>> I have a single repo with different kinds of branches say 4 branches.
>> Developers will send a patches wrt to specific branch.
>
> I presume here that you're referring to emailed patches, or patches in
> independent files, as opposed to just having branches with commits.

Let me clear my requirement:

I'm using Thunderbird,  the tool will pick the patches with _defined_
subject prefix
and apply the respective branches as I inputting.

Please let me know if you still have any clarity.

>
>> Is there any opensource tool/script that does applying patches/maintaining
>> the branches in repo w/o manual intervention?
>
> If you want something that works with patches specifically, TopGit might
> do what you want.  If what you're looking for is a tool that accepts
> patches and automatically applies them, I'm not aware of one.  It
> shouldn't be terribly difficult to script, though.
>
> If you don't need to deal with patches and can instead deal with git
> repositories, GitLab and Gitorious offer merge requests, which might
> make life easier.  I have heard that GitLab is less painful to set up.
>
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187


thanks!
-- 
Jagan.
