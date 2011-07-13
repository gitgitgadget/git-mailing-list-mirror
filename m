From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Resend: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 11:26:35 +0200
Message-ID: <CABPQNSYxQDxgDS5z-TMxC3WtNQ7KV_F4f6HTKOH-SpwMQsiHUw@mail.gmail.com>
References: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com> <7v39iba3b2.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 11:27:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgviy-0000OH-Ut
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 11:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162Ab1GMJ1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 05:27:16 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61489 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965134Ab1GMJ1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 05:27:15 -0400
Received: by pvg12 with SMTP id 12so4544094pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Yvc82DnLJ8F3jsi1n3SmqMtsJiWhR9s/tdke2ThKHbc=;
        b=LaalbwWRlwvLK2vpwDQVzTbLSxZHcpwcVmRXJBOdFnCsXGnfl2UDbDv3+1QsspR4HK
         v9BEdeeRnExOWX6t6KJxq3RUjfD3rSzQLy4LAGoT2KoreWMmhKMqgRYq/oXqxnoYYkRj
         u2y/rLNu4bqMLJzNB4avJoVDx322t54/yzWLs=
Received: by 10.68.39.40 with SMTP id m8mr1201217pbk.156.1310549235040; Wed,
 13 Jul 2011 02:27:15 -0700 (PDT)
Received: by 10.68.59.104 with HTTP; Wed, 13 Jul 2011 02:26:35 -0700 (PDT)
In-Reply-To: <7v39iba3b2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177020>

On Tue, Jul 12, 2011 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This looks Looks good to me; could you sign-off the patch, please?
>

As I noted on the resend with the sign-off, I believe there's a
problem with the patch where saved_errno is written to in one place
but the error never gets reported after applying the patch.
