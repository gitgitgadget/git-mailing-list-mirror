From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Error during git gc
Date: Wed, 27 May 2009 17:03:47 +0200
Message-ID: <vpq63fmtwoc.fsf@bauges.imag.fr>
References: <APEJLFBGDNOMCHGLHIHFGELBDEAA.dforman@dairyfoodusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "David Forman" <dforman@dairyfoodusa.com>
X-From: git-owner@vger.kernel.org Wed May 27 17:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Kk7-000747-7x
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 17:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761685AbZE0PIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760307AbZE0PIQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 11:08:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:38176 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759659AbZE0PIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 11:08:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n4RF41f1004188
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2009 17:04:01 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M9KfT-0004xY-9t; Wed, 27 May 2009 17:03:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M9KfT-0008Dz-8V; Wed, 27 May 2009 17:03:47 +0200
In-Reply-To: <APEJLFBGDNOMCHGLHIHFGELBDEAA.dforman@dairyfoodusa.com> (David Forman's message of "Wed\, 27 May 2009 09\:41\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 27 May 2009 17:04:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120071>

(please, keep the Git list in copy, and don't top-post)

"David Forman" <dforman@dairyfoodusa.com> writes:

> Hi Matthieu,
>
> Thanks for the quick reply. Silly me, I was thinking it was an authorization
> issue or something. Now I understand (I think) that the issue is, it's
> trying to access these files, but they don't exist. I can't seem to find the
> '~' files anywhere in the project or .git folder. Is there a spot where
> these names are registered that I can remove them so Git doesn't look for
> them?

Maybe in .git/packed-refs, but I think (or thought !) that Git found
these files only by listing directories.

> -----Original Message-----
> From: Matthieu Moy [mailto:Matthieu.Moy@imag.fr]
> Sent: Wednesday, May 27, 2009 9:00 AM
> To: David Forman
> Cc: git@vger.kernel.org
> Subject: Re: Error during git gc
>
>
> (please provide a Subject: line)
>
> "David Forman" <dforman@dairyfoodusa.com> writes:
>
>> I've encountered the following whenever I access Git and try to compress
> the
>> database due to loose objects.
>>
>> error: cannot lock ref 'HEAD~'
>> error: cannot lock ref 'refs/heads/collections~'
>> error: cannot lock ref 'refs/heads/master~'
>
> I'd say you've edited the files .git/HEAD, refs/heads/collections, ...
> manually with a text editor that leaves ~ backup files. Unless you
> _really_ have branches called collections~ and master~, you can move
> these three files (in a temporary folder, or to trash if you're
> confident enough).

-- 
Matthieu
