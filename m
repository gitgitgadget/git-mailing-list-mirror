From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCHv2] t5525: test the tagopt variable and that it can be overridden
Date: Sat, 14 Aug 2010 21:37:01 +0000
Message-ID: <AANLkTimGhJf0Yp7-1k6EMT6j4T5N-zwxUVDD24DT2fX5@mail.gmail.com>
References: <AANLkTimYm+GmJ4BmZKOmcZkJf_wgeUiKhTs06qxex+0q@mail.gmail.com>
	<1281734852-21413-1-git-send-email-ComputerDruid@gmail.com>
	<AANLkTikP5xsvfBt7Rq9CoNnF=7SE4-V6LBML=tDMtT_Q@mail.gmail.com>
	<201008141732.16214.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 23:37:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkOPn-00078s-Ew
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab0HNVhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 17:37:03 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52788 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab0HNVhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 17:37:02 -0400
Received: by gxk23 with SMTP id 23so1508335gxk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=S/3esxdFaE1fsDZPYYqfnHli+AvHOK4xEI0imzaxwQ0=;
        b=vdWOfJ47d3nyXxSi5xfko20LdqBF2zd9Cax+vH2LLXOo6deiPy16VV7st+WSoPdUuE
         hzVbmd3tvLkNaUqc441D6uEEnzpgYkcv7/qMyz7e8yTkfRa4xq1D56HMjMpnVl6Y9Usd
         3BgEIpDA/9ZxBW0jhoLYjPVmTGLDhAhmk4sfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kPDOvQhdzUWCgmf6QiLHTRnhdZJHuhAIPDun69bXLG6CtzA2tEyLFoLvqMG8F9R8gC
         peQdKl7USZO43+EVSQBawDLneyvrYbbCjxKCnFUMaKZqVGQe33vRwCfMH1RIGhdKLNjM
         x0ulatNJ50k5Jjz2Qip2JD1qL/bkqKQo5KjZI=
Received: by 10.231.32.75 with SMTP id b11mr3325212ibd.162.1281821821163; Sat,
 14 Aug 2010 14:37:01 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 14:37:01 -0700 (PDT)
In-Reply-To: <201008141732.16214.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153582>

On Sat, Aug 14, 2010 at 21:32, Daniel Johnson <computerdruid@gmail.com> wrote:
> Well, now that we have a fix and a test to help guard against future breakages,
> can someone tell me the next step as to getting them included?

You've done all the needed things. Junio goes through the mail archive
a few things a week to pick up patches. Hopefully he'll pick this up.
