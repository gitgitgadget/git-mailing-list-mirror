From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 07:38:31 +0200
Message-ID: <e5bfff550704122238l4a453cb7g38834c7da3432d5a@mail.gmail.com>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 07:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcEUp-0008NU-FJ
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 07:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXDMFid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 01:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXDMFid
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 01:38:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:56650 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbXDMFic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 01:38:32 -0400
Received: by wr-out-0506.google.com with SMTP id 76so729116wra
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 22:38:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E5bG4FAvHmp7LdrN6c3wqORgXOegO8MIFwxJ/TAmQv0xXOOFeENOVnmLZWOJC4zpZm/Hjs0054qurgzdaMCWsRvu/expnkz3tooEAxCmGrNZdTseaQRJP2sR+XBtd9arx+VyI2xPOL/53YQUhxNhhBMPoNHgUtD2R3B05CFydcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eu/9+WWPlOLL98hSdsdY5uf2mGxhx6VbOMRDVEldYq3DYI113jYwtBrCoEcWGqKPaHKW5PpRUwvZF/ZqtV9CrWPKAqw1Za/1IspR7jwu86dsJKGdzfRUEVHVVIRTbr9nKGbotrsLQVkoiv+mbruLlRTwAT48YkxYXfrCYdUI6CI=
Received: by 10.114.157.1 with SMTP id f1mr907537wae.1176442711215;
        Thu, 12 Apr 2007 22:38:31 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Thu, 12 Apr 2007 22:38:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44387>

On 4/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> So I can see two ways to fix this:
>  - bug Paul about alternate diff viewing capabilities in gitk. He's cc'd
>    here. A way to make the "diff" pane show just the new one, the old one,
>    or even both side-by-side with some mousy interface?
>  - add some actual switch to git diff generation to hide the negative side
>    of a unified diff, and add some way to just make gitk pass that switch
>    in.
>
> I dunno. I realize that it's not just gitk - gitweb, qgit etc don't allow
> the tricks *either*, but gitk was the one I just hit this with.

Currently in qgit you can select a revision + a file and call an
external diff viewer, as example Kompare (tweakable from
'Edir->settings->External diff viewer' menu) to view the diff
side-by-side, or in any other way the viewer allows, for the selected
file.

I like also the idea to hide the negative side but I would rather
prefer a togglable command/button instead of a command line argument
or a setting, so to allow easy and quick hide/unhide on the same
patch.

I will work on it..... ;-)

Thanks for idea
Marco
