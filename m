From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 00/11] rev-list/log: document logic with several
 limiting options
Date: Fri, 14 Sep 2012 10:25:04 -0700
Message-ID: <7vehm45xfz.fsf@alter.siamese.dyndns.org>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
 <cover.1347615361.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:25:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZdm-0004N6-9b
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438Ab2INRZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:25:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab2INRZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4C88E75;
	Fri, 14 Sep 2012 13:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GeAQLBq5qSuHgk/2CHiUKJU99mM=; b=EKIQ5n
	VF8AAmZoCO3yL/LVENQLc99jd+eRY9ovoWdQ5Oz33ZElZLYXN2DRB/QceCNyIY04
	1Lf4P6584BWJy7OZXZGVzLVpdRd0ubSEmEE0+rZ6m/o9AYti8gGQ/AW39ia/YCqz
	+Hz/vz0OKI9+lnMCPRkx52gBT0L7mssBHJLHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0WnixtK6nnJmiDadyWUZTqtHoK8Wufc
	bOeCiRP41ZER0PzbS0epL0eRHqq0NGpVN0AhkIzaYmDYeDwizrLHEoe1E8JiQ5SP
	MXC0gnJK5Ul6GVjdl5Ci9PzHKuILmc4RcewBmUasidZnoMeTDpB7nS3KiMP/z7uQ
	JxncZbUR+gs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB7878E74;
	Fri, 14 Sep 2012 13:25:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56FE58E71; Fri, 14 Sep 2012
 13:25:05 -0400 (EDT)
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Fri, 14 Sep 2012 11:46:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FB76280-FE91-11E1-A83D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205511>

Thanks for an update.  Queued with minimum modification.
