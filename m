From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Fri, 04 May 2012 12:08:12 +0200
Organization: Initfour Websolutions
Message-ID: <4FA3AA8C.9030202@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dag@cray.com, Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Fri May 04 12:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQFUB-0000cL-5M
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 12:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab2EDKI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 06:08:29 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:38240 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab2EDKI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 06:08:28 -0400
Received: from [192.168.42.73] (initfour.xs4all.nl [80.101.157.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 324F71954400;
	Fri,  4 May 2012 12:08:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
In-Reply-To: <87fwbgbs0h.fsf@smith.obbligato.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197012>

On 04-05-12 04:26, greened@obbligato.org wrote:
> Herman van Rink <rink@initfour.nl> writes:
>
>>> We don't know right now.  I want to take a look at Herman's patches
>>> first but have been delayed for various reasons.  I hope to get to that
>>> this weekend.  I also want to get at least one release under our belt.
>> I've worked on this a bit over the weekend.
>>
>> I've forked the main git repo  on github to merge my tree on top of that.
>>
>> I basically did a: git subtree merge --prefix=contrib/subtree <my
>> git-subtree branch>
>>
>> The work in progress in on: https://github.com/helmo/git (the
>> subtree-updates branch)
> This branch seems to have a bunch of commits from master or some other
> branch:
>
> on master:
> git log subtree-updates --not HEAD
>
> [...some git-subtree stuff...]
> commit 10d4332e007132a38dc61f03c760d355da5cd550
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Sun Apr 29 18:00:47 2012 -0700
>
>     The seventh batch of topics graduated to 'master'
>     
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> commit a75aba4a5306d0fee6a8ee8b48943e2c19eb2750
> Merge: 55375e9 46e3581
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Sun Apr 29 17:52:02 2012 -0700
>
>     Merge branch 'js/daemon-test-race-fix'
> [...]
>
> Perhaps I'm doing something wrong.  Or does the subtree-updates branch
> need to be refreshed?

Strange, I did fork the git/git repo on April 29 though.
As far as I know I branched from master and merged the subtree stuff
ontop of that.

I've now merged master, fixed some whitespace and pushed my
subtree-updates branch again.

And I get a nice diff from: git diff gitgit/master..subtree-updates

-- 
Met vriendelijke groet / Regards,

Herman van Rink 
Initfour websolutions
