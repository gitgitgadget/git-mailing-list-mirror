From: Junio C Hamano <gitster@pobox.com>
Subject: gitk translation updates needed?
Date: Tue, 02 Feb 2010 17:19:24 -0800
Message-ID: <7vd40nundv.fsf_-_@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
 <7vy6jbunu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 02:19:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcTu4-0002IH-Nn
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 02:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab0BCBTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 20:19:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab0BCBTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 20:19:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFCE796D46;
	Tue,  2 Feb 2010 20:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7LGtrs+J/2gDdnP30m4/wPkqxSo=; b=CgH8cP
	hCvn+3Jfav3APl3g/5rpxsyrzs9yo0KwEjmsl3cbg5j3VhvpEd4PIaqU/3wNKRXh
	RiHyaZ0CAoSVzb3/m7uq6/QPjQvxdJVK71iP91kiHJjQb1NF00LOJDeidLOISTcQ
	TJmytD9gB71ctB53gNQQZuwgRdkXHsqTHZ8kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7D9Srw6QD8yLaDN+j0v63iZTOuor3Q6
	x0K9CVZwPRmhM9Sclemc+BTc0UgR12vKnRN2OgQjoidZxRgcoEF4ZIwHja1WVb/v
	gQsG2jzNZ2RE1lXvSdW6mtRYJbeHLFepA50xkLehr2p1ianPkC/tPUlNxq7hdmd7
	oUV3dFo+FTc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7647296D42;
	Tue,  2 Feb 2010 20:19:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A416896D3D; Tue,  2 Feb
 2010 20:19:25 -0500 (EST)
In-Reply-To: <7vy6jbunu8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 02 Feb 2010 17\:09\:35 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2C88F7D2-1062-11DF-82AF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138797>

By the way, out of curiosity I tried the same for gitk.

 $ make po/gitk.pot
 $ make

 Generating catalog po/es.msg
 msgfmt --statistics --tcl po/es.po -l es -d po/
 192 translated messages, 34 fuzzy translations, 63 untranslated messages.

 Generating catalog po/fr.msg
 msgfmt --statistics --tcl po/fr.po -l fr -d po/
 271 translated messages, 11 fuzzy translations, 7 untranslated messages.

 Generating catalog po/hu.msg
 msgfmt --statistics --tcl po/hu.po -l hu -d po/
 287 translated messages, 1 fuzzy translation, 1 untranslated message.

 Generating catalog po/it.msg
 msgfmt --statistics --tcl po/it.po -l it -d po/
 282 translated messages, 1 fuzzy translation, 6 untranslated messages.

 Generating catalog po/ja.msg
 msgfmt --statistics --tcl po/ja.po -l ja -d po/
 281 translated messages, 4 fuzzy translations, 4 untranslated messages.

 Generating catalog po/ru.msg
 msgfmt --statistics --tcl po/ru.po -l ru -d po/
 234 translated messages, 19 fuzzy translations, 36 untranslated messages.

 Generating catalog po/sv.msg
 msgfmt --statistics --tcl po/sv.po -l sv -d po/
 289 translated messages.
