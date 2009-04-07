From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Showing the version of a file that's in the Index.
Date: Tue, 07 Apr 2009 23:14:11 +0300
Message-ID: <874ox0w7ak.fsf@iki.fi>
References: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com>
	<200904072210.05591.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Apr 07 22:15:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrHi2-0003f9-6W
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbZDGUOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 16:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbZDGUOR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 16:14:17 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59614 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbZDGUOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 16:14:17 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 49D075A80063A346; Tue, 7 Apr 2009 23:14:13 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LrHgR-00076g-3r; Tue, 07 Apr 2009 23:14:11 +0300
In-Reply-To: <200904072210.05591.markus.heidelberg@web.de> (Markus Heidelberg's message of "Tue\, 7 Apr 2009 22\:10\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115983>

On 2009-04-07 22:10 (+0200), Markus Heidelberg wrote:

> Tim Visher, 07.04.2009:
>> How do you go about showing the version of the file that's in an
>> index.
>
> With version do you mean content? Then
>
>     git cat-file -p :0:file
> or
>     git cat-file -p :file

Or

    git show :file
