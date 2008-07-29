From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 12:29:02 -0700
Message-ID: <d411cc4a0807291229w3961f9auf26d40544138c9be@mail.gmail.com>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	 <7vmyk0fux8.fsf@gitster.siamese.dyndns.org>
	 <7v3alsfsy8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNuta-00082X-JW
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYG2T3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbYG2T3F
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:29:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:56916 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbYG2T3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:29:03 -0400
Received: by yw-out-2324.google.com with SMTP id 9so15850ywe.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=A7/yiGVhpnE+CjxQLhY91POOBmZQQ9GtYYtPGcTkEhM=;
        b=v28Pc++JCbS9xml+dxX4L1m9oFlN2JfPBxk9dwnUONxqb8DnpyKKaqEzo4I8yRhrTG
         mMnOmPdomQbsAdRt7WxftByIXW/Br0nRY6IJdsivjZ2yOOGvHdyDq4/zIFKf5/7rV3bN
         fmHzaWPaMGaC3u6gbzOimVlGMtORXrfb5zWH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uqXE7YyXOuxjG1gZknkI1jDcNuzPF+lflipXUZOuWlunfRdFL0Cvf8Z3rZjmjfBUF0
         fT7Ul6VTPHsCVhxZe6W3AL+Cap814Lv9jGgus6ZbK+/Lwssv6spk6HRxtdou71BKtrqr
         p+KlXsYDk/zD947j73/ssL9+BfyQD4Ow0uurs=
Received: by 10.114.255.1 with SMTP id c1mr7164004wai.67.1217359742154;
        Tue, 29 Jul 2008 12:29:02 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Tue, 29 Jul 2008 12:29:02 -0700 (PDT)
In-Reply-To: <7v3alsfsy8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90671>

On Tue, Jul 29, 2008 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> (cont'd)
>
> I was planning to comment on the contents (i.e. text) but it appears that
> most of the stuff was borrowed from the User Manual, so I won't.
>
>        Side note: I wonder if this makes the whole "Community Book"
>        GPLv2.  What would happen to the part that includes your own
>        screencast?  You do not mind it be contaminated by our licence?
>
> But there seems to be some stuff User Manual does not talk about.

Yes, I'm using text from the User Manual and beginning to convert a
bunch of the text to make more sense in the new context, but it is
still under GPL2 and the screencasts are being linked to, not included
and distributed, so they shouldn't be affected.  However, they are
MIT, so you can pretty much do whatever you want with them.

> [3_basic_branching_and_merging.html]
>
>  - You've talked about low-level individual objects in an earlier section
>   but you stopped at showing a single commit pointing at a tree.  People
>   would find branching and merging very hard to get, without
>   understanding the commit DAG.  On the other hand, you can explain
>   commit DAG without going into details down to trees and blobs in the
>   earlier section.  The user manual has "understanding reachability"
>   section early on for this exact reason.
>
> [5_creating_new_empty_branches.html]
>
>  - As I repeatedly said on the list, I do not think teaching this is
>   useful.  Multiple roots may happen as a result of pushing (or pulling)
>   from a repository with unrelated root, but it is not something you
>   would want to actively aim for.  At least there needs an explanation
>   for the reason why making disjoint roots in the same repository is
>   (sometimes) a good thing to do, and what its downsides are.
>

Thank you for your feedback, I'll try to address both of these points
as I revise the book.

Scott
