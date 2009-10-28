From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] remote-helpers: return successfully if everything
 up-to-date
Date: Wed, 28 Oct 2009 00:18:45 -0700
Message-ID: <7vtyxkrnoq.fsf@alter.siamese.dyndns.org>
References: <1256472380-924-1-git-send-email-drizzd@aon.at>
 <1256472380-924-2-git-send-email-drizzd@aon.at>
 <1256472380-924-3-git-send-email-drizzd@aon.at>
 <20091028001125.GM10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, Mark Lodato <lodatom@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32oA-000896-2U
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbZJ1HSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbZJ1HSv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534AbZJ1HSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A76AF69DE6;
	Wed, 28 Oct 2009 03:18:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=xtCEuFfKjGWht2c0mBAVBoT
	1Mq1SyhQhNOeRJVIMa+jwFsGshFT4/eY3xJyfzgXG0UnTuCFlxxsRHwx0rHVnDRm
	7ZQckrwQ/jWEpd4Cv+A9ZCU9CJJTUeIqQLWbGLUkFpHZoElrY72b4Ab2hk1BFUCO
	LbRYyAWL4n/f+yIb8Xrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dxGS77hhBzrYdEBQG2pApEdv1k9IJ5cSubN0x45RMB5Q0YYAJ
	UdZLUEne0McsaBxGfrtalyiGOyspMJkwyA/LBK3TSfVPl8KLp99OVs/Tvj+cFza6
	R0KnbAClke0Jt7Cc+nUjyT/++iukxjD+X/S13oHAOzLs0lQAoWTXFbk/6w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7189E69DE1;
	Wed, 28 Oct 2009 03:18:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A789569DE0; Wed, 28 Oct
 2009 03:18:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24997C62-C392-11DE-AABE-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131423>

Thanks.
