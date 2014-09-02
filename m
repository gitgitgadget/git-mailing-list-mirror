From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: include HEAD in --all output
Date: Tue, 02 Sep 2014 09:59:17 -0700
Message-ID: <xmqqsika2c2i.fsf@gitster.dls.corp.google.com>
References: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
	<1409437488-25233-1-git-send-email-max@max630.net>
	<20140831153054.GD17449@peff.net> <20140831213606.GB6385@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Paul Mackerras <paulus@samba.org>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 18:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOrQl-00070r-LG
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 18:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbaIBQ7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 12:59:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57781 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbaIBQ7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 12:59:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 183A93507E;
	Tue,  2 Sep 2014 12:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2HKatMKeDN+7h+0BzhZGr3nG/3M=; b=O3/Odc
	stlKETBNTrUlLzHHh/b0SupDLAhsUaUQ2yXaJLg5JMPSjIsvtybN60LFcP2rDiM+
	vV1f/ZnCMaB6LrcGXNi87F75WGLB3ipJsIRa2nFzbt31v9L37MoJ9rbfRBB2Q+HS
	2EekbakFJ32yAo3+5IrGmsqA59ykFlaXfyKKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JuWxHSfQnkwAg8UOcZdLDenvcKgShd6R
	9TWK1/JRUCWDSGih/EWPW3OW9fARov1Twk/2GGn/QzdakE8A6cNaLeUzJCbjKOE6
	qgOhZe8VstIqkZjVP6DCSa67SzD6kY0opxEm2b4AocvsmXxj/aavHPPuMGTRWRWC
	5sQXnAR0eGM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DAFA3507D;
	Tue,  2 Sep 2014 12:59:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BBF5835064;
	Tue,  2 Sep 2014 12:59:19 -0400 (EDT)
In-Reply-To: <20140831213606.GB6385@wheezy.local> (Max Kirillov's message of
	"Mon, 1 Sep 2014 00:36:06 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B12BB18-32C2-11E4-9EAA-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256324>

Max Kirillov <max@max630.net> writes:

> btw, manpage for git-rev-parse says "Show all refs found in
> refs/.", should it also be changed?

I would rather see "rev-parse --all" not to include HEAD, especially
if it has been documented that way.
