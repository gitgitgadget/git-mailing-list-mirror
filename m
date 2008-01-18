From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] send-email: validate patches before sending anything
Date: Fri, 18 Jan 2008 16:09:19 +0100
Message-ID: <4790C11F.8010809@viscovery.net>
References: <20080118141638.GA14928@coredump.intra.peff.net> <20080118141948.GB19783@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFsqu-0004BC-8F
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 16:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773AbYARPJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757504AbYARPJX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 10:09:23 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33917 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291AbYARPJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 10:09:22 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFsqH-0000bi-AZ; Fri, 18 Jan 2008 16:09:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7E89569F; Fri, 18 Jan 2008 16:09:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080118141948.GB19783@coredump.intra.peff.net>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71026>

Jeff King schrieb:
> +sub validate_patch {
> +	my $fn = shift;
> +	open(my $fh, '<', $fn)
> +		or die "unable to open $fn: $!\n";
> +	while (my $line = <$fh>) {
> +		if (length($line) > 998) {
> +			return "patch contains line longer than 998 characters";

"... contains line_s_ longer than..."

-- Hannes
