From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: small improvements to user-preservation
Date: Sun, 08 May 2011 21:50:29 -0700
Message-ID: <7vk4e0qxyi.fsf@alter.siamese.dyndns.org>
References: <1304763583-17425-1-git-send-email-luke@diamand.org>
 <1304763583-17425-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon May 09 06:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJIQs-0000CA-67
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 06:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab1EIEuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 00:50:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab1EIEuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 00:50:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5ABE85C8B;
	Mon,  9 May 2011 00:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zNnRLCNFyXRRhfTJx+o8oQEFm+0=; b=g+JmCm
	l46aIGXLTtP06dL0WcZXQF7TgWFZ3jzNc6ntl/NwpmH3GrPMkoPeEYxq8blUE6PI
	n0BAapKcGxHEn0LAsoVI3wrjjfWcL8/LsEKePNhrSXE24b8iq9qHFEsZmFLdj6dy
	1FyyI9s05SDYxC7hQxV1xE1s6o6IidiUKVSEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWZOglQQwrxfCDG3ZABPhioWx/VNuTkD
	ujQdls9BydRcknQ6cBCtTlZz7O5OXmHxVWPb87/awYx7h7Muh7q23IfVQV2xjcoO
	YNT0RtA/oblPoTNIJ+wps1EY+V/mhdI+GztgZ0pXuzZWrB0JaG2ZpnhgQo56zvTQ
	n1K0TSjNRDM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2666E5C89;
	Mon,  9 May 2011 00:52:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1685C5C88; Mon,  9 May 2011
 00:52:36 -0400 (EDT)
In-Reply-To: <1304763583-17425-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Sat, 7 May 2011 11:19:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B8F34F8-79F8-11E0-9A64-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173194>

Luke Diamand <luke@diamand.org> writes:

> . Slightly more paranoid checking of results from 'p4 change'
> . Remove superfluous "-G"
> . Don't modify the username if it is unchanged.
> . Add a comment in the change template to show what is
>   going to be done.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>

Thanks.

The patch text was different from the interdiff between the previous two
patches that got Ack from Pete, so I didn't realize this was your
incremental conversion until now. Will queue this one on 'pu' but I'd like
an Ack from Pete or other git-p4 folks before merging this down to 'next'.
