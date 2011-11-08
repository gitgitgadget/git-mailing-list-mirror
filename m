From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] Pulling signed/annotated tags
Date: Mon, 7 Nov 2011 20:20:35 -0800
Message-ID: <CA+55aFxVsgNjGv2zAGR1VK34uG59+euJec_3i9JNyQ0VUdjyeA@mail.gmail.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com> <1320721245-13223-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 05:21:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNdBO-00060s-M7
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 05:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab1KHEU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 23:20:58 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48357 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1KHEU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 23:20:57 -0500
Received: by wwf22 with SMTP id 22so5833131wwf.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 20:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=RUiZZASldRnE7HEUESx/4V0RInFluzhX44m9gC6sPuI=;
        b=J00wRJknbxQrYgGhBpFTw1sYe38H3Fl34yty3S5t0h2Efsd7LCYKYFFVUZHeXt3s0r
         9oK1wHiZYAfLeqa8pZgsGSuLtkThag1KIokONv4zmIfjlHX8BBDqqyQuP8SD+EEtGRu1
         +Tu/NkBk6jR6ux9LU5b3oaDDhzdev5LmNzFck=
Received: by 10.216.133.217 with SMTP id q67mr6219947wei.97.1320726056181;
 Mon, 07 Nov 2011 20:20:56 -0800 (PST)
Received: by 10.216.166.3 with HTTP; Mon, 7 Nov 2011 20:20:35 -0800 (PST)
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: awmBTpaQQtJRObRSZ1RrcNSePac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185064>

On Mon, Nov 7, 2011 at 7:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This is a re-roll of the fourth iteration.

Ok, this all looks fine to me.

Clean series, and everything looks fine.

The one thing I wondered about is what happens when you merge two
signed tags. Maybe I read the patch wrong, but it *looks* to me like
the code just appends them all together with nothing in between. Is it
still parseable?

I guess I could just try it out .. ;)

         Linus
