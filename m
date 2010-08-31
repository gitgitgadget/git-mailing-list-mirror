From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] optionally disable overwriting of ignored files
Date: Tue, 31 Aug 2010 20:44:11 +0200
Message-ID: <20100831184410.GA29001@book.hvoigt.net>
References: <4C6A1C5B.4030304@workspacewhiz.com> <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost> <vpqaaod7mpa.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVoj-0005vn-5P
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab0HaSoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:44:14 -0400
Received: from darksea.de ([83.133.111.250]:36925 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750720Ab0HaSoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:44:13 -0400
Received: (qmail 12656 invoked from network); 31 Aug 2010 20:44:11 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Aug 2010 20:44:11 +0200
Content-Disposition: inline
In-Reply-To: <vpqaaod7mpa.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154961>

On Mon, Aug 23, 2010 at 10:33:21AM +0200, Matthieu Moy wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > By default, checkout and fast-forward merge will overwrite ignored
> > files. Make this behavior configurable.
> 
> I'd use this option if it gets into git.git.
> 
> I didn't follow the discussions when the feature was added, and I was
> basically not aware that Git could trash my ignored files this way.
> I've always thought that Git took great care not to touch untracked
> files, and I found this good ...

I agree here. I would like to have this as an option as well. And I
think adding a "ignored but precious" category does not make sense in
practise. My guess is that a user would only know _after_ git trashed
some precious file that it belongs into that category;) I have told my
users that git is very careful with their files and I would like to keep
this promise.

I was actually never annoyed by a failed checkout because of an
untracked file in the way. (A 'git clean -fx' always fixes this).

Thanks.

Heiko
