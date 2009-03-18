From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --exec-path not always honored
Date: Tue, 17 Mar 2009 22:41:34 -0700
Message-ID: <7v7i2nmlpt.fsf@gitster.siamese.dyndns.org>
References: <49BF692B.9020002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 06:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjoYu-0001ZR-8k
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbZCRFlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 01:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbZCRFll
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:41:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbZCRFlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 01:41:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1891DA2E54;
	Wed, 18 Mar 2009 01:41:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B8A2A2E53; Wed,
 18 Mar 2009 01:41:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 73B5F8E8-137F-11DE-AB5F-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113579>

Johannes Sixt <j.sixt@viscovery.net> writes:

> git-gc is a builtin. Should git setenv("GIT_EXEC_PATH") before it runs
> other git commands?

I think we just never have bothered about such a use case, but you are
right.  It probably is a good solution, although setenv makes me feel a
bit nervous for no rational reason.
