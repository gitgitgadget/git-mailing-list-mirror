From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/5] t6050-replace: test that objects are of the same
 type
Date: Sun, 25 Aug 2013 22:06:11 +0200
Message-ID: <521A63B3.6040004@kdbg.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org> <20130825130609.4681.58306.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Aug 25 22:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDgZx-0003ne-Qz
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 22:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab3HYUGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 16:06:17 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:46401 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756671Ab3HYUGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 16:06:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1B22413005C;
	Sun, 25 Aug 2013 22:06:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 905BA19F623;
	Sun, 25 Aug 2013 22:06:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20130825130609.4681.58306.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232965>

Am 25.08.2013 15:06, schrieb Christian Couder:
> +test_expect_success 'replaced and replacement objects must be of the same type' '
> +	test_must_fail git replace mytag $HASH1 2>err &&
> +	grep "Object ref '\''mytag'\'' is of type '\''tag'\''" err &&

Uh, this hurts in the eye! Please write this as

	grep "Object ref .mytag. is of type .tag" err &&

-- Hannes
