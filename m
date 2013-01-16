From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Update HTTPD/daemon tests for new push.default
Date: Tue, 15 Jan 2013 18:39:07 -0800
Message-ID: <7v38y126no.fsf@alter.siamese.dyndns.org>
References: <cover.1358301792.git.brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIua-0008T2-2U
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab3APCjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:39:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757137Ab3APCjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:39:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FE3AB15;
	Tue, 15 Jan 2013 21:39:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4obJwsHmNJmPCQRu3XFco7pYne0=; b=G6zfgL
	xYT3MvHXydu287dPa5DCa6lQW3Z01X6NWBcqqRkvEI5hO3idM0jhm1bkrnU8UbRz
	Po08xY4M2P6ndTkHTjiJ0zUe9QIoz8CbsNC/jWGwD8XBToy25rPu/BOQKWB6PUcw
	IF75VlVusYR5o0kxeDegSW/S8qU+fKCEz9I70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vZrNjBGiuPgbYm6iec3DIcc+cn+9Go+N
	VWWHkvvNuRZ+w+PaC2C0pBBYgnkPOz9jQak0dSGybyTkTcp0fieLfm2W5H8ORaqC
	qPnRUh+kZNErrOoMKlo4Yi0kY/nq50/KZumXX6pBURhueReasWIVToL2w+4HspMD
	GsxEWkXLhas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DDB2AB14;
	Tue, 15 Jan 2013 21:39:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1485AB13; Tue, 15 Jan 2013
 21:39:08 -0500 (EST)
In-Reply-To: <cover.1358301792.git.brian@gernhardtsoftware.com> (Brian
 Gernhardt's message of "Tue, 15 Jan 2013 21:05:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7460982-5F85-11E2-AD8F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213718>

These are tests that I do not usually run myself.

Thanks for catching and correcting them.
