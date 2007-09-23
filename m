From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 3/5] git-merge: add support for branch.<name>.mergeoptions
Date: Sun, 23 Sep 2007 12:31:23 +0200
Message-ID: <8c5c35580709230331h459bd07ay8b17146b5feec212@mail.gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-3-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-4-git-send-email-hjemli@gmail.com>
	 <7vps0adx0x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 12:31:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZOkN-0001YD-OX
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 12:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbXIWKbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 06:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXIWKbY
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 06:31:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:60582 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbXIWKbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 06:31:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1633250wah
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O8ujBZbLajh2/ozpk19Yl9TrQ7dUTGuoyYdVUcjIgfc=;
        b=at/z+eyA2WWCwmj/V/9BYluPaTqzAC9W/E9Sk3HYaYkeCLDQJqDBN7lC4qHDe/HEOmGChT2Pp/p20nWuwu7JjZyGx9HpAoE6F2jH4TAFpMwH0AhL3F0mDY8dMYplIkjtZz232FqECtkkZbp/6NivM1OQdZAH9KBAKgO6wiJzov4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iMj1x6YnR2Qlf+hBaY83xrEvcyuaypjQC6Ma+vh65tJWeOxmNx21r7opPFDBPxOwAcBlO0BW8G9dxNtMZHR/ZAzeqRm+b628lcuMlc4gD6/QlaBtBPNR9DurrDb8ux4Y3u+TQkz0mTYuYLJTXAF5RBmboDQxzzaq0jk1WHJwQi0=
Received: by 10.115.47.1 with SMTP id z1mr4477270waj.1190543483242;
        Sun, 23 Sep 2007 03:31:23 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 23 Sep 2007 03:31:23 -0700 (PDT)
In-Reply-To: <7vps0adx0x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58960>

On 9/23/07, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
> > +branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
> > +mergeopts=$(git config "branch.$branch.mergeoptions")
> > +parse_config $mergeopts
>
> What should happen when your head is detached?
>

My plan was 'nothing', but I should have tested it (it does work, but
also prints an ugly "fatal: ref HEAD is not a symbolic ref").

-- 
larsh
