From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git gc and kernel.org
Date: Wed, 21 Oct 2009 08:25:02 +0200
Message-ID: <4ADEA93E.7060907@viscovery.net>
References: <4ADD6026.8070203@zytor.com> <7veioyqzeo.fsf@alter.siamese.dyndns.org> <200910201054.48315.johan@herland.net> <alpine.LFD.2.00.0910201442480.21460@xanadu.home> <7v63a9n5i6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 08:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0UdP-0007SD-QL
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 08:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbZJUGZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 02:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbZJUGZE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 02:25:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18312 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZJUGZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 02:25:03 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N0Ud4-0005hU-OZ; Wed, 21 Oct 2009 08:25:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 727F46D9; Wed, 21 Oct 2009 08:25:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v63a9n5i6.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130886>

Junio C Hamano schrieb:
> +		if (auto_gc) {
> +			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
> +			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);

Am I correct that this will produce progress output? If git-daemon runs
receive-pack, then this output will go to the syslog. Do we care?

-- Hannes
