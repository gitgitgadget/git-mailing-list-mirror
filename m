From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 04/10] Change "tracking branch" to "remote-tracking branch"
Date: Thu, 28 Oct 2010 03:55:21 +0200
Message-ID: <vpq1v7b84ja.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-5-git-send-email-Matthieu.Moy@imag.fr>
	<20101023184853.GH21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 03:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBHl6-0000b3-UG
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 03:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab0J1B6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 21:58:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:57579 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757555Ab0J1B6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 21:58:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9S1tMim021030
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 03:55:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBHi6-0005NC-04; Thu, 28 Oct 2010 03:55:22 +0200
In-Reply-To: <20101023184853.GH21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 13\:48\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 28 Oct 2010 03:55:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160151>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -131,7 +131,7 @@ to point at the new commit.
>>  	you have. In such these cases, you do not make a new <<def_merge,merge>>
>>  	<<def_commit,commit>> but instead just update to his
>>  	revision. This will happen frequently on a
>> -	<<def_tracking_branch,tracking branch>> of a remote
>> +	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
>>  	<<def_repository,repository>>.
>
> Why not keep the anchor name, like so:
>
> 	<<def_tracking_branch,remote-tracking branch>>
>
> (for brevity and to keep old links valid)?

(sorry, I had overlooked this message)

We could do that, but I don't think there are many links to the anchor
from outside
(http://www.google.com/search?q=link%3Ahttp%3A%2F%2Fwww.kernel.org%2Fpub%2Fsoftware%2Fscm%2Fgit%2Fdocs%2Fgitglossary.html
suggests there are none, but it seems to have missed at least the one
in git(1)), and links would still point to the right page, if not to
the right anchor.

Your proposal would break the regularity of anchor names, which I
think is more important than brievety.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
