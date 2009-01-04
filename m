From: Junio C Hamano <gitster@pobox.com>
Subject: Re: JGit too strict?
Date: Sat, 03 Jan 2009 17:43:53 -0800
Message-ID: <7vhc4f4zhi.fsf@gitster.siamese.dyndns.org>
References: <200901040123.30392.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 02:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJI3X-0000Gi-CQ
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 02:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbZADBoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbZADBoE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 20:44:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZADBoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 20:44:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B76E8D041;
	Sat,  3 Jan 2009 20:43:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CD5DB8D040; Sat,
  3 Jan 2009 20:43:54 -0500 (EST)
In-Reply-To: <200901040123.30392.robin.rosenberg@dewire.com> (Robin
 Rosenberg's message of "Sun, 4 Jan 2009 01:23:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27A9BAB4-DA01-11DD-B238-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104490>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Is this repo corrupt or is jgit too strict? C Git doesn't complain.
>
> -- robin
>
> EGIT.contrib/jgit clone  git://github.com/pheew/dotgit DOTGIT
> Initialized empty Git repository in /home/me/SW/DOTGIT/.git                    

> Exception in thread "main" java.lang.Error: org.spearce.jgit.errors.CorruptObjectException: Object dd6cc50445808e64e032603e99723e04774a4e14 is corrupt: Invalid mode: 160000

Lack of support of submodules, I would guess.
