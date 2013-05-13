From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Mon, 13 May 2013 19:47:15 +0530
Message-ID: <CALkWK0kE9tvNjPW7jH10ZatLHEuqbH+XmovEpp3RPAh1koyvpg@mail.gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
 <7vy5bjqxxa.fsf@alter.siamese.dyndns.org> <CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
 <7vr4hbou7d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtZg-00068p-PA
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab3EMOR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:17:56 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37535 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab3EMOR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:17:56 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so12481935iej.30
        for <git@vger.kernel.org>; Mon, 13 May 2013 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IbgHK3TrFIOOdahPE4EfT6Wgz3i6WqnCFKmNQ+C/05A=;
        b=Gs3CCitu701wVYEWhhCQaWwZ34xtVpodsSJcu5Z2NKu3DhE5sO0ncVexJm0f6pdG/b
         yIAvuewZ1pQc3s4TkwIW3gDFX6VHfcdRg0DIvcwlZY4h68M3LTdAkBUkVp0mVqtRS4F4
         dqFNFUVT7nLykLMhkJwJnOJsvPmujLyIz6e9AAcEqPPcg0pgyUI563XVsU/h7WiQLXsD
         Uu79smllITGP3N7B8rJ+yBVLK5qBBUVtcZzpBK2WhCkCF2xI+NQvQUTba4oQfnxAk5Xj
         M0otqiqCwX6VRyq0xSyM96bXDfyMJGn6BC3KSzJhuU59lotspwdUqDVxrHplQAZYJXEY
         SEnA==
X-Received: by 10.50.73.65 with SMTP id j1mr10293112igv.49.1368454675729; Mon,
 13 May 2013 07:17:55 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 07:17:15 -0700 (PDT)
In-Reply-To: <7vr4hbou7d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224150>

Junio C Hamano wrote:
> "create" is not advertised very widely, but "store" is too close to
> what is already familiar to the people "save" and we really do not
> want to confuse them.  "store -m message commit" sounds as if you
> are creating a stash to apply to the given $commit.

In the store series I posted a few minutes ago, I use the format
"store <commit> <message>".  I've not advertised it in the usage (like
create), and documented it just like create.  Maybe we should add the
line "Not for end user interactive use" to both descriptions?  We can
get that double-underscore if you really want, but it'd stick out like
a sore thumb since we can't change create.
