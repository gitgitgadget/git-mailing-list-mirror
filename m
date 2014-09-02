From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/3] stylefix: pointers bind to the variable, not the type
Date: Tue, 02 Sep 2014 11:33:00 -0700
Message-ID: <xmqqmwah27qb.fsf@gitster.dls.corp.google.com>
References: <1409515893-48017-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOsuX-0004RF-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbaIBSe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 14:34:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54886 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbaIBSe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 14:34:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C4D536D99;
	Tue,  2 Sep 2014 14:34:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=TN5vMl
	J3RxUxfN1WcwcM3Mcso7zKKykiOCYy4LNSqcPskVKCCnSDkSeBhRB4XGdI7PURnL
	rCrv3CkCKuCOIFedGZRMvbA2Vyoc0FZ0s8TwSiIYI65a3rVwV2biqDjsA6BK+JYO
	Gbrlt6YS2sdrprC6VFH3BFl2OsgCRQ3Zl3deQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1GxYMsalEwCoLEjiccdTmePvVi1HXog
	QvnzUm6HT6iK9gdYELJBHxoRerTu3aVwC2yhOntiAIf6oMZ9W3gRFZrlP7LUxnpj
	uULSN54ub8LIvBI+Ftn9KL+pjIyGnEMyD31B5xSHYOhdwKx4M4q9mqf1zOH257eZ
	x8NbS4YSxQc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9105636D98;
	Tue,  2 Sep 2014 14:34:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 40E8136CF0;
	Tue,  2 Sep 2014 14:33:02 -0400 (EDT)
In-Reply-To: <1409515893-48017-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 31 Aug 2014 13:11:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 925780A8-32CF-11E4-8330-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256333>

Thanks.
