From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Thunderbird: issues with applying saved patches
Date: Tue, 29 Jul 2008 15:16:30 +0100
Message-ID: <80y73kydvl.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 16:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNq2Q-0006bm-BK
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 16:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbYG2OQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 10:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756313AbYG2OQd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 10:16:33 -0400
Received: from rufus.isode.com ([62.3.217.251]:56784 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbYG2OQc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 10:16:32 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SI8mPgBI8w5f@rufus.isode.com> for <git@vger.kernel.org>;
          Tue, 29 Jul 2008 15:16:30 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 29 Jul 2008 15:16:30 +0100
X-Hashcash: 1:20:080729:git@vger.kernel.org::WhI733OIzL74pmwq:0000000000000000000000000000000000000000001Kb1
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90641>

I can see comments and advice on how to *send* patches using
Thunderbird, but for the most part we're not attempting that (we're
using "git send-email").

However, we're (by "we" I mean those of my colleagues who use
Thunderbird, obviously) finding occasional issues with saving patches
from Thunderbird: "git am" complains that they're corrupt.

I'm not sure that they are, but they're Quoted-printable encoded, and
so perhaps not decoded quite correctly by git.  Or perhaps they're
invalidly encoded.

I'm not sure that I care exactly what's at fault, though I think
Thunderbird ought to be able to save an article exactly as it is
(it appears to be encoding it using Quoted-printable).

Anyway, I'm surprised I don't see anyone else mentioning this.  Have I
just missed it, or are we doing something silly (maybe there's some
slightly non-obvious way of saving an article in Thunderbird)?

Could be that other people just go to the message file or something.
Someone tells me that he has no problems if he moves the article from
the IMAP folder to a local folder and uses that.  So maybe most people
just don't notice (because they're not using IMAP)?
