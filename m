From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: fix fread error handling
Date: Sat, 23 Mar 2013 23:50:56 -0700
Message-ID: <7vmwtt2svj.fsf@alter.siamese.dyndns.org>
References: <ba7cd71b0ac9a885bd894a0bed608cf682afed6d.1364058591.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 24 07:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJem8-0005MY-45
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 07:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3CXGu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 02:50:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3CXGu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 02:50:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D28198A19;
	Sun, 24 Mar 2013 02:50:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ELWlnv
	rW0QIlBJjXjnFZ399a9VGaY+o3ZNSyiNFUpgpuWeymE81s541cSQIFQBjPEervm9
	BRKzbSD1tmvWB3CCiYszkcSQAsYmgZWL9JIzTE0S+g/bw4O2oMjv03DtuEEoPfbv
	Glmc4R3gXFVAMAUmvUY+JNeXD7kS58Nre83lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zr5u6KF1ExowqY0qFh2CPza5+3HepX0d
	9hYgZrq9kIHVdxupH2TxHUuriIjSLYMre4i8LUvkb7XT/Y4Gn1Sp75ASgUMFwKu9
	0k2XIcsc1gcQJfaghlViB5H6BtAwbmpg+bnSl+ZLQubNxCfZ/4Mp+jBAyfpJlZbv
	ntGWEqhBwdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5BEE8A18;
	Sun, 24 Mar 2013 02:50:58 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A5C18A16; Sun, 24 Mar 2013
 02:50:58 -0400 (EDT)
In-Reply-To: <ba7cd71b0ac9a885bd894a0bed608cf682afed6d.1364058591.git.john@keeping.me.uk>
 (John Keeping's message of "Sat, 23 Mar 2013 17:16:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ECE0B3A-944F-11E2-8CD5-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218941>

Thanks.
