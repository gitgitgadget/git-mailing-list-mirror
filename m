From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Sun, 5 Sep 2010 15:05:09 -0600
Message-ID: <AANLkTikxr_uYu69RCcDNGzVcEexdykde0+ixh_Ti8rBx@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
	<AANLkTimf_EJcZtJk_X7FiKqQy-oRU4NvZsXMCEcsB=Wa@mail.gmail.com>
	<AANLkTikwKgMy4x3n7jUKmpbxvpwtwHD-KBynu87WM==Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 23:05:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsMPK-00055W-Jr
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab0IEVFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 17:05:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0IEVFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 17:05:11 -0400
Received: by fxm13 with SMTP id 13so2204302fxm.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nBUBjU5F8Kpbvt1uN+VS7UGbNCZSlKn7XVyWO+0uzFc=;
        b=uJae8ShyPakc93jMMWbcyQ1qIZNR7leIr4kKTDPjFD91amhUsoWY8WfxoLp0cgqqoZ
         A8n+T3+IAL+zAn2QGdetapDKfKZKTl4M2GjZXMW+IwR6CRFUl0+ULnA4tdALAs9/JfkF
         H42yt8uh4tx2Q+/zcpXTC+D54r/WMNAktWT/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f5XnL4ASVRroI4VNCbf8zNB2B6P9jbhJQB9Gw1AKVe6gEWdwQhp+eD5kshMf3bMkOI
         tLW4beBI2RuX4tPZCa3ir9zb+Xzv+A+X2uANBGlg4B4w8EaR1/LERc3Ghr8y09oJv6Cl
         bm7tuewLdHmFjFxg/QJV+Lm8BRTKjk0+gvqYY=
Received: by 10.223.117.209 with SMTP id s17mr1281495faq.93.1283720709556;
 Sun, 05 Sep 2010 14:05:09 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sun, 5 Sep 2010 14:05:09 -0700 (PDT)
In-Reply-To: <AANLkTikwKgMy4x3n7jUKmpbxvpwtwHD-KBynu87WM==Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155487>

On Sun, Sep 5, 2010 at 1:13 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> 2010/9/5 Sverre Rabbelier <srabbelier@gmail.com>:
>> 2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>>> Tree generating from index, Elijah merges the base tree inside
>>> write_cache_as_tree() while it does it inside commit_tree(). Again =
the
>>> principle is pretty much the same. I'll see if I can resist from
>>> stealing some more :)
>>
>> Why don't you two combine your series instead? :)
>
> Hm.. the two series have different, conflicting goals. I think we'll
> end up sharing a lot though.

I think we'll probably eventually converge, and have been some
already.  For example, Nguyen dropped his tree-rewriting and
remote-merge; and I'm going to drop my passing of arguments to upload
pack on the command line, and my setup_revisions changes.  I'll
replace them with some of his patches, because his changes are a lot
better there.  Since he's planning to work on fsck next (it was down a
ways on my list), I should be able to just adopt that too (especially
if he does it by making it use rev-list).  Finally, we've also adopted
ideas in our discussions from each other.  Even if we don't converge
all the way, if we keep cherry-picking good stuff from each other and
giving each other feedback, we'll get close and then others on the git
list can chime in on what they'd prefer for any remaining differences
between us.
