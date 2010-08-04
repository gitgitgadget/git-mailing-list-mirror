From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2 0/3] git stash branch fixes
Date: Thu, 5 Aug 2010 08:44:41 +1000
Message-ID: <AANLkTi=WDnfT_RQDABpN5Y_EoVWK_SRMa2WSHu8p35Pp@mail.gmail.com>
References: <AANLkTik8Npy99jKqUan8wOTXNffBCGwS_WnPwbhXqJYK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 05 00:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogmhc-0007vx-8M
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 00:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab0HDWon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 18:44:43 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46703 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0HDWom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 18:44:42 -0400
Received: by qwh6 with SMTP id 6so3439434qwh.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5H9QUMVq4WoLXqarnagjjWoWs6H327v2xK6PyZPEBtE=;
        b=k7LAqiV5OUq9qcIj85SFUIV4oc3Fc0ufGJAXG126dwPGX7n4RIdO+EPGIlMyse68tU
         H6+GMM4GVnKjA+FuDdZVZ80kDarrTPcfv1VUl82Mchwa0oHk4hc7M8IigbH+eBFyYL9A
         zYHdQfZ+iw/ZwQQQJpxdtrHvZE1CUV5Pvyeu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=V0yP6cLnXXMAsZpTXo8BN4vXG32Irjtkxny/MUGOEnq6/kxZlToM4rqqQ0MTliBIwW
         bhh3Y08pZEWHsshteXvgZpQ2wgcfayIGdL8HLZabf/N5Z8quI8MuSrEPxMiNSLdgtmQ+
         7G8FLC17vkImjc/rOzxB9NjgNClEInsHlMwVc=
Received: by 10.224.29.1 with SMTP id o1mr4370173qac.279.1280961881404; Wed, 
	04 Aug 2010 15:44:41 -0700 (PDT)
Received: by 10.229.222.13 with HTTP; Wed, 4 Aug 2010 15:44:41 -0700 (PDT)
In-Reply-To: <AANLkTik8Npy99jKqUan8wOTXNffBCGwS_WnPwbhXqJYK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152608>

Hi, does anyone see any reason why this series could not be a
candidate for merging into next or master? If there is some reason for
me to re-post it, let me know.

Regards,

jon.

On Tue, Aug 3, 2010 at 8:41 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> | fixed the subject line - sorry !
>
> This series fixes git stash branch so that it is more tolerant of
> stash-like commits created with git stash create.
>
> It particular, it doesn't require there to be a stash stack if a
> stash-like argument is specified and it doesn't attempt to drop
> non-stash references after applying the stash.
>
> This series replaces my previous patch that just included a test
> that demonstrated the existance of the issue.
>
> =C2=A0stash: It looks like a stash, but doesn't quack like a stash...
> =C2=A0stash: Allow git stash branch to process commits that look like
> =C2=A0 =C2=A0stashes but are not stash references.
> =C2=A0stash: modify tests to reflect stash branch fixes.
>
> =C2=A0git-stash.sh =C2=A0 =C2=A0 | =C2=A0 10 ++++++++--
> =C2=A0t/t3903-stash.sh | =C2=A0 28 ++++++++++++++++++++++++++++
> =C2=A02 files changed, 36 insertions(+), 2 deletions(-)
>
> --
> 1.7.2.1.111.g8fc90
>
>
>
