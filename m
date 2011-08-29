From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Mon, 29 Aug 2011 15:11:34 -0700
Message-ID: <CA+55aFz9givAWhP5_SfnneY6x_0ekcN2U9HrKr+NTgY=Ot=6TQ@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com> <7v1uw36fgb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:12:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyA4D-0005nO-Sb
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab1H2WMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 18:12:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43067 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754895Ab1H2WMX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 18:12:23 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7TMBsjo020942
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 15:11:55 -0700
Received: by wwf5 with SMTP id 5so6195995wwf.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 15:11:54 -0700 (PDT)
Received: by 10.216.188.17 with SMTP id z17mr1810134wem.70.1314655914130; Mon,
 29 Aug 2011 15:11:54 -0700 (PDT)
Received: by 10.216.187.66 with HTTP; Mon, 29 Aug 2011 15:11:34 -0700 (PDT)
In-Reply-To: <7v1uw36fgb.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-103.511 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180367>

On Mon, Aug 29, 2011 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The topic started by Marat Radchenko in

Ugh, that's ugly. Is it verified to solve Marat's nasty case too?

But yeah, ack on the series.

                 Linus
