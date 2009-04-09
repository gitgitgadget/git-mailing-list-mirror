From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] archive: add shortcuts for --format and --prefix
Date: Thu, 09 Apr 2009 01:47:49 -0700
Message-ID: <7v8wma43ii.fsf@gitster.siamese.dyndns.org>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpxX-0003dR-I6
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761448AbZDIIsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761592AbZDIIsd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:48:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761326AbZDIIs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:48:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2480EA9A21;
	Thu,  9 Apr 2009 04:48:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7896DA9A1E; Thu,
  9 Apr 2009 04:48:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31E91812-24E3-11DE-8D94-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116153>

Is this really necessary?

I see little benefit from giving either of these a shorter alternative,
and a huge downside for potential confusion, especially because nobody
else uses -p for --prefix, and other commands use -p for something
completely different.

The same deal for -f, but it is probably worse because it is typically
used for --force.
