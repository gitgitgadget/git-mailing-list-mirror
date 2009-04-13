From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and
 spaces
Date: Mon, 13 Apr 2009 13:55:58 -0700
Message-ID: <7vab6ke0ip.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 22:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtTDm-00023e-Gk
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 22:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZDMU4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 16:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZDMU4F
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 16:56:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZDMU4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 16:56:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26AC9ED77;
	Mon, 13 Apr 2009 16:56:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8E0A1ED76; Mon,
 13 Apr 2009 16:55:59 -0400 (EDT)
In-Reply-To: <1239647037-15381-10-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Mon, 13 Apr 2009 13:23:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7F63DA86-286D-11DE-BE4C-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116485>

Michael Witten <mfwitten@gmail.com> writes:

> Currently, no lines match the following:
>
>     [\t]+[ ]+
>     [ ]+[\t]+

I understand the latter but what's wrong with the former?  The width of a
HT is by definition 8 columns throughout the git codebase.
