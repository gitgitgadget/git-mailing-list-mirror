From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-ls-files.txt: clarify what "other files" mean for
 --other
Date: Thu, 06 Aug 2009 13:44:40 -0700
Message-ID: <7vmy6cfz9j.fsf@alter.siamese.dyndns.org>
References: <1249571508-21897-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:44:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9pZ-0007sI-R1
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbZHFUos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbZHFUos
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:44:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZHFUos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 16:44:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7BBE01FB06;
	Thu,  6 Aug 2009 16:44:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 35C7F1FB01; Thu,  6 Aug 2009
 16:44:41 -0400 (EDT)
In-Reply-To: <1249571508-21897-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu\,  6 Aug 2009 17\:11\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB5A9A06-82C9-11DE-B946-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125124>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Actually, if it was not about backward compatibility, I'd just replace
> -o, --other with -u, --untracked and talk about "untracked" everywhere,
> but compatibility matters more than consistancy for plumbing.

"ls-files -u" talks about (u)nmerged files.  What consistency did you have
in mind?
