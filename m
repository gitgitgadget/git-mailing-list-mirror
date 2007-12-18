From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH 5/7] parse-options: Add a gitcli(5) man page.
Date: Mon, 17 Dec 2007 18:00:42 -0800
Message-ID: <20071218020042.GA9044@blorf.net>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org> <1197915797-30679-2-git-send-email-madcoder@debian.org> <1197915797-30679-3-git-send-email-madcoder@debian.org> <1197915797-30679-4-git-send-email-madcoder@debian.org> <1197915797-30679-5-git-send-email-madcoder@debian.org> <1197915797-30679-6-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 03:01:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Rle-000608-PB
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 03:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764517AbXLRCAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 21:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764428AbXLRCAp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 21:00:45 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:57638 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764517AbXLRCAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 21:00:43 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id 5D1D88B69; Mon, 17 Dec 2007 18:00:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1197915797-30679-6-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68689>

On Mon, Dec 17, 2007 at 07:23:15PM +0100, Pierre Habouzit wrote:
> + * when a command line option takes an argument, use the 'sticked' form.

A minor issue:  the word "sticked" reads very strangely to me (in this
spot and several others in your text).  I think something like joined or
attached (or even abutted) would be better, as seen in this altered text
for the spot cited above (with a few other improvements thrown in):

 * when a command line option takes an argument, it is best to use the
   'joined' form.  In other words, write `"git foo -oArg"` instead of
   `"git foo -o Arg"` for short options, and `"git foo --long-opt=Arg"`
   instead of `"git foo --long-opt Arg"` for long options.  If an option
   takes an optional option-argument, it MUST be written using the
   'joined' form when providing the option-argument.

..wayne..
