From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/18] revert: Save command-line options for continuing
 operation
Date: Wed, 27 Jul 2011 15:51:53 -0700
Message-ID: <7vr55bmj5i.fsf@alter.siamese.dyndns.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 00:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmCxM-0000SS-UZ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 00:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1G0Wv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 18:51:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab1G0Wvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 18:51:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B5446AD;
	Wed, 27 Jul 2011 18:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=G6WgeDTysgrIwzM1L50e/Z/2oMk=; b=fgWrLpg5zlaOYtXmC4s6
	FdiZRhOCN2CB466b3r5ocoQ8RE2XHXvOcnj1YgFu9WIKuS5qTJLkVGirkWuekJ09
	k/t2cL468258sPwCZ5rX6cfmiESDhOS+Byd/RnM1YSIDHAttHi6aGai7GTL+x18S
	rap2irEIEo3LEOGgJYl+fno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mIcfY/NNEksyPPTQ46Goax5nMD6OFrNlOj/ChV18eFceqv
	zk8upwXNKCIbA1YfOUMGINxMJbgL+wXIzHiWhPTuDYIqWl765DTvJPHm6+Z8egig
	u9924VA3HJiCs1/5eT3UJgnnbuXxYjU3m9xf2TEFM3bfgh/llkYA3n6/+o3DM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9C846AC;
	Wed, 27 Jul 2011 18:51:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FE4146AB; Wed, 27 Jul 2011
 18:51:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0646788E-B8A3-11E0-9DE4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178001>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +	if (opts->xopts) {
> +		for (i = 0; i < opts->xopts_nr; i ++)

(style) s/i ++/i++/;
