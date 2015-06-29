From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Tue, 30 Jun 2015 00:13:23 +0530
Message-ID: <CAOLa=ZTYQd==jMizstfq88iZDdAqTPQHhdwZZ=dqkhqzibDXtg@mail.gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com> <xmqq6166bcw2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:44:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9e2F-0003Wj-IQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 20:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbbF2Sn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 14:43:59 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34762 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbbF2Snx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 14:43:53 -0400
Received: by oigx81 with SMTP id x81so124506793oig.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4h1dj7ZPT+PTtAU1XzbMwo6LSuVqSsJTyIzr/MA5AOU=;
        b=wK/xPsi9vF8/ibcfyXOiKpEye9MGp9Pn4CKrmcIHHEZ/HiJdAw2NwIQyIAYn/qwS+A
         VnHYdEmxgheOQ9R/qAvH+gZAPn6EoJuObeO/dHKxxKnueCes3XEnFnVAE19tzAFdZZ1K
         N4E7C/godKtZwpnJDnw7w5AqQDDaLdb73V4n8EW8mM/JqueAhFW0AdmHiOdpzwr5pW7+
         IwMgVobhN4fuHSQVGxNQqBt3IjeXTwtOMX0acVwqMkLv0Z9yXWs8dy7v+LvksisQoGG+
         J8wHcDDYNgxq/x6zp68EKr2WHymG91Jw30hjRX3i0IcsemeEJHCsGYjtDFWJJTOl10Z5
         inrQ==
X-Received: by 10.202.180.133 with SMTP id d127mr14774172oif.104.1435603432461;
 Mon, 29 Jun 2015 11:43:52 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 29 Jun 2015 11:43:23 -0700 (PDT)
In-Reply-To: <xmqq6166bcw2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272993>

On Mon, Jun 29, 2015 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>  t/t6302-for-each-ref-filter.sh | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 t/t6302-for-each-ref-filter.sh
>
> non-executable tests: t6302-for-each-ref-filter.sh

Renaming it defaulted to 644, will change, thanks :)

-- 
Regards,
Karthik Nayak
