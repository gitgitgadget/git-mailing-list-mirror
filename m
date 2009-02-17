From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] Re: Minor grammar fix in the 'Not a git repository' message
Date: Tue, 17 Feb 2009 09:50:29 +0100
Message-ID: <20090217085028.GB7338@lars.home.noschinski.de>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de> <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de> <7vd4diez2z.fsf@gitster.siamese.dyndns.org> <20090217001747.GA23278@vidovic> <7vk57pevig.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLgR-0001zO-E6
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbZBQIug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZBQIug
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:50:36 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:41959 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBQIug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:50:36 -0500
Received: from [87.78.71.97] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZLev-0003jD-PZ; Tue, 17 Feb 2009 09:50:29 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZLev-0001w0-39; Tue, 17 Feb 2009 09:50:29 +0100
Content-Disposition: inline
In-Reply-To: <7vk57pevig.fsf@gitster.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110337>

* Junio C Hamano <gitster@pobox.com> [09-02-17 01:51]:
>Nicolas Sebrecht <nicolas.s-dev@laposte.net> writes:
>
>> The message
>> 	"Not inside a git repository" 
>> of Wincent looks like the clearest and the fairest one.
>
>I tend to agree.  I was only trying to see if we can salvage a more
>precise diagnosis f66bc5f (Always show which directory is not a git
>repository, 2008-12-22) tried to give users, but to do it throughly the
>sentence will become even more awkward.
>
>    "Not inside a bare git repository nor a work tree that has .git/ somewhere in it."

I think f66bc5f used the wrong path for the error message.
If the comment above this part of the code is accurate, cwd
is which should be belonging to a git repository, so I would suggest

     die("Not inside a git repository: %s", cwd)

  - Lars.
