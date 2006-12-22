From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] fix vc git
Date: Fri, 22 Dec 2006 13:39:00 +0100
Message-ID: <87ejqsumu3.fsf@wine.dyndns.org>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	<emdr6v$9ma$1@sea.gmane.org>
	<8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
	<7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
	<8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 14:04:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxk4P-00059A-1z
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 14:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWLVNEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 08:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbWLVNEO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 08:04:14 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:45748 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbWLVNEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 08:04:13 -0500
X-Greylist: delayed 1438 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 08:04:13 EST
Received: from adsl-84-226-45-154.adslplus.ch ([84.226.45.154] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gxjfz-00088q-0l; Fri, 22 Dec 2006 06:39:03 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id D1A554F672; Fri, 22 Dec 2006 13:39:00 +0100 (CET)
To: "Duncan Mak" <duncan@a-chinaman.com>
In-Reply-To: <8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com> (Duncan Mak's message of "Thu\, 21 Dec 2006 23\:11\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35172>

"Duncan Mak" <duncan@a-chinaman.com> writes:

> I don't think vc-git-registered-file will ever be called with a
> filename without a directory, as it is used as a hook on
> vc-next-action, which works on a real file.

Well, if it's a real file I'd expect the directory to exist, and if it
doesn't, I'm not sure there's much point in calling git-ls-files at
all. In which case do you get a non-existent directory here?

-- 
Alexandre Julliard
julliard@winehq.org
