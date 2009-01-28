From: Sverre Rabbelier <alturin@gmail.com>
Subject: Re: [PATCH v2 1/2] git-am: emit usage when called w/o arguments and 
	w/o patch on stdin
Date: Wed, 28 Jan 2009 11:32:16 +0100
Message-ID: <bd6139dc0901280232y25a2fab0xe0eda8783314cc7@mail.gmail.com>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
	 <7vhc3kxdwm.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 11:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS7js-00061t-Vw
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZA1KcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbZA1KcT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:32:19 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:28665 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbZA1KcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:32:18 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2463447rnd.17
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xt+WmwgqydsHcbslN5qCDPaOeAuXNpwSnYzpid3I/Qo=;
        b=MTMWxDQY6lD40Wbt/bFCGFinsVJ1vbXROab2TZq3QHbqosMMtddgguZGp36RsOecd6
         y1sPP3EYl2iUWDPgl334a3gLGn6VcyW1osLd0sUlTZ+lbbOIb63Q/PVjwofCVlA1HvpG
         x8AC1pZ1j0PpP68aMoqEu1VcY9fbLQjcKO0RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=cCzT9MsyaBuCbHqFWT+ea5glSE+6MMtHV+LkuDvrat16Vs8iyYQPnuCm+yRB2WgtfP
         K0KZGTSPJeb8nz+xdxy7AACuoayMjSRhqQBZ0tdTK4bC6qv8AFHxTXnYmw28PyA4uqZ7
         zUy/tFNaWJWrkpL+UxaPz7hrb5+HkGeEOIUW8=
Received: by 10.150.215.16 with SMTP id n16mr305924ybg.223.1233138736739; Wed, 
	28 Jan 2009 02:32:16 -0800 (PST)
In-Reply-To: <7vhc3kxdwm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107522>

Heya,

On Wed, Jan 28, 2009 at 05:17, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> +     test $# = 0 && test -t 0 && usage

Awesome! Thanks for looking into this :).

> Sorry to be dense.  Why isn't your patch the above single liner?

I hope you two work this out soon so it gets into maint.

-- 
Cheers,

Sverre Rabbelier
