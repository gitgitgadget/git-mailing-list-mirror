From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Show patch in gitk --first-parent ?
Date: Wed, 30 Oct 2013 15:30:27 +0100
Message-ID: <1lbk7r8.1khd6h5pbrifuM%lists@haller-berlin.de>
References: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
Cc: paulus@samba.org (Paul Mackerras),
	jrnieder@gmail.com (Jonathan Nieder)
To: kha@treskal.com (Karl Wiberg),
	git@vger.kernel.org (Git Mailing List)
X-From: git-owner@vger.kernel.org Wed Oct 30 15:37:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbWtT-0007BM-QM
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 15:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab3J3OhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 10:37:06 -0400
Received: from server90.greatnet.de ([83.133.96.186]:59781 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab3J3OhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 10:37:05 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 10:37:05 EDT
Received: from [10.1.12.84] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 5C0F1DD20D;
	Wed, 30 Oct 2013 15:30:25 +0100 (CET)
In-Reply-To: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.9 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237018>

Karl Wiberg <kha@treskal.com> wrote:

> With "gitk --first-parent", I get a graph that only follows the first
> parent of every merge---perfect if you always merge topic branches
> into the main branch. However, the diff shown is still the normal
> merge diff, and not the diff between the new tree and the first
> parent's tree---is it possible to make it do that instead?

I once posted a patch that adds a "First parent" checkbox to gitk's
window: <http://comments.gmane.org/gmane.comp.version-control.git/160920>

The patch no longer applies today, but I can send an updated version that
does, if there's interest.

The topic didn't go anywhere for two reasons:

1) There's the confusion about history traversal option (the existing
--first-parent command-line option) versus diff option (the new check
box); they have similar names, but control different things (and it
should be possible to control these independently).

2) Space is short in the diff pane; you need to make the window rather
wide to see them all.

I didn't have the energy to drive these to a resolution back then; if you
could do that, it would be great. Personally I'm using my own gitk with
my patch applied, and I do use the "First parent" checkbox rather often.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
