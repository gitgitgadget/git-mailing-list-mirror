From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 00/10] gitweb: 'blame' view improvements
Date: Fri, 24 Jul 2009 16:47:26 -0700
Message-ID: <7vskgl4p9t.fsf@alter.siamese.dyndns.org>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUUL-0001Zc-UK
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbZGXXrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbZGXXrh
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:47:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbZGXXrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:47:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CCF651238C;
	Fri, 24 Jul 2009 19:47:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CF0F112387; Fri,
 24 Jul 2009 19:47:28 -0400 (EDT)
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sat\, 25 Jul 2009 00\:44\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DA1CD2E-78AC-11DE-8689-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123980>

Jakub Narebski <jnareb@gmail.com> writes:

> This is second version of my improvements to gitweb's 'blame' view,
>   Subject: [PATCH 0/3] gitweb: 'blame' view improvements
>   Message-Id: <200907102354.43232.jnareb@gmail.com>
>   http://article.gmane.org/gmane.comp.version-control.git/123085
>
> including some further improvements, and this time including
> preparation and AJAX-y 'blame_incremental' view in series proper.
> It also finally creates 'blame_incremental' links (last patch in
> series).

I understand that this series replaces the four-patch series between
"git log --oneline a6be48b^..3643cc0"---am I correct?
