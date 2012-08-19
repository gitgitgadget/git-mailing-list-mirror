From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Sun, 19 Aug 2012 09:15:26 +0200
Message-ID: <49E12233-CD0E-410A-81BC-964B6CBE7DE8@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> <7vehn3rbom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 09:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2zkA-0007j5-CP
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 09:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab2HSHPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Aug 2012 03:15:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44169 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab2HSHPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 03:15:30 -0400
Received: by eeil10 with SMTP id l10so1495935eei.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=PfkK/fZcLrUtbpaQWfdRlEb2YIl5S+TCynIEpaqnhMs=;
        b=vIjnYLVHcniWGjr1Na29/+GA3u1NBbT4T2aYV1/ROdj+qtHJv3hgYfc4gULMKfboOh
         +zdmawVraQwEIItCrHfiJ3Lg48sDxsXAzbYzaoe/glcHvkLr8rnEsWjRgHoL9j/wsOjh
         bDZePktjnuDwofJoQ9cZuLc1fWLt7rx6mETA/E/Y4bLXjpg3S4C+7vIw439Z+ciyQFed
         A4j1QPe+9OKgZCZJq/XoEhdn3tL+1d+OmClWHhPlK13gdNxWWCbTYuMbvmGyq93LVwvd
         apbvJJd/70MxUqKqGQsGnCRdBdGcv4jsTQhmB3cSpiEh0K6YRsfXdq8CN4RKlbtas0A8
         RfLA==
Received: by 10.14.215.197 with SMTP id e45mr3786327eep.36.1345360529029;
        Sun, 19 Aug 2012 00:15:29 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id 45sm32291085eed.17.2012.08.19.00.15.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 00:15:28 -0700 (PDT)
In-Reply-To: <7vehn3rbom.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203713>

On 19 Aug 2012, at 02:02, Junio C Hamano wrote:

> Alexey Muranov <alexey.muranov@gmail.com> writes:
>=20
>> I hope my opinion might be useful because i do not know anything
>> about the actual implementation of Git,...
>=20
> That sounds like contradiction.

I meant that i am psychologically not attached to the current behavior,=
 and may provide a na=EFve view point, if you like.

-Alexey.