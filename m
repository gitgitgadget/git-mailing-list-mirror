From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Locating Git Clone
Date: Wed, 19 Jan 2011 10:13:55 +0100
Message-ID: <4D36AB53.6040105@seznam.cz>
References: <1295426139368-5938712.post@n2.nabble.com> <loom.20110119T094539-141@post.gmane.org> <1295427449605-5938759.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 10:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfU7Q-0005Pe-H6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 10:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1ASJON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 04:14:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:35027 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab1ASJOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 04:14:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PfU7G-0005M6-US
	for git@vger.kernel.org; Wed, 19 Jan 2011 10:14:10 +0100
Received: from 188.120.198.113 ([188.120.198.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 10:14:10 +0100
Received: from grajcar1 by 188.120.198.113 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 10:14:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.120.198.113
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1295427449605-5938759.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165248>

On 11-01-19 09:57, flebber wrote:
>
> So how can I determine which folder is set for git? Should I have declared
> the folder to clone to in the orginal clone command?
>
> I tried using --get-dir and the man.
>
> renshaw@RENSHAWRESIDENC ~
> $ --git-dir
> sh.exe": --git-dir: command not found

Wrong, it's a git option, i.e., you'd use something like
git --git-dir some_git_command ...

But you do NOT need it at all. Don't use it, it's a bit advanced. Just
change into the right directory before using any git command.

> renshaw@RENSHAWRESIDENC ~
> $ --git-dir=GIT_DIR
> sh.exe": --git-dir=GIT_DIR: command not found
>
> renshaw@RENSHAWRESIDENC ~
> $ help mv
> sh.exe": help: no help topics match `mv'.  Try `help help'
> fo mv'.
>
> renshaw@RENSHAWRESIDENC ~
> $ man -k mv
> sh.exe": man: command not found
>
> renshaw@RENSHAWRESIDENC ~
> $ info mv
> sh.exe": info: command not found

Forget it,
http://www.google.com/search?q=man+mv
is what I use instead. It's fast enough for me.

> renshaw@RENSHAWRESIDENC ~
> $ mv grails-1.3.6 c:\grails
> mv: cannot stat `grails-1.3.6': No such file or directory

You did
git clone git://github.com/grails/grails-core.git
so I'd suppose you could move it using
mv grails-core c:/grails
Do not use "\" as it's an escape character, you'd need to double it. But
use anything you like for moving it.
