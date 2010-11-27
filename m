From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Sat, 27 Nov 2010 20:05:42 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011272002090.26955@debian>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com> <AANLkTi=qAus_w18sYXP7m+jtQOGtgkNrsxgiNcbHevC7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 02:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMVoz-0002Dd-VD
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 02:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab0K1BFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 20:05:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:32831 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0K1BFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 20:05:38 -0500
Received: by vws3 with SMTP id 3so697357vws.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 17:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=+R/9i0by3cOvDpbMmXTXtZIKqAFfpdYC2KgyyJ3SXEs=;
        b=SbLOq0wHbOLHucG60XBgSjQTQ7RbuMt0G0iBJNy0NCUNd66Oa6E4YXBGqi0tTXXw3c
         MlbxC6Gfx5esSTSbcFOHqdm4xPeobitA/FtkMq+WpdgzbNmGxFbmvIqFyVOLzpQ1fIHS
         OFCRSJmNLot2BRBU/4zuRqTxHz41lVXFYbxWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=md/fDTiU5U9yXXqvXohk7W2W3RaF22TOuvL0IT5wMI2dGL+rZLoPJiOpKsPStyXsnR
         k9wvYrTFD0JxEkcjP3vHGjMDY+uT4KJnuzRG4f88MWTvK92SDY+1wpL+LJ/HE49fGYvh
         nCGrk1C3c2PqFgZys/NjjSqMKYFQWMDyIhBjQ=
Received: by 10.220.71.135 with SMTP id h7mr955826vcj.129.1290906337914;
        Sat, 27 Nov 2010 17:05:37 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id w30sm449246vcr.16.2010.11.27.17.05.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 17:05:37 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTi=qAus_w18sYXP7m+jtQOGtgkNrsxgiNcbHevC7@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162331>


On Sun, 28 Nov 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Sat, Nov 27, 2010 at 12:15, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
> >  -p::
> >  --preserve-merges::
> >        Instead of ignoring merges, try to recreate them.
> > +
> > +--signoff::
> > +       This flag is passed to 'git am' to sign off all the rebased
> > +       commits (see linkgit:git-am[1]).
> > +       Incompatible with the --interactive option.
> 
> The one above that does have a shorthand (-p), why should we (not?)
> give --signoff it's customary -s shorthand here?

The '-s' flag is unfortunately already taken. It is used for
specifying a merge strategy.

/Martin
