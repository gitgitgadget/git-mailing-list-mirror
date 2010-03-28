From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: don't segfault when marks file cannot be 
 opened
Date: Sun, 28 Mar 2010 09:26:50 -0700
Message-ID: <7v7how5s51.fsf@alter.siamese.dyndns.org>
References: <1269754968-24961-1-git-send-email-srabbelier@gmail.com>
 <fabb9a1e1003272245gc1de70ar216997ca11bc2038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:27:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvKQ-000374-FZ
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab0C1Q1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:27:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab0C1Q1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:27:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BD51A67B0;
	Sun, 28 Mar 2010 12:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZH8TfYnNfYZsfmY0pjhlIP8OeRY=; b=mZuhed
	yQ9dUKz5gjzOAPonUZnzudO32Dakxi67dVSKapqdoqOcTI1jXSt+PeczT8Dketnw
	UQxe3lBq25OFb6TDuK3yCXKyBtW4yichILrnnxeZzlA8tcvorVtbGFzkPL4Uk5g5
	r4SYeA7tss/4LVDE0gGquEj+fm4ABQenk82NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uwKQH2d+nTpnodIBSpr/CGXI8M1hald8
	vkDs64iF4MIQtF+tZ1lacDFJFF9Y5JUFtXH9pvw1D5AIu42zP4CvFcUJ3ibnLMhg
	7tVg0pyC0soFHrYj7Cx+zwnmJbmXY3AzZbRs2MSONOEXoUc4Lq5SevSDp4QmKF8u
	0tDJGeQQRXM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 475ACA67AC;
	Sun, 28 Mar 2010 12:26:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07672A67A8; Sun, 28 Mar
 2010 12:26:51 -0400 (EDT)
In-Reply-To: <fabb9a1e1003272245gc1de70ar216997ca11bc2038@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 27 Mar 2010 23\:45\:18 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA4B0D5A-3A86-11DF-8D31-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143397>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heh, and of course I manage to mess up a 3-byte patch. The '.' removal
> shouldn't be there of course.

Will fix it up here.  Thanks.
