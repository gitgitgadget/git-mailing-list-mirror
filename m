From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: never skip files included in index
Date: Sun, 11 Oct 2009 11:52:10 -0700
Message-ID: <7viqelwyp1.fsf@alter.siamese.dyndns.org>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pauli Virtanen <pav@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3cq-0003e8-0U
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbZJKSxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 14:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbZJKSxC
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:53:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZJKSxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 14:53:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32E9273601;
	Sun, 11 Oct 2009 14:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vL8daIBWkQRliM/SC+DdXL731ug=; b=YvgPGZjXELcGqb64R/S0piM
	T1ZuH8fRN58h/PshbttRRJjIPs2SBxba1Gq266QOtvLAedoYSiVrNLvE4vWxZD+R
	osWPocB+FKGAHlVB5GzUdNTsdVU9OyZzdLJiCg6siV/iDoLWo/1zlleG17oQxgnd
	xtaDtQ52VYN2vt2zTR/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Qd9i4NE+zHOZSoz94SgKeRPZ4LpnQxNhxMp6P7svVoNOIIO+8
	odp+OpW9JJk9/HHTylF4ty+GdkJa8OcuS5T+zyUHDMUNGbMnk9iXuS4ZA/iCEGdz
	d8oG9DkvBX/x4ekMXlTGrsXJ56oCISSiPuO6CdGEkxzXSMaX+wKfMx8q64=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1664673600;
	Sun, 11 Oct 2009 14:52:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 32995735FF; Sun, 11 Oct 2009
 14:52:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31432966-B697-11DE-B3AE-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129945>

Thanks.

The change looks innocent enough and I do not expect to see any unexpected
regressions from it, but it is a bit too late for 1.6.5 cycle, so let's
queue this fix and aim for 1.6.5.1.
