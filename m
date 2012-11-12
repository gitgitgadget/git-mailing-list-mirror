From: Adam Spiers <git@adamspiers.org>
Subject: Re: splitting off shell test framework
Date: Mon, 12 Nov 2012 23:09:56 +0000
Message-ID: <CAOkDyE9phgZ4ToWTWa2GYgfVkDknCqWr+KEyqVoHg0RVrVVk9A@mail.gmail.com>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
	<CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, felipe.contreras@gmail.com,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY38u-0006zo-Op
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab2KLXJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:09:58 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54305 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab2KLXJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:09:57 -0500
Received: by mail-wi0-f178.google.com with SMTP id hr7so2928023wib.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=+xUtvObJrPrusbeu5c2TfgSBSCG1TikzrtP/RTOZBJs=;
        b=f8+69p7S1dBTk5Ie30vAXo1EbTBQGsesw9KGa0EqAfgUGg0aQsr9EvxGggm+E4UY9z
         QNm1jk9tu7KTVs1fEtBoXebcNy0ealSbuNKa7KgQxWQOjo2MtlAS0hgP17qGKZKU08qo
         1jtr112t/VYsYZbevqjycqFb9WxrTIfDVeRQJX4/3cFGixCMcq4FW/5VcTxPNs8zwo3e
         H46JU/94BTl1bUPeoQsfmiCqM7f/2nxUeWwP0rudHI5tchZDhapFXZMXbxQI0z31dD4s
         FHJuUzdYLb4+HpnCCGRueE8Cx6Ll4kniuPuC3kSDQcUnydI9jPstd83arLHjWJA2/Rlc
         d2dQ==
Received: by 10.180.19.197 with SMTP id h5mr17254555wie.22.1352761796074; Mon,
 12 Nov 2012 15:09:56 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Mon, 12 Nov 2012 15:09:56 -0800 (PST)
In-Reply-To: <CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com>
X-Google-Sender-Auth: Jsshec0FpKljr2Og7Y6cfgyhQrU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209541>

On Mon, Nov 12, 2012 at 6:18 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Mon, Nov 12, 2012 at 11:37 AM, Adam Spiers <git@adamspiers.org> wrote:
>> As it turned out to be fairly easy, I was wondering if there would be
>> any interest in doing this more formally, i.e. splitting off the
>> framework so that it could be used and improved outside the scope of
>> git development?  Of course this would pose the question how git would
>> consume this new project without any risk of destabilisation.  I'm
>> guessing that simply using a git submodule would solve the problem,
>> but ICBW ...
>>
>> Just an idea.  Interesting, or terrible? :)
>
> Done at least once already:
>
> http://comments.gmane.org/gmane.comp.version-control.git/201591

Nice!  So hopefully someone will submit patches to build a two-way bridge
via git subtree.  Having them diverge would be sad.
