From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/4] Export launch_editor() and make it accept ':' as
 a no-op editor.
Date: Fri, 02 Nov 2007 16:46:54 +0100
Message-ID: <472B466E.8070805@op5.se>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:48:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InylI-0007Qk-KZ
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761221AbXKBPrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761212AbXKBPrM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:47:12 -0400
Received: from mail.op5.se ([193.201.96.20]:52368 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761205AbXKBPrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:47:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 941FB1730746;
	Fri,  2 Nov 2007 16:46:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhXW+srHDpWD; Fri,  2 Nov 2007 16:46:38 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 1C3281730744;
	Fri,  2 Nov 2007 16:46:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1194017589-4669-3-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63137>

Kristian H=F8gsberg wrote:
> =20
> +	if (!strcmp(editor, ":"))
> +		return;
> +

Doesn't this make the change in 2/4 superfluous?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
