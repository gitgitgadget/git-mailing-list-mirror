From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #03; Sun, 6)
Date: Sun, 06 Jan 2013 19:20:16 -0800
Message-ID: <7vehhxllvz.fsf@alter.siamese.dyndns.org>
References: <7vip79lnnb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 04:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts3GR-00006y-NG
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 04:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab3AGDUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 22:20:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab3AGDUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 22:20:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C126DBFCF;
	Sun,  6 Jan 2013 22:20:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoW9x3590glVderFV+W7pUv53UY=; b=fYTXn9
	4NpxxBwgjrnzOps6bx6MYK4oerFrOWwnsh9iIr0elU9vzmvc6r5V7hc12swLLkN6
	vfGsgLFWPxo0zcRt8h9zkePOZMqjcSs4ojDNgQfeWpqAbjErtgwnl2jefP5A/aPK
	nm8d80x3Bn2INjvgiA9eeAcqvxLSWfOi0j40w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NrXABYNKH9PrvcWWM/mIu3QuOcBKLK8y
	tgZMMhuBZGN1Q4kVPW8jryuHm4KQHEUF8VYpzmBdCv8jNFHLZw0b8evtk9hyGJZO
	Y/yUyaKgdfVo/gqxnJW3dN/84bhRLvlayI07yVDnTiTTbD/DXZ6Z5PhjPC7vh03G
	PC03KB2eDBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2282BFCE;
	Sun,  6 Jan 2013 22:20:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EBC8BFCD; Sun,  6 Jan 2013
 22:20:18 -0500 (EST)
In-Reply-To: <7vip79lnnb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Jan 2013 18:42:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2950DABE-5879-11E2-A2ED-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212870>

I forgot to say that tonight's 'pu' seems to break t0008 and does
not pass the self-test. I didn't try figuring out if this is the
result of some mismerge, or one (or more) of the topics are broken.
