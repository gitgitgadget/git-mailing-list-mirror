From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix sizeof usage in get_permutations
Date: Thu, 13 Dec 2012 11:11:47 -0800
Message-ID: <7vtxrpydfw.fsf@alter.siamese.dyndns.org>
References: <1355405790-20302-1-git-send-email-mattjd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Daley <mattjd@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 20:12:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjECV-0005JC-SO
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 20:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab2LMTLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 14:11:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab2LMTLu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 14:11:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213B9AE24;
	Thu, 13 Dec 2012 14:11:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JF2InTIM1wwGOL5C9xgKfRaQEL0=; b=ryAH4m
	O/8UU8PzgjzaU4aX0sogv0Y+xJDrnsQmugIoqf3HbPEDm7vjPktxJ/eAm1sAP/Bn
	WnB364zS3ApTmdOW18pc0G3y1s05hCZUvlaCo4uvUBZkrd6D0JtBnYsksq6sG3Q6
	45dBh4n6haj5jAoNeZbFjt/Ita+8ab0Z5OLC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z9Ze4v44ce9JCrdOlqepvZdp/3DToEJR
	YltH3sbkJmZ8JrqyQbAJ/fsgH3z1xt/B6MOkKhubQgy58nmSkq6BLDHdyKtFVEtM
	JpZgRSeuGehJdkLpGRMpKSafRU7z8TDQsMIcnel0D8iD4O4lJ4NjoaUMmnHbmNp1
	/0ZlrVkUEhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FACFAE23;
	Thu, 13 Dec 2012 14:11:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85DC2AE1F; Thu, 13 Dec 2012
 14:11:49 -0500 (EST)
In-Reply-To: <1355405790-20302-1-git-send-email-mattjd@gmail.com> (Matthew
 Daley's message of "Fri, 14 Dec 2012 02:36:30 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F216CC08-4558-11E2-B764-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211468>

Thanks; it shows how rarely this obscure tool is used these days.
