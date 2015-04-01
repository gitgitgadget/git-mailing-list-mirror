From: Guilhem Bichot <guilhem.bichot@oracle.com>
Subject: Re: Invalid responses to 8bit encoding and In-Reply-To questions
Date: Wed, 1 Apr 2015 10:53:11 +0000 (UTC)
Message-ID: <loom.20150401T125113-830@post.gmane.org>
References: <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com> <xmqqa90to78v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 13:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdGlk-0007Ef-Io
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 13:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbbDALZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 07:25:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:37449 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbbDALZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 07:25:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YdGlb-00078u-W2
	for git@vger.kernel.org; Wed, 01 Apr 2015 13:25:04 +0200
Received: from ukc1-proxy-mwg03-o.oracle.com ([144.24.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 13:25:03 +0200
Received: from guilhem.bichot by ukc1-proxy-mwg03-o.oracle.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 13:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 144.24.20.228 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266600>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Geert Uytterhoeven <geert <at> linux-m68k.org> writes:
> 
> > | Oops, I'm afraid automatic-I replied "y" to the git-send-email question
> > | "Which 8bit encoding should I declare [UTF-8]?"
> > | (happened before with the In-Reply-To questions ;-(
> >
> > Would it be possible to reject obviously wrong replies ("y", "yes", "n",
"no")
> > to the 8bit encoding and In-Reply-To questions?
> 
> There is no canned configuration to do so, if that is what you are
> asking.
> 
> It would be possible to do so with code changes to git-send-email;
> look for "ask(", "valid_re", and "confirm_only" to see how they are
> used in existing code that ask questions, if you are interested.

Today I stumbled on exactly this; a colleague had probably typed "yes" when
inappropriate, and the email I received from git-send-email had:

Content-Type: text/plain; charset=yes

then "git am" complained.
