From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 02 Dec 2007 15:05:04 -0800
Message-ID: <7v3auku28v.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
	<7vir3hx70y.fsf@gitster.siamese.dyndns.org>
	<20071202193918.GQ6212@lavos.net>
	<7vmyssvn55.fsf@gitster.siamese.dyndns.org>
	<fivdfu$smr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Gebetsroither <gebi@sbox.tugraz.at>
X-From: git-owner@vger.kernel.org Mon Dec 03 00:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyxsT-0005a9-An
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 00:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbXLBXFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 18:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXLBXFL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 18:05:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44376 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbXLBXFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 18:05:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 78FA62EF;
	Sun,  2 Dec 2007 18:05:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D4FD9C3FE;
	Sun,  2 Dec 2007 18:05:27 -0500 (EST)
In-Reply-To: <fivdfu$smr$1@ger.gmane.org> (Michael Gebetsroither's message of
	"Sun, 2 Dec 2007 23:59:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66833>

Michael Gebetsroither <gebi@sbox.tugraz.at> writes:

> Last hg2git from repo.or.cz does it (it uses git-fast-import).
>
> Just tried to convert lastes mercurial repos to git and the resulting
> git repos can't be displayed with gitk.
>
> author Mathieu Clabaut <mathieu.clabaut@gmail.com> <"Mathieu Clabaut
> <mathieu.clabaut@gmail.com>"> 1153937514 +0200
> committer Mathieu Clabaut <mathieu.clabaut@gmail.com> <"Mathieu Clabaut
> <mathieu.clabaut@gmail.com>"> 1153937514 +0200

That's totally broken author/committer information from a broken
hg2git, with what appears to be correct timestamps.
