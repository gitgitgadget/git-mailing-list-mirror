From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable clone
Date: Sun, 6 Mar 2016 15:52:11 +0700
Message-ID: <CACsJy8BgZ+62mLnNLLAuKbAjyfaoNGm3Zhxe4N-XEo-w9a17DA@mail.gmail.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
 <CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
 <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1603060831570.3152@virtualbox>
 <CACsJy8Donxwx0LE0jDwpLbS4D-m4JzWne29GHAG0jfh2CH3pdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 06 09:52:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acUQh-0004t8-Sg
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 09:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcCFIwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 03:52:44 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34241 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcCFIwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 03:52:42 -0500
Received: by mail-lb0-f173.google.com with SMTP id xr8so5021704lbb.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 00:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/DIU7xfd3t90GjLGVBs92Ga6pj1Q0fARkjqButvFUog=;
        b=bbooGChRk/vbOuqul441bbKdF5d4umUpN9MqYynVWtmwt7xFANf4NXHkaKmMv1Rr2e
         VghkgEEMcT5sehXrC74GzyYuQSCeo65cgjJaOoECtkDzirX0Uapb2EVRMkN3+Ou2t0PG
         fWLoGUv3GlpMoNjIKnDZJ9Vn3la3oU6qTojHQqRcF+MiDGd6eTvbdh0GUfzhpZTEllmi
         djE3OfI16C+yoQeQGJvuZ+n1GI+ovCNmK3eoiNdAY/lA6RtKkRhMjfhiSCI4fqQiroWy
         9bachN9QbjnSfwnf62w06Y0BRH50CpDyQ97/IFBqBfPYe9DULhYf0z/6jnC4ihyzHzcV
         avug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/DIU7xfd3t90GjLGVBs92Ga6pj1Q0fARkjqButvFUog=;
        b=EFEEnc7Q4qHAdm91LL7GZWN7aVtIiNfPO9Lt5L8CorwHGkkZS7CQyQasfVqSaSHR1u
         hgSG3l+iD8r2vxrKPhAKIJIG701syyNp6OdcA1zi4QeWkgTJvLBeXzQPh2/LcpkfHBBC
         LNg+V/erA1XP8OIjFX9aGQHOvP7vajXVlan5z035hlo1Xg3X6w3+mNkkESlO83tKgQ7B
         SSHFbMYl8xmiTvilLvCNXtcDGkQLeIsUqCeeVtQx4kNTpACZ4GTQBgqkQP7IEqEBg6Oj
         QQs8SLjtk7bV3FhLC7wajXxObmA5dHG/ApVW4fFSRaforWmN01ux0EvmnZ2PWqhiDxIk
         D9QQ==
X-Gm-Message-State: AD7BkJKV0XZ8sMBwSWhcxlYa3dx967ifKwQohw9bnihLRIFmXMy8I3YzF4nWDCvunFu4PlPfxtDU0EHJhNRHeA==
X-Received: by 10.25.159.68 with SMTP id i65mr5850335lfe.94.1457254361384;
 Sun, 06 Mar 2016 00:52:41 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Sun, 6 Mar 2016 00:52:11 -0800 (PST)
In-Reply-To: <CACsJy8Donxwx0LE0jDwpLbS4D-m4JzWne29GHAG0jfh2CH3pdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288340>

On Sun, Mar 6, 2016 at 3:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> One thing Junio didn't mention in his summary is the use of pack
> bitmap [1]. ....
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/288205/focus=288222

Oops, wrong link. Should be this one

http://article.gmane.org/gmane.comp.version-control.git/288258
-- 
Duy
