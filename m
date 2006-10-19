From: "Ryan Anderson" <rda@google.com>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 16:28:24 -0700
Message-ID: <87dcb0bd0610191628h2bbb5a3o8f445718312ac44c@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
	 <20061019161319.GA75501@over-yonder.net>
	 <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
	 <Pine.LNX.4.64.0610191110290.3962@g5.osdl.org>
	 <vpqlknc3zmn.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Andreas Ericsson" <ae@op5.se>, "Carl Worth" <cworth@cworth.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 01:28:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GahJU-0000y1-J6
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946670AbWJSX2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 19:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWJSX2d
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 19:28:33 -0400
Received: from smtp-out.google.com ([216.239.33.17]:55574 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751615AbWJSX2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 19:28:32 -0400
Received: from spaceape14.eur.corp.google.com (spaceape14.eur.corp.google.com [172.28.16.148])
	by smtp-out.google.com with ESMTP id k9JNSSCk020063
	for <git@vger.kernel.org>; Fri, 20 Oct 2006 00:28:29 +0100
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ILoBeDLDK67RoanCHlPsLgjjj75j8GgXOv3TF1ymsVzuW9dI648ue/Oi9e/fasX2c
	8iXWF71renaBY2YzW/Gog==
Received: from py-out-1112.google.com (pyff25.prod.google.com [10.34.32.25])
	by spaceape14.eur.corp.google.com with ESMTP id k9JNRuwt000658
	for <git@vger.kernel.org>; Fri, 20 Oct 2006 00:28:24 +0100
Received: by py-out-1112.google.com with SMTP id f25so967660pyf
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 16:28:24 -0700 (PDT)
Received: by 10.65.20.3 with SMTP id x3mr806703qbi;
        Thu, 19 Oct 2006 16:28:24 -0700 (PDT)
Received: by 10.64.83.11 with HTTP; Thu, 19 Oct 2006 16:28:24 -0700 (PDT)
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
In-Reply-To: <vpqlknc3zmn.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29387>

On 10/19/06, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
>
> > Btw, I do believe that bzr seems to be acting a lot like BK, at least when
> > it comes to versioning. I suspect that is not entirely random either, and
> > I suspect it's been a conscious effort to some degree.
> >
> > Which is fine, in the sense that there are certainly much worse things to
> > try to copy.
>
> By curiosity, how would you compare git and Bitkeeper, on a purely
> technical basis? (not asking for a detailed comparison, but an "X is
> globaly/much/terribly/not better than Y" kind of statement ;-) )

Having used both in a past job setting (simultaneously even),
BitKeeper was a huge win over CVS, but after a while, some of its
tools  were just very frustrating in comparison with comparable Git
interfaces, and I had actually written a terribly slow BK -> Git
converter just so I could incrementally import our BK tree, then use
Git's history-viewing because it was so much more pleasant to work
with.

For small projects (~5 people), they weren't hugely different, but Git
just felt more comfortable after a while.  (It was actually possible
to do a commit from the command line in a single command, without
getting annoyed by the interface, for a trivial example.)
