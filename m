From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 04/12] send-email: Verification for --smtp-server
 and --smpt-server-port
Date: Sun, 19 Apr 2009 18:42:06 -0700
Message-ID: <7vzlecnlsh.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 03:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LviYB-0000cG-AC
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 03:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZDTBmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZDTBmP
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 21:42:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbZDTBmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 21:42:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 21ADA10E15;
	Sun, 19 Apr 2009 21:42:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1433A10E0E; Sun,
 19 Apr 2009 21:42:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77F937F8-2D4C-11DE-B166-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116923>

Michael Witten <mfwitten@gmail.com> writes:

> The server URI is verified according to RFCs (including IPv6 support).
>
> The $smtp_server and $smtp_server_port setup code has been moved
> higher in the file, so that send-email fails fast if they are bad.
>
> Now, the 'host:port' server URI form is handled regardless of the
> documentation deficiencies of Net::SMTP{,::SSL}.

You said that in 01/12, too but I do not think there is any problem with
Perl documentation.

My installed copy of /usr/share/perl/5.10.0/Net/SMTP.pm has this:

    B<Host> - SMTP host to connect to. It may be a single scalar, as defined for
    the C<PeerAddr> option in L<IO::Socket::INET>, or a reference to
    an array with hosts to try in turn. The L</host> method will return the value
    which was used to connect to the host.

and of course PeerAddr allows host:port.

Please stop placing a false blame on others.  I think it is you who lack
ability to read the documentation correctly in this particular case.
