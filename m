From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: don't persist keepcr flag
Date: Fri, 09 Dec 2011 10:50:07 -0800
Message-ID: <7v1usdebnf.fsf@alter.siamese.dyndns.org>
References: <1323415845-11826-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6zv-0001GN-5E
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab1LIUYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:24:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689Ab1LIUYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:24:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 073576669;
	Fri,  9 Dec 2011 15:24:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=3yPV1KSAH6/jjBrHt/H9rJO91DQ=; b=wGxkkXFk3KGhB9ll4zba
	8dRwgNlzDbBvyDgo2+AgioAQzVXMVI1+ZeqB4zgPzbexD0YWVErPzPz8CgbVQ6Si
	S+vNvo+obIGSfMypV2IJZ2/R5mLmBkNiQ5OMNlthOzBgRejAhCpq4Tv1GIkOMK80
	bmwY+1XbSIq+cU7fLD6z6sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rBwuxrH55OCH6ZwVepMpJdg3xsC6ij3l+mIJBMw5nRhMrU
	mEeuVDnjZO2DY89s5l4MvEaikT50oYSdzrx+I9ljjZhDQGiC4pmhDQjnreFZ4MpT
	B1tUpwMRV48CAsodOnENIvKuKj1XFpDz8a76JMefquCW9x+AVsfzovlpnCFpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1C136667;
	Fri,  9 Dec 2011 15:24:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B7A36666; Fri,  9 Dec 2011
 15:24:37 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0CB220C-22A3-11E1-BDB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186683>

Makes sense; thanks.
