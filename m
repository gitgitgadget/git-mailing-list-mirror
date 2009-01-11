From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 14:23:26 -0800
Message-ID: <7vab9xpjmp.fsf@gitster.siamese.dyndns.org>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
 <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
 <86iqol8wql.fsf@broadpark.no>
 <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de>
 <86eiz98v0s.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8jp-0004to-WD
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZAKWXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbZAKWXe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:23:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZAKWXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:23:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 779998F104;
	Sun, 11 Jan 2009 17:23:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 814838F0FF; Sun,
 11 Jan 2009 17:23:28 -0500 (EST)
In-Reply-To: <86eiz98v0s.fsf@broadpark.no> (Kjetil Barvik's message of "Sun,
 11 Jan 2009 21:09:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AD343DA-E02E-11DD-8E53-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105239>

Kjetil Barvik <barvik@broadpark.no> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> <snipp>
>> My question was more: why do you do additional work and put a git diff 
>> --raw between the commit message and the diffstat when that information is 
>> in the patch already?
>
>  Ok, I see.  I (re)used the 'git format-patch' command from previous
>  run, and this time it was (without the line-breaks):
>
>     git format-patch  --stat  --patch-with-raw -1 --signoff -M -C
>        --summary --full-index --subject-prefix="PATCH"
>        --output-directory ../diff_lib_c_symcache_cleanup_v1/

Please drop --patch-with-raw and --full-index.  They are distracting.

I do not think using --subject-prefix=PATCH to repeat what is default adds
any value either.
