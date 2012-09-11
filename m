From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: git branch --set-upstream-to=
Date: Tue, 11 Sep 2012 10:13:21 -0700
Message-ID: <7v627kiitq.fsf@alter.siamese.dyndns.org>
References: <bd9d638e84e7e142e94b71213bed2126ea1f1951.1347364675.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 19:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBU1m-0001me-2O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 19:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759704Ab2IKRNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 13:13:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758810Ab2IKRNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 13:13:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E43CC82AC;
	Tue, 11 Sep 2012 13:13:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pPkdYdYbWYgjH4tvp9YTqbo4Sgs=; b=HbFRkJ
	8gs4dYxNfU7YLM0jqZFhvaV90vDczwW5enLbb4xaKmYf5N4UxE8gEiutTUIOEPoa
	/EXe5OLcoMdpx50TGOJ1kqnOs4pthx377n/jeALGPQTi5Pd/Gpaj6NKiiGnp0dHF
	7+MacthagQudc/2pZ+rBaEoBX0bHucRpp47gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kr4x4D1nEHR3BTLQrmtqRiJjwrRso5f4
	3H2FhKTtuSHfRgMjjhy1X/i989jPvq1uY/l2Fpub/6QjxAheawC6zYcs5Ta+k5iM
	f9I1Eirn6DvV5X/g9sfvimbTzQddFUD3BsWgIqtur03ihq7FWVd2hGdCamWT1xvA
	JavmuQ8SCsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D29E182AB;
	Tue, 11 Sep 2012 13:13:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5244182A9; Tue, 11 Sep 2012
 13:13:23 -0400 (EDT)
In-Reply-To: <bd9d638e84e7e142e94b71213bed2126ea1f1951.1347364675.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 11 Sep 2012 13:58:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE0A52F0-FC33-11E1-8433-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205252>

Thanks; I picked up $gmane/204633 but forgot to queue.
