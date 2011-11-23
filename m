From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: do not pass non-literal string as format to
 git_path()
Date: Wed, 23 Nov 2011 09:29:17 -0800
Message-ID: <7vty5ubvde.fsf@alter.siamese.dyndns.org>
References: <1322052336-13619-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:29:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGdR-0003rM-CC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab1KWR3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 12:29:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab1KWR3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 12:29:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7639752E0;
	Wed, 23 Nov 2011 12:29:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=pLA0xY
	6oZuys59xurq9m4wBBXX/pxszwpecOFba0aqQN0KGuwV7TfQgAYSxoq1SCNcLYP5
	D4Qle2+rJltpAu0a6hLBZTxzDkXb7cIZV8ere2JwkzDLjsMTsgxwxMf4NdjQeagN
	yEd/VuiYE2rzARXXIBQkn7oo+Jw0fmHr8+rNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cCY1+zG586iwIfZfhzetlkKqo1RwxztS
	JGfjdY6WW9MAqteswywMH5b3ZqS9uLt0sxlCKJC4S4nmd5fPNuAnWJdsp3taNYwm
	jgDEIF3sRZ5klKcVIc7wP5LJNZvUOCmlJwGAnoq4z7etXnCUqMWsoc7xLCXb1nFg
	3+AWWD/kMhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E70D52DF;
	Wed, 23 Nov 2011 12:29:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 051C652DE; Wed, 23 Nov 2011
 12:29:18 -0500 (EST)
In-Reply-To: <1322052336-13619-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23 Nov
 2011 19:45:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACA3CEF4-15F8-11E1-8DCD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185859>

Thanks.
