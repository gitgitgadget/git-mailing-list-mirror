From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Documentation: fix git-clone manpage not to refer to itself
Date: Mon, 19 Nov 2007 22:18:09 +0300
Message-ID: <87mytayrgu.fsf@osv.gnss.ru>
References: <87ejeq1131.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 20:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuC9C-00034s-8e
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 20:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXKSTSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXKSTSZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 14:18:25 -0500
Received: from javad.com ([216.122.176.236]:3296 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbXKSTSY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 14:18:24 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAJJIFi78751;
	Mon, 19 Nov 2007 19:18:15 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IuC8H-0005kE-BT; Mon, 19 Nov 2007 22:18:09 +0300
In-Reply-To: <Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Mon\, 19 Nov 2007 14\:35\:43 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65489>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi,
>
> On Fri, 16 Nov 2007, Sergei Organov wrote:
>
>> +ifndef::git-clone[]
>
> It is laudable that you want to fix the _generated_ documentation, but 
> there are two things to keep in mind:
>
> - it does _nothing_ to help readers of the sources, and asciidoc was 
>   chosen purposely because the source is human-readable, and

I wonder if C sources are human-readable? No #ifdefs whatsoever? ;)

And please notice that asciidoc is much worse than C preprocessor in
this regard :(

>
> - it makes writing the perl script to do a very tiny subset of asciidoc 
>   formatting much harder.  We encounter enough problems with the different 
>   versions of asciidoc/docbook combinations that I think this perl script 
>   would be actually useful.
>
> I know that the user manual uses some advanced features, too, but it did 
> not use ifdef in the main text, for example, let alone nested ifdefs, 
> which your patch would encourage much more than the source before.

Unfortunately I don't see better solution than using ifdef in this
particular case, though I'm open for suggestions.

What I really do care about is the quality of the documentation that
user reads. For example, when the first option of git-format-*patch*
described in the manual is "-p Generate *patch*...", well..., what does
it generate without -p???

-- 
Sergei.
