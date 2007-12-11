From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:24:54 -0500
Message-ID: <4aca3dc20712111124y1d9171eem4d2c4f0872703786@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <vpq4pepcaz5.fsf@bauges.imag.fr>
	 <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AjJ-0003q5-5B
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbXLKTY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbXLKTY7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:24:59 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:56703 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbXLKTY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:24:58 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1289002nze
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:24:55 -0800 (PST)
Received: by 10.142.89.9 with SMTP id m9mr1316919wfb.1197401094964;
        Tue, 11 Dec 2007 11:24:54 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 11:24:54 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67913>

On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 11 Dec 2007, Matthieu Moy wrote:
> >
> > I've seen you pointing this kind of examples many times, but is that
> > really different from what even SVN does? "svn log drivers/char" will
> > also list atomic commits, and give me a filtered view of the global
> > log.
>
> Ok, BK and CVS both got this horribly wrong, which is why I care. Maybe
> this is one of the things SVN gets right.
>
> I seriously doubt it, though. Do you get *history* right, or do you just
> get a random list of commits?

No, it will get actual history (IE not just things that happen to have
that path in the repository)
