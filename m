From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix bug in insert_file() subroutine
Date: Mon, 08 Dec 2008 09:05:47 -0800
Message-ID: <7vr64i7g2c.fsf@gitster.siamese.dyndns.org>
References: <7vfxl5c66h.fsf@gitster.siamese.dyndns.org>
 <20081208130905.15803.83149.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tatsuki Sugiura <sugi@nemui.org>,
	Gerrit Pape <pape@smarden.org>, Recai Oktas <roktas@debian.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 18:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9jZq-00047w-TS
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 18:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbYLHRGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 12:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbYLHRGF
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 12:06:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbYLHRGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 12:06:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 204CE1864B;
	Mon,  8 Dec 2008 12:06:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 51D2E1864D; Mon, 
 8 Dec 2008 12:05:49 -0500 (EST)
In-Reply-To: <20081208130905.15803.83149.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Mon, 08 Dec 2008 14:13:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D495E0A-C54A-11DD-8280-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102562>

Jakub Narebski <jnareb@gmail.com> writes:

> +# ----------------------------------------------------------------------
> +# non-ASCII in README.html
> +
> +test_expect_success \
> +	'README.html with non-ASCII characters (utf-8)' \
> +	'echo "<b>UTF-8 example:</b><br />" > .git/README.html &&
> +	 cat "$TEST_DIRECTORY"/t3900/1-UTF-8.txt >> .git/README.html &&
> +	 gitweb_run "p=.git;a=summary"'
> +test_debug 'cat gitweb.log'
> +

Yup, a new test would certainly help to catch breakages ;-)

Thanks.
