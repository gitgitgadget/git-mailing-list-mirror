From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH] gitweb: recognize six digit abbreviated SHA1
Date: Tue, 13 Jan 2009 01:08:52 +0100
Message-ID: <87mydw2hkb.fsf@cup.kalibalik.dk>
References: <87mydw2hrb.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 01:10:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWrR-0005yu-Lv
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbZAMAI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZAMAI4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:08:56 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:41493 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbZAMAIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:08:54 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 669B130B04;
	Tue, 13 Jan 2009 01:08:10 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 097BE308D0;
	Tue, 13 Jan 2009 01:08:10 +0100 (CET)
In-Reply-To: <87mydw2hrb.fsf@cup.kalibalik.dk> (Anders Melchiorsen's message of "Tue\, 13 Jan 2009 01\:04\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105421>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> +	if ($line =~ m/([0-9a-fA-F]{7,40})/) {

I could not make up my mind between the seven digits from "git
rev-parse --short" and the six digits currently used by gitk.

So I put one option in the patch, and the other one in the subject.


Cheers,
Anders.
