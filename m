From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 19:12:32 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121128001231.GA27971@thyrsus.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:12:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVGm-0003UP-1j
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab2K1AMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:12:37 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:58420
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2K1AMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:12:36 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 381AF40661; Tue, 27 Nov 2012 19:12:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210637>

Shawn Pearce <spearce@spearce.org>:
> Well... if we added a fractional seconds to a commit, older versions
> of Git will scream loudly and refuse to work with the new commit. That
> would create a fork of Git.

So much for that idea, I guess.  

Unless..I don't know how git's database representations work.  Are they
version-stamped in any way?  If so, some slightly painful hackery would
get around that problem.

I'm being exploratory, here. No proposal to code anything is in the
offing.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
