From: Scott Chacon <schacon@gmail.com>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Mon, 2 Jul 2012 14:11:32 -0700
Message-ID: <CAP2yMaLy3sBwybMH2LYs9Sg0AigZ-_tAx4SbHOrwr3T6GfLSaw@mail.gmail.com>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca> <20120615182534.GB14843@sigill.intra.peff.net>
 <7vvcis9ylx.fsf@alter.siamese.dyndns.org> <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com>
 <7v7gulzxme.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Johnson <computerdruid@gmail.com>, Jeff King <peff@peff.net>,
	Graham Ballantyne <grahamb@sfu.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlnuZ-0003fn-9c
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 23:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab2GBVLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 17:11:54 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38044 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895Ab2GBVLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 17:11:53 -0400
Received: by qadb17 with SMTP id b17so2190892qad.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ogj9fKy5kGkyRfkBqI/sOKsIk2CU/OV8fog068tNsK8=;
        b=rSHOr6L2eQkybYg5Xqg4K7SPEV7WYCO11QGLKe+Js8rtSbZXBD///7q938eVrJRWTR
         qBJqPpMzbJxgKwVivCqY6Pmro0C8q69wLo6SviN+BjdQ7x3nbErwJRHzTMUEFmviYkJ5
         udIvQUYBJncFJ4u7JsC+RbjDW3iNnzj4FdSRbj1CXKpOViMyoiIhtrZZkY9HemovnsOP
         N+fNzCZ4sTCqPtz2NHgdOoz4OuBjjPZQM+H7lKeKPFlFzLbEJwnTwtWymMQIL2nJEFn1
         P1eUJ/qJhDxQz8bjDWVdEPMwVHS/xhV+qa4Mulu9EWKXxhxmGIOGPa1h2bDK88H9J/O4
         BCYA==
Received: by 10.224.117.13 with SMTP id o13mr25819426qaq.73.1341263512841;
 Mon, 02 Jul 2012 14:11:52 -0700 (PDT)
Received: by 10.229.251.143 with HTTP; Mon, 2 Jul 2012 14:11:32 -0700 (PDT)
In-Reply-To: <7v7gulzxme.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200863>

Hey,

On Mon, Jul 2, 2012 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I just noticed that the download buttons (for tarballs) on gitscm.com
>> all point to the github tag list ( https://github.com/git/git/tags )
>> instead of the location pointed to by your [ANNOUNCE] message (
>> http://code.google.com/p/git-core/downloads/list )
>
>> If you do something special as part of releasing these tarballs, is
>> this something that should be corrected?
>
> I do not do anything special other than "make dist", but obviously
> anybody's "list of tags" that drive "git archive" won't run it, so
> it is a wrong thing to point at, regardless of who hosts it.

Thanks for letting me know - I didn't realize that the built tarballs
were different from the tagged commit trees.  I will update the links.

Scott
