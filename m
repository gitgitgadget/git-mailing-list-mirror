From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git diff does not detect newly added files to working tree
Date: Wed, 03 Mar 2010 21:12:22 +0100
Message-ID: <vpqlje9kvvd.fsf@bauges.imag.fr>
References: <27772711.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 21:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmuvn-00056R-LN
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab0CCUM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:12:28 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40738 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756513Ab0CCUM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:12:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o23K9XeL025470
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Mar 2010 21:09:34 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Nmuve-0000rD-GX; Wed, 03 Mar 2010 21:12:22 +0100
In-Reply-To: <27772711.post@talk.nabble.com> (jateeq's message of "Wed\, 3 Mar 2010 12\:03\:48 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Mar 2010 21:09:34 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141471>

jateeq <jawad_atiq@hotmail.com> writes:

> Hello,
>
> If I add a new file to a working tree, and run the following command without
> having staged or committed the file, according to the manual I should be
> able to get the name of the file

Which part of the manual makes you think you should see untracked
files? (that's a real question ;-) ).

> - but it just doesn't show up. Anyone knows what I'm doing wrong?

git diff doesn't mention untracked files, but shows the diff between
the working tree and the staged content for files known to git.

To see the files in "git diff", you have to let Git know about these
files, with "git add --intent-to-add the-file-you-want-to-see" (alias
"git add -N"), or you should use "git status".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
