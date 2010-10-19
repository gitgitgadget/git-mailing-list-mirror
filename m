From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] gitk: add the equivalent of diff --color-words
Date: Tue, 19 Oct 2010 15:20:30 +0200
Message-ID: <vpqbp6q9v4x.fsf@bauges.imag.fr>
References: <3c06517d478b3725054f4ca08fb8c38e681549c4.1287223650.git.trast@student.ethz.ch>
	<20101017015836.GC26656@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 15:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8C81-0004Lh-6d
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 15:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612Ab0JSNVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 09:21:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53441 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758578Ab0JSNVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 09:21:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9JDESUU032581
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Oct 2010 15:14:28 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P8C7C-0006Dp-JI; Tue, 19 Oct 2010 15:20:30 +0200
In-Reply-To: <20101017015836.GC26656@burratino> (Jonathan Nieder's message of "Sat\, 16 Oct 2010 20\:58\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 19 Oct 2010 15:14:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9JDESUU032581
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288098869.24557@DA6fAV3wcwMDPT3hLW6G8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159324>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>
>> Use the newly added 'diff --word-diff=porcelain' to teach gitk a
>> color-words mode, with two different modes analogous to the
>> --word-diff=plain and --word-diff=color settings.  These are selected
>> by a dropdown box.
>>
>> As an extra twist, automatically enable this word-diff support when
>> the user mentions a word-diff related option on the command line.
>
> I like this a lot.

+1, it's really a feature I was looking forward.

> After this patch, the diff pane looks like this:
>
> ( ) Diff ( ) Old version ( ) New version   Lines of context: [3 +/-] \
> 	[ ] Ignore space changes  [ Line diff      v]
>
> all on one line.  In particular, it is easy not to notice the
> new dropdown.

Worse than that: if the window is not large enough, the select box
"line diff/markup words/color words" is totally hidden. Is there a way
to have the display wrap to 2 lines when the window is not large
enough?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
