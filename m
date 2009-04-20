From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 10:59:14 -0700 (PDT)
Message-ID: <m3eivnp5p4.fsf@localhost.localdomain>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvxnY-0007oq-Me
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZDTR7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbZDTR7S
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 13:59:18 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:3720 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbZDTR7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 13:59:17 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1392852tim.23
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2JcMaHmuVkFsSlaOMGFIMTy0OEcUe85muWlyDRGHiBA=;
        b=FRePzIpddvsudgfNWi/yTPvS9RA73qhtM00Oc9bYOzuzGelz6MWmtbfh46Bye8aYHu
         a8BPkME9YzjsoFmNhqRTwvUBlbgR41h80f57vMaxsQavvgzJfxGmlT8Re8tbqnZXOwwL
         4QZO5+bw3d1aAKprBB7oYDPa4nL/bvKVTnjUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NSSK5aKCQ26QC8jYESPFtsyTQFpEbY2k+Bm39lM0oPsBozepqIN4N6+Gm43TEW9v52
         2TUaIkq9TgOgDGHeE/N8+jkyquijZeiV3OX/arsvP4ZotiE22J+SWlqVrsu8MM7iz+yT
         kxJX3IaRR1M+Xak+gKJdL4O7m4MthA5OuiDyc=
Received: by 10.110.14.12 with SMTP id 12mr4341689tin.38.1240250355583;
        Mon, 20 Apr 2009 10:59:15 -0700 (PDT)
Received: from localhost.localdomain (abwc215.neoplus.adsl.tpnet.pl [83.8.226.215])
        by mx.google.com with ESMTPS id y5sm1941688tia.3.2009.04.20.10.59.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 10:59:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3KHx7oG008202;
	Mon, 20 Apr 2009 19:59:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3KHx42o008196;
	Mon, 20 Apr 2009 19:59:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117013>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Now the real question was if we still support anything older, and if so
> > what is the bottom version?
> >
> > I certainly can go with "5.8.1 or later", but I vaguely recall during the
> > gitweb discussion we said anything without the utf-8 support is unusable
> > for gitweb, but I think we also said that the rest of the git codebase
> > should support running with something older (5.6.1, perhaps).

> So here's my take-away. For the *.perl scripts and gitweb, it's
> 5.8.0. For the test suite and Git.pm, all Perl versions are
> theoretically supported, but for practical purposes, it may be
> 5.6.0.

Errr... no.  For gitweb we require good Unicode support, which means
Perl 5.8.x (IIRC 5.8.1).  For all other: commands (and helpers)
written in Perl like git-svn, fragments of Perl in test suite (because
of incompatibility and corner cases of shell scripting) - with possible
exception of testing gitweb, and Git.pm (which some commands in Perl
use) I think it is reasonable to expect 5.6.0 at least.

> Whatever is decided this time, perhaps it should be burned into the tops of
> the *.perl scripts (i.e. "require 5.008;"). It should also be added to
> CodingGuidelines. You know, so this conversation doesn't keep recurring. :-)
> 
> j.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
