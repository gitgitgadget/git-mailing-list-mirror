From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9 v2] completion: optimize refs completion
Date: Sat, 15 Oct 2011 20:29:42 -0700
Message-ID: <7vzkh1semw.fsf@alter.siamese.dyndns.org>
References: <20111014121609.GB2208@goldbirke>
 <1318683443-1896-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Oct 16 07:13:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFJ2D-0002mg-V6
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab1JPFNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 01:13:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab1JPFNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 01:13:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294EB2B10;
	Sun, 16 Oct 2011 01:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=hS7vhTj8uPBeyjZYFJGby0wCKew=; b=CsHSXVQEbCBf2iJNoCkI
	rtJk9wLZP2lq62AxKp+juJrE+sVpINnS4Bgo4srlptYZzkrlt6TfV6aiITATndIJ
	PnFJM9YbD26yzpfD0rUiVvhA9ABcaqSvt0EsXYwBL1mwtqKTWyjrwPDhMtfwxb0b
	03DXXFVZ5WcF0DSEiC8/fds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YCzKUKqyWDaUXTbGvGutDGH8Hf1QrqLMBhw93KuGUMOnN2
	5VPSL/hp5e3VC9y7GSGiktW0RyOzf7YtAzNiEz6L54Hi42IP11DhpjnMYk939dfw
	uQyqp6+hND55Zicmgg1kI/P0WwYJWtL5EobJdZAaiDl9vkGq+M5uLidC3XKjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB9E2B0F;
	Sun, 16 Oct 2011 01:13:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5A762B0E; Sun, 16 Oct 2011
 01:13:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BC05D8A-F7B5-11E0-92EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183691>

Thanks; will replace the corresponding patch in the topic branch and
rebuild.
