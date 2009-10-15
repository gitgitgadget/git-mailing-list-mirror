From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: why no "ignore" command on git
Date: Thu, 15 Oct 2009 13:31:01 +0200
Message-ID: <vpqaazsrj0q.fsf@bauges.imag.fr>
References: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
	<200910142220.51725.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 13:38:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyOep-00088t-1k
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 13:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbZJOLfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 07:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758479AbZJOLfE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 07:35:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:41869 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758176AbZJOLfD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 07:35:03 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9FBV2fp015635
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Oct 2009 13:31:02 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MyOXu-00034d-77; Thu, 15 Oct 2009 13:31:02 +0200
In-Reply-To: <200910142220.51725.wjl@icecavern.net> (Wesley J. Landaker's message of "Wed\, 14 Oct 2009 22\:20\:50 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 15 Oct 2009 13:31:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130387>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> On Wednesday 14 October 2009 16:35:23 Ralf Thielow wrote:
>> why does git don't have an "ignore" command, to ignore some files or
>> directories all the time.
> [...]
>> I read on some pages by a google search that you can create
>> a ".gitignore" directory or something like that. But you had to do
>> this manually.
>>
>> why there is no "ignore" command on git?
>
> You could always make your own git-ignore script, e.g.:
>
> #!/bin/sh
> echo "$@" >> .gitignore

Sure. OTOH, there are other interesting things a "ignore" command can
do. bzr, for example, has a "bzr ignore" command that can either add
stuff to your .bzrignore, or tell you which pattern cause which file
to be ignored. That's handy sometimes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
