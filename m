From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resend: [PATCH] Do not log unless all connect() attempts fail
Date: Tue, 12 Jul 2011 09:09:37 -0700
Message-ID: <7v39iba3b2.fsf@alter.siamese.dyndns.org>
References: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 18:09:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgfWs-0003Ev-AX
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 18:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab1GLQJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 12:09:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1GLQJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 12:09:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E8E15B55;
	Tue, 12 Jul 2011 12:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6bbbeqU3spHN1HHwEtFb7TkdFQY=; b=aVYWd4
	QHp0Rqcb2pzf71ZpIJ6MFUN9VQAJGQibPkUKZ7omT4stfBibardJr4NfrbzuTI2M
	J1ekTiOT85FTpNRL0UK151Tv9Y/V0aGgtLFlRUsEj/769MDAEgDONQf+8j7IyKHx
	7LBk8aXV72YEIE/EuDWap3Dg8XHhS2/7IVAKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELY5AsZ1qA9SFtNT8vBR94zObDTLmCe1
	X6ozCQJWUFu/CMrcyJI6/tbqgH5KEahIfhZTqlDMRppzFm6JfTiwsrb2H+oMdOqF
	Bph4+3FYD2yfbP6Td3uis11+ns7YlVwR7b08iMfaNlxljuGHl0FHRaVmohjfladw
	Hi+4wNNh7p0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 025885B54;
	Tue, 12 Jul 2011 12:09:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 662685B53; Tue, 12 Jul 2011
 12:09:39 -0400 (EDT)
In-Reply-To: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com> (Dave
 Zarzycki's message of "Mon, 11 Jul 2011 11:06:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 586B7AA0-ACA1-11E0-BD6C-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176945>

This looks Looks good to me; could you sign-off the patch, please?

Thanks.
