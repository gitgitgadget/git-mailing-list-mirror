From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reword -M, when in `git log`s documention, to suggest
 --follow
Date: Sat, 02 Jan 2010 10:43:51 -0800
Message-ID: <7v1vi8e49k.fsf@alter.siamese.dyndns.org>
References: <1261428059-31286-1-git-send-email-alex@chmrr.net>
 <7vhbr6phlx.fsf@alter.siamese.dyndns.org> <1262412622-sup-7473@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Jan 02 19:44:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR8xM-0002rr-Kx
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 19:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab0ABSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 13:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298Ab0ABSoA
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 13:44:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0ABSn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 13:43:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9530EACCE3;
	Sat,  2 Jan 2010 13:43:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FIFT91NuxL1xJJZy+fJROiooIRE=; b=kHrXflLzXSN7xCH7xv/GaU+
	bq230rGL404U4hDIQV+mj1WTaoWQ4LszYFXFpViZCu8pBXEEFGzGEzEhWa6rowaq
	rEdmbgYVCaHBW2ig8e1YPR2+HvQ9UFcAC6Sbt7z4mEwsZzZfwHOMjGIxt0vPWWKQ
	CHsI2P7KjROwa3WSKY+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=I8Q+50T7CIxU7stXCzJqiSccNylOvpefR+nIhS0FK02Mujc07
	ghfB9GqU65MwDEmiaRt5Xc2FEYhaxJyc7Aau236pHLx8DFy/4QggFg8dnwfqHMym
	MNzO0Qqd+8eqGs7XXdGxtm9AE36AdYMCT+qz+B7rM3ig/H6WEFr0cyucRo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72FCDACCE2;
	Sat,  2 Jan 2010 13:43:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6D2ECACCDE; Sat,  2 Jan 2010
 13:43:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8582144-F7CE-11DE-B30E-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136038>

Alex Vandiver <alex@chmrr.net> writes:

> most common usage model.  It seems to me like the more correct fix
> would be to move the diff options to later in the file (after the
> options that are `git log`-specific), or to remove them entirely, and
> replace them with a pointer to git diff's options.

IIRC, the apporach we took earlier that people hated and resulted in the
current "include" approach was to say "It also takes many of options that
diff family of commands take".  So reordering may work better but dropping
and referring would not, I suspect.
