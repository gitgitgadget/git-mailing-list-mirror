From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] remote.c: don't short-circuit match_refs() when
 error in match_explicit_refs()
Date: Mon, 23 Feb 2009 17:34:48 -0800
Message-ID: <7vhc2kpqh3.fsf@gitster.siamese.dyndns.org>
References: <cover.1235368324.git.jaysoffian@gmail.com>
 <6cbc71876488bd7e14db40560459c0e1b8ae7b37.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmDj-0001jz-BZ
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbZBXBe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbZBXBe4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:34:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZBXBe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:34:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D6669CE48;
	Mon, 23 Feb 2009 20:34:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09D029CE47; Mon,
 23 Feb 2009 20:34:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5634CD94-0213-11DE-A3FF-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111191>

The same comment as 10/13 applies here.
