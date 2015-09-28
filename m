From: "George Spelvin" <linux@horizon.com>
Subject: Re: Why not git reset --hard <path>?
Date: 28 Sep 2015 18:36:07 -0400
Message-ID: <20150928223607.15594.qmail@ns.horizon.com>
References: <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com, tytso@mit.edu
To: gitster@pobox.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Sep 29 00:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgh1q-0003jc-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbI1WgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:36:11 -0400
Received: from ns.horizon.com ([71.41.210.147]:39196 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752930AbbI1WgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:36:10 -0400
Received: (qmail 15595 invoked by uid 1000); 28 Sep 2015 18:36:07 -0400
In-Reply-To: <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278799>

Junio C Hamano <gitster@pobox.com> wrote:
> "git checkout HEAD <pathspec>" is a 99% acceptable substitute for it
> (the only case where it makes a difference is when you added a path to
> the index that did not exist in HEAD).

Er, wait a minute...

"git checkout <tree-ish> <pathspec>" modifies the index?

Damn, I've been using git for years and I never knew that.
I thought it only modified the working tree.

But I just tested, and it does.  Damn, now I have to figure out
how to "leapfrog" a file from history into the working tree without
overwriting the index; that's occasionally useful.
