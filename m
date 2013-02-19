From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 19 Feb 2013 11:03:38 +0100
Message-ID: <87ip5otybp.fsf@pctrast.inf.ethz.ch>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7k3V-0003wT-8O
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247Ab3BSKDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:03:44 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:40736 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757087Ab3BSKDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:03:43 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 11:03:36 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Feb 2013 11:03:39 +0100
In-Reply-To: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 14:55:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216590>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I have this itch where I want to share my remotes config between
> machines.  In my fork, I should be able to specify where my upstream
> sources are, so remotes get set up automatically when I clone.

Note that you need to carefully pick only certain bits of the config, as
otherwise there are big security headaches.

> There are also other things in .git/config that would be nice to
> share, like whether to do a --word-diff (why isn't it a configuration
> variable yet?)

Because that would break pretty much every script that uses git-diff?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
