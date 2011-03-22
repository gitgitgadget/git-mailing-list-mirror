From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] Fix sparse warnings
Date: Tue, 22 Mar 2011 10:18:37 -0700
Message-ID: <7vwrjrkr9u.fsf@alter.siamese.dyndns.org>
References: <7vzkoop912.fsf@alter.siamese.dyndns.org>
 <1300780265-5698-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25EQ-0006dZ-Qe
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 18:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab1CVRSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 13:18:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab1CVRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 13:18:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 284B944DA;
	Tue, 22 Mar 2011 13:20:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=DOgIES
	yRKNAeRYxQe4DbCK4HLWC75mOFJjcQ7f74eHZotXv26aXQkPi8glA/QvcyWh30zd
	SfealidW+L+d05QitME18zRuu/+BEwiBF5dinKIg/IsHvQpzdrdBP9JEOwhvIjtz
	5FATu50ZYwKlPey5q8xHIotRy2QOYjcNS2YTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AqJPMvJ/f/10UnlRl/sM4x3iAZOzfWDF
	TKQwqbuJ++ct+wLw3vd5XZBi3aiqPw+5v8hKiBQuPT01f5aLrgMukGnRLkosGgxR
	hSgdLrMBxpMWA45yaua1VgiKJDfCLLF4neVmO76AJL0+zO6X9mUsiCoRPZ1P6aFy
	pnmzEZvfYfs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6C4444D6;
	Tue, 22 Mar 2011 13:20:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3E5544D1; Tue, 22 Mar 2011
 13:20:18 -0400 (EDT)
In-Reply-To: <1300780265-5698-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Tue, 22 Mar 2011 00:51:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACA19790-54A8-11E0-9640-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169749>

Thanks.
