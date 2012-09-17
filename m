From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Integrate wildmatch to git
Date: Sun, 16 Sep 2012 22:31:23 -0700
Message-ID: <7vpq5lw6z8.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTvi-0005Lk-6J
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab2IQFb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:31:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab2IQFbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7045B60BE;
	Mon, 17 Sep 2012 01:31:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNO/+y5bXcSZk/t1+UvHylc/fqs=; b=sEPHgH
	jJU+RNjBYoTJVWWKAXMn2cCssBJMv8+H6D9YA6emiGUMNZUpU45FlIrc1yLFfSza
	ZgZO6luFxNQ2UXTMN5vtrn5piO22Va4dXCHaVdpfZ6XGDEQhxO4U+eDQHeEjVO6Q
	kzCqZ/tjTjqRtGIEaCKGxlNg2NOAiwoAYmo4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c4Fr7UU8wohJqekXgn7CANiI1ocE53XC
	19UqalH+UxXecGDPKgjiZ1dPy4xo6+w/L7B3RuqgZOTB5V23aLDIDi5McQxXm/Bx
	QXxlAZnQ2gi6rTgILePGrGchNBxuM7/ZY+7akHOe5YzOHRFbrgxjNFRPWoli+l9G
	aR/S1FJt91E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5341460BD;
	Mon, 17 Sep 2012 01:31:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B727160BC; Mon, 17 Sep 2012
 01:31:24 -0400 (EDT)
In-Reply-To: <1347809265-2457-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 16 Sep
 2012 22:27:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBE26E56-0088-11E2-95D2-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205648>

Am I missing some includes?

test-wildmatch.c:50: error: array type has incomplete element type
test-wildmatch.c:52: error: 'POPT_ARG_NONE' undeclared here (not in a function)
test-wildmatch.c:53: error: 'POPT_ARG_STRING' undeclared here (not in a function)
test-wildmatch.c:54: error: 'POPT_ARG_INT' undeclared here (not in a function)
test-wildmatch.c: In function 'main':
test-wildmatch.c:122: error: 'poptContext' undeclared (first use in this function)
test-wildmatch.c:122: error: (Each undeclared identifier is reported only once
test-wildmatch.c:122: error: for each function it appears in.)
test-wildmatch.c:122: error: expected ';' before 'pc'
cc1: warnings being treated as errors
test-wildmatch.c:125: error: implicit declaration of function 'poptGetNextOpt'
test-wildmatch.c:125: error: 'pc' undeclared (first use in this function)
test-wildmatch.c:128: error: implicit declaration of function 'poptGetOptArg'
test-wildmatch.c:139: error: implicit declaration of function 'poptBadOption'
test-wildmatch.c:139: error: 'POPT_BADOPTION_NOALIAS' undeclared (first use in this function)
test-wildmatch.c:140: error: implicit declaration of function 'poptStrerror'
test-wildmatch.c:148: error: implicit declaration of function 'poptGetArgs'
