From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a
 bit
Date: Mon, 13 Apr 2009 23:46:23 -0700
Message-ID: <7vfxgb91hc.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904131542q7354fa05wb763f70e4baf9abb@mail.gmail.com>
 <7vfxgbaj5s.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904132300m391ac4ffn6a41ecc5cdcb6ed8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtcRA-0004aA-7M
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZDNGqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 02:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbZDNGqb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:46:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZDNGqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 02:46:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81BA2AA75B;
	Tue, 14 Apr 2009 02:46:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 740FBAA75A; Tue,
 14 Apr 2009 02:46:25 -0400 (EDT)
In-Reply-To: <b4087cc50904132300m391ac4ffn6a41ecc5cdcb6ed8@mail.gmail.com>
 (Michael Witten's message of "Tue, 14 Apr 2009 01:00:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB2443FC-28BF-11DE-833C-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116523>

Michael Witten <mfwitten@gmail.com> writes:

> The usage text for --smtp-server currently has <host:port>, which
> doesn't work when 'ssl' is used for the connection to the server.

Ah, I see.  But it does work when ssl is not used, right?  A possible
solution would be one of:

 - support host:port in SSL codepath (shouldn't it be trivial?);

 - split the description in the documentation to clarify it does not work
   for SSL; or

 - remove host:port support to make both consistent.

To me, the last one makes the least sense.  Is that the approach you are
taking?
