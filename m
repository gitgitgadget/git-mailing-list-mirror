From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [1.8.0] Remote tag namespace
Date: Wed, 2 Feb 2011 00:14:26 +0100
Message-ID: <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <20110201181428.GA6579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 00:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPRL-0002YV-3K
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 00:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab1BAXPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 18:15:08 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50653 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1BAXPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 18:15:07 -0500
Received: by yib18 with SMTP id 18so2708605yib.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 15:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Tn7xN0JDDlKjkuV7U4u0+SIKZSV5hmiRmWyHoNTGF0k=;
        b=wAO7fao3RIxQaC7mCHalvctAcZp8wrY0MsEHDh+29bK5oW8yIcqR/bt6cOBOcG5DbX
         /+S1eqMXsdh7nQK+mEXnFtrc5oNSmtHE6kNOiA9mKc3WLSBPA2tSiUMOYOWRuWrr57ix
         OIDnUlriw6VE6vE0oLZlMjX1+12gVzdaN2+Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CPHnDs+ebsV5S7xc71PMniQnAZCZR08F8nB7WGbh4XXSG57epqCkBsTceuKdKkVwiN
         HOLEg5c1ykw9t13cT+gL6jsttqTMLKK1sY+nNwYgFyWzsp4LEYmlxymtcXLT5nPxKMAP
         8RMU3rIE9XFO0d0z544sH1KZGdQpEByakykgU=
Received: by 10.150.229.16 with SMTP id b16mr3158744ybh.226.1296602106383;
 Tue, 01 Feb 2011 15:15:06 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Tue, 1 Feb 2011 15:14:26 -0800 (PST)
In-Reply-To: <20110201181428.GA6579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165876>

Heya,

On Tue, Feb 1, 2011 at 19:14, Jeff King <peff@peff.net> wrote:
> i.e., make refs/remotes/* an actual mirror of selected parts of the
> remote's refs/ hierarchy. And then figure out sane rules for merging
> those namespaces into the ref lookup procedure.

Jeff, Nguy, are either of you interested in writing up a new/modifying
this proposal to be about namespacing everything? I think it
definitely makes sense to have a namespace for notes, replaces, as
well as tags, especially since it would also allow us to propagate
these by default (at least to the refs/remotes namespace), and think
it's a good idea to go all the way if we're going to do this at all
(or we'll have the same discussion again later for notes and replaces,
and whatever comes after that).

-- 
Cheers,

Sverre Rabbelier
