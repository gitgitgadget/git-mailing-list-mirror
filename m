From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: A typesetting problem with git man pages
Date: Thu, 30 Oct 2008 00:22:43 +0200
Message-ID: <87od13ujm4.fsf@iki.fi>
References: <87skqfus7v.fsf@iki.fi>
	<2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Oct 29 23:24:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvJSK-0006Hv-C5
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 23:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYJ2WWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYJ2WWr
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 18:22:47 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:43782 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbYJ2WWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 18:22:46 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C70086E1EF; Thu, 30 Oct 2008 00:22:45 +0200
In-Reply-To: <2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com> (Jonas Fonseca's message of "Wed\, 29 Oct 2008 20\:35\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99419>

Jonas Fonseca (2008-10-29 20:35 +0100) wrote:

> On Wed, Oct 29, 2008 at 20:16, Teemu Likonen <tlikonen@iki.fi> wrote:
>> Does anybody know why "man" prints those ".ft" commands? The
>> corresponding code in git-log.1 file is this:

> I had a similar problem after upgrading on Ubuntu and came up with a
> patch to optionally disable some of asciidoc.conf (commit
> 7f55cf451c9e7). Try putting DOCBOOK_XSL_172=Yes in your config.mak.

Ah, thank you. That fixed it.

In case someone is interested there is still a minor flaw that an
example command and the following paragraph is printed with no empty
line between them. Like in the beginning of "git help tutorial", for
example:

    First, note that you can get documentation for a command such as git
    log --graph with:

        $ man git-log             
    It is a good idea to introduce yourself to git [...]

It would be nicer if there was empty line after "$ man git-log". I can't
remember if this is new issue or not. This applies only to man pages; in
html pages there are nice boxes around example commands and equal
spacing before and after them.
