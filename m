From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Automatically remote prune
Date: Thu, 5 Nov 2009 19:38:39 -0500
Message-ID: <76718490911051638w7cd5306bx65ed8d9ac525d2c3@mail.gmail.com>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
	 <7v639qi2un.fsf@alter.siamese.dyndns.org>
	 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
	 <7viqdpemki.fsf@alter.siamese.dyndns.org>
	 <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
	 <7v3a4sagau.fsf@alter.siamese.dyndns.org>
	 <76718490911051509r65af2dd2k2574e2e521fed6f2@mail.gmail.com>
	 <20091106001751.GF17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:39:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Cqk-0006W0-0C
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759159AbZKFAif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759155AbZKFAif
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:38:35 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:51805 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758954AbZKFAif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:38:35 -0500
Received: by iwn10 with SMTP id 10so489060iwn.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 16:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zZFeuO5rzYW9P7E0EE1ZC/8n/wpdY2iEENpa7FYayrI=;
        b=f5Ed8xTKijIIUNsyEN1xUqQfI6CjElVaBK+oeV9HsNgZ8wMKV3va4+mX81jUD+U+Jo
         lVY53C/P0xvncbCFzT511bcAUtAj2q3BNwcxuiSFpMQ7pPS1jswfbKsbl5JrkDsuLjBZ
         tAOFCoe22WlpCM7AwmBmeY46qpVNsMsqT+/7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XKUxFdwFXX59j6IXCGNf5TnIldqNjts3WNok0yGPET4TECgQYEWwv4EOFZ92MfYQdz
         Y0zcwvQWNbqMpoVCczCzRUXuxMA//PBkvA6EDSeVLGTLqvV3kyOL7tYeBKLDpwUv/SI6
         G8QgWwKSDgZRwUOwtTN0FnEEUTsEPjtU/1qEs=
Received: by 10.231.123.41 with SMTP id n41mr899446ibr.46.1257467919739; Thu, 
	05 Nov 2009 16:38:39 -0800 (PST)
In-Reply-To: <20091106001751.GF17748@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132262>

On Thu, Nov 5, 2009 at 7:17 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Thu, Nov 05, 2009 at 06:09:03PM -0500, Jay Soffian wrote:
>> Actually, mirror mode applies to push only. Unless I'm missing
>> something obvious.
>
> Perhaps you are, mirror mode applies to fetch as well; that's how e.g.
> repo.or.cz mirror mode is done currently.

Can you please be more specific? There is no mention of mirror in
builtin-fetch.c, only builtin-push.c. Further, the docs for
"remote.<name>.mirror" indicate it's a push option only.

So please explain what you mean by "that's how repo.or.cz mirror mode is done".

Cluelessly yours,

j.
