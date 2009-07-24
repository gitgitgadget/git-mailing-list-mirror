From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Fri, 24 Jul 2009 08:24:40 -0700
Message-ID: <7vmy6uqf2f.fsf@alter.siamese.dyndns.org>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
 <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de> <7v8wievf20.fsf@alter.siamese.dyndns.org> <20090724053506.GB12855@atjola.homenet> <alpine.DEB.1.00.0907241136081.19988@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUMdm-0000cs-9F
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 17:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbZGXPYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbZGXPYs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 11:24:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbZGXPYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 11:24:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84C6912319;
	Fri, 24 Jul 2009 11:24:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9A9A12316; Fri,
 24 Jul 2009 11:24:41 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0907241136081.19988@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri\, 24 Jul 2009 11\:37\:38 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E236072-7866-11DE-ADB8-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123921>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Right.  How about a comment above the if():
>
> 		/*
> 		 * If nr_parent is negative, the commit is shallow, and
> 		 * we must not traverse its real parents.
> 		 */

That's much better.
