From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2014, #03; Wed, 16)
Date: Wed, 16 Jul 2014 15:36:34 -0700
Message-ID: <CAPc5daWUDoqsahmt3boqz-mAfOVSq8ARsOjN+_R=QGWJ4LYSAA@mail.gmail.com>
References: <xmqqwqbdq7yb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:37:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xor-0000q0-0n
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbaGPWg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:36:58 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:57789 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbaGPWg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:36:56 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so1136375lbi.10
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=QEturiwPkKxTZ4oVPBZ1uekdJbVubLjrUd22IFmiH0c=;
        b=KdX/wZc+rx2JFr0csF3+DdXIkdMGBnXEmgWPdeT8/+qrDtpn05hC+MEsooPHtyjDN2
         eOXKff2IqNalH2nKKUwOdhD4OpgzShuMiCJ8ReBhWwFhgzm9DMdpgSoD3NVmg9+IK5vR
         y1YmJzp2IXjQBLTFvhnBlKCfPYS4xdeoZJrDbnL3vutB1Y9UvHkjHhlwNvqAdlui8Ub2
         35FUN5kn7uJKOcZdDgXCGFReKhXkZtNy2IiZgNsvMEKqAIIGiLtYyU2rnJ21ATlFABZV
         IxsOqfSWMhAuIVJDNi/DOSlgo8BuDlEZtTFGJVm3B2uPkFhubjfDIkmV6+Xe1R2vi1XM
         x9Bg==
X-Received: by 10.152.25.132 with SMTP id c4mr5691429lag.88.1405550214931;
 Wed, 16 Jul 2014 15:36:54 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Wed, 16 Jul 2014 15:36:34 -0700 (PDT)
In-Reply-To: <xmqqwqbdq7yb.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: i3NkM8q_xXkthL0euqCWJZtFUjY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253714>

On Wed, Jul 16, 2014 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> We would need to start slowing down to prepare for -rc0 preview at
> the end of this week and then feature freeze.  Some topics that
> joined 'next' late may want to stay there for the remainder of this
> cycle.  Many of the accumulated fixes have been flushed to 'maint'
> and Git 2.0.2 has been tagged.

Oops; I've been hoping that we will have -rc0 at the end of next week,
not this week.
