From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] cvsimport: miscellaneous packed-ref fixes
Date: Wed, 28 Nov 2007 16:52:28 -0800
Message-ID: <7vsl2pzxdf.fsf@gitster.siamese.dyndns.org>
References: <20071128185504.GA11236@coredump.intra.peff.net>
	<20071128185628.GC11320@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXeF-0005Ki-0V
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758199AbXK2Awj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755777AbXK2Awj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:52:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55852 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbXK2Awi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:52:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8A97E2F0;
	Wed, 28 Nov 2007 19:52:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C23A89AA80;
	Wed, 28 Nov 2007 19:52:51 -0500 (EST)
In-Reply-To: <20071128185628.GC11320@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 13:56:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66480>

Jeff King <peff@peff.net> writes:

> @@ -998,7 +996,7 @@ if ($orig_branch) {
>  	$orig_branch = "master";
>  	print "DONE; creating $orig_branch branch\n" if $opt_v;
>  	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
> -		unless -f "$git_dir/refs/heads/master";
> +		defined get_headref('refs/heads/master');

Where did the unless go ;-)?

Thanks, queued.
