From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Sat, 14 Feb 2009 01:30:40 -0800
Message-ID: <7v63jdwekf.fsf@gitster.siamese.dyndns.org>
References: <200902122303.37499.jnareb@gmail.com>
 <200902130945.20601.jnareb@gmail.com>
 <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
 <200902140342.26270.jnareb@gmail.com>
 <cb7bb73a0902140052h15fa60bfs8a0becab84c997c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 10:32:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYGsi-0001iI-VB
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbZBNJau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZBNJat
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:30:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZBNJat (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:30:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1051799276;
	Sat, 14 Feb 2009 04:30:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 75E1D99275; Sat,
 14 Feb 2009 04:30:42 -0500 (EST)
In-Reply-To: <cb7bb73a0902140052h15fa60bfs8a0becab84c997c1@mail.gmail.com>
 (Giuseppe Bilotta's message of "Sat, 14 Feb 2009 09:52:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 298365A8-FA7A-11DD-AA21-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109849>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> For future reference for myself, is there a way to
> only run the gitweb tests of the testsuite?

cd t && sh ./t9500-gitweb-standalone-no-errors.sh [-i] [-v]

> Thank you for the additional patch. One thing we should also probably
> add to the test is the HTTP_IF_MODIFIED_SINCE. I will try to think of
> a bunch of tests to run against feed production after I implement the
> reflog data check.

Thanks.
