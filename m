From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tag: Do not allow to call "git tag" in more than one
 operating mode
Date: Tue, 04 Nov 2008 14:47:40 -0800
Message-ID: <7vej1rqfar.fsf@gitster.siamese.dyndns.org>
References: <20081104124207.18273.31679.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 23:49:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxUhv-0001oe-OP
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 23:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYKDWry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 17:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbYKDWry
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 17:47:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbYKDWrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 17:47:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FEEA93985;
	Tue,  4 Nov 2008 17:47:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B220A93984; Tue, 
 4 Nov 2008 17:47:43 -0500 (EST)
In-Reply-To: <20081104124207.18273.31679.stgit@arrakis.enst.fr> (Samuel
 Tardieu's message of "Tue, 04 Nov 2008 13:42:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BDABD7A-AAC2-11DD-8E76-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100111>

Samuel Tardieu <sam@rfc1149.net> writes:

> If "git tag -d -l -v ..." is called, only "-l" is honored, which is
> arbitrary and wrong.
>
> This patch checks that "git tag" knows in what mode it operates before
> performing any operation.
>
> Signed-Off-By: Samuel Tardieu <sam@rfc1149.net>

s/-Off-B/off-b/;

I think this patch breaks "git tag -a" or "git tag -s", but I didn't try.
Run

	$ git tag -s

with and without your patch.
