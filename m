From: Sam Vilain <sam@vilain.net>
Subject: Re: Split a subversion repo into several git repos
Date: Sat, 13 Oct 2007 09:27:24 +1300
Message-ID: <470FD8AC.5000406@vilain.net>
References: <op.tz09zaizjwclfx@ichi> <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com> <470E9858.5050904@vilain.net> <op.tz28hnd2jwclfx@ichi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Eivind LM <eivliste@online.no>
X-From: git-owner@vger.kernel.org Fri Oct 12 22:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgR6q-0005p5-Lb
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 22:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661AbXJLU1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 16:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbXJLU1i
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 16:27:38 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54870 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324AbXJLU1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 16:27:38 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0C2E220565C; Sat, 13 Oct 2007 09:27:36 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 7A053204402;
	Sat, 13 Oct 2007 09:27:24 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <op.tz28hnd2jwclfx@ichi>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60703>

Eivind LM wrote:
>>
>> git-svn init -t projectA/tags -b projectA/branches \
>>    -T trunk/projectA http://svn.host.com/
>> git fetch
>
> With my paths this translates into
>
>   $ git-svn init -b eivindlm/branches \
>                  -t eivindlm/tags \
>                  -T eivindlm/trunk/src/probesimulator \
>                  file:///svn-repo/
> , which prints the happy message:
>   Initialized empty Git repository in .git/
>
> The next command is unfortunately not as happy:
>   $ git fetch
>   fatal: 'origin': unable to chdir or not a git archive
>   fatal: The remote end hung up unexpectedly
>   Cannot get the repository state from origin
>
> I suppose this is due to my silly svn-repo layout... However, after
> some trial and error it seems like the following command gives me what
> I want (I don't need tags or other branches than main):

Whoops, my mistake.  That should have been "git svn fetch".

Sam.
