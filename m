From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/difftool: Don't repeat merge tool candidates
Date: Sat, 31 Jan 2009 17:35:53 -0800
Message-ID: <7vskmzym4m.fsf@gitster.siamese.dyndns.org>
References: <1233433676-21944-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Johannes Gilger <heipei@hackvalue.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRH7-0004Sp-T1
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbZBABgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZBABgD
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:36:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbZBABgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:36:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7C132A2F6;
	Sat, 31 Jan 2009 20:36:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E370D2A2F5; Sat,
 31 Jan 2009 20:35:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE72AF50-F000-11DD-B74F-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107966>

David Aguilar <davvid@gmail.com> writes:

> git difftool listed some candidates for mergetools twice, depending on
> the environment.
>
> This slightly changes the behavior when both KDE_FULL_SESSION and
> GNOME_DESKTOP_SESSION_ID are set at the same time; in such a case
> meld is used in favor of kdiff3 (the old code favored kdiff3 in such a
> case), but it should not matter in practice.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>
> Hi Junio
>
> This is based on top of Markus's kompare patch:
> 	"contrib/difftool: add support for Kompare"
> 	http://article.gmane.org/gmane.comp.version-control.git/107883

Ok, so I'll add "Acked-by: David Aguilar <davvid@gmail.com>" to Markus's
patch and apply it.

Thanks
