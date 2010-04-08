From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu, 8 Apr 2010 13:58:03 +0800
Message-ID: <o2qbe6fef0d1004072258h3cab0156o9f63d6bfa732eb87@mail.gmail.com>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
	 <7vochu8rg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzkkm-0006Xs-PJ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab0DHF6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 01:58:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49944 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0DHF6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 01:58:05 -0400
Received: by gwb19 with SMTP id 19so1008242gwb.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=LZqcOPwQsS8DV2K4aSZImcGUIOSergUUkiG8HlutuKE=;
        b=F2aYDoD3SGKIJzDcetbCQtccLvjNDpCHQ7HcOtGWqhDOdDDh1vt3z41rr9VzmiVDsL
         23WQgnkUmriz4sVt0C0s2m8QyuWI7Ei65CY03H3XEmh0oenbU9r6M9HeKHhLCzP2tZVr
         vIvDJ9HpzPV7y9gcY9LqleS1wQ8CG3J5jgyqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=StJnnr+qf2oMdqIwnL3v4KiyWFUxDfw7kNkgnLgImOG/48gfSxjgA21Vi6JuNdfucK
         6DR6v9uxnbFjvB2PD2I9I1WMHU+4IH/lCPudl9/+PbE7AGYkBOp0ZSrWFpv2Y2DkY7/E
         g6HK7TGKukDtWWRlqAevXxpn/ZKE2bapwWn+0=
Received: by 10.231.10.65 with HTTP; Wed, 7 Apr 2010 22:58:03 -0700 (PDT)
In-Reply-To: <7vochu8rg7.fsf@alter.siamese.dyndns.org>
Received: by 10.101.29.16 with SMTP id g16mr14286629anj.16.1270706283476; Wed, 
	07 Apr 2010 22:58:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144320>

Hi,

On Thu, Apr 8, 2010 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Instead of breaking execution when no remote (as specified in the
>> variable dest) is specified when git-ls-remote is invoked, continue on
>> and let remote_get() handle it.
>
> Shouldn't it default to "branch.$current.remote", not "origin", though, as
> ls-remote to inspect is most closely related to "git pull"?

actually, it already does so (remote_get() does all the magic); it was
my commit message that was not accurate.

-- 
Cheers,
Ray Chuan
