From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Makefile: point out "make" if "make configure" fails
Date: Mon, 11 Oct 2010 22:46:47 +0200
Message-ID: <AANLkTi=CajQ7d3K+b8O0EODa9KVGu-uMGkeaDrBojFtQ@mail.gmail.com>
References: <4CB2FEB8.3050705@drmicha.warpmail.net> <1286800665-7437-1-git-send-email-avarab@gmail.com>
 <201010111706.55119.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 22:47:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5PHA-0007rj-OX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 22:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab0JKUrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 16:47:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46271 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab0JKUrI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 16:47:08 -0400
Received: by ywi6 with SMTP id 6so804658ywi.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HI+O29Tbg8uI5dFx8+mRkEfMjfsBgcJsrH6WaXxGi4Y=;
        b=tZ7ESeHDOBsbRx/6HLVhLAb1pIE2q3+vwyrGevt8ZoROpAMDj49OUFTrh/vF9Q4LGL
         1D6a6VK/VpeMznidRq2FKXBO5tZntrObefO6NE49OaElO1VHdVkaXu249lCgjmIEcRGr
         ofPzhIxcyssmNxHY/zWLSktyAlUFHZLdwuFG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nFwNJEiMvjLxNn4A6q/LUUSqidp1IWKxf9rpxltxFV6beF985yyONrL9ZMb+wLVGsQ
         E4oj8ugpRQO3H4dToUpgN6FY7kdlp2ONKtyBxO8UVEutCQXe8gfh9Ou0voiJBET3f1Q6
         fLE3iePPbU73mp+zxXfc9wxsRAPKXoHlep+rg=
Received: by 10.151.41.21 with SMTP id t21mr2189745ybj.158.1286830027519; Mon,
 11 Oct 2010 13:47:07 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Mon, 11 Oct 2010 13:46:47 -0700 (PDT)
In-Reply-To: <201010111706.55119.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158787>

Heya,

On Mon, Oct 11, 2010 at 17:06, Jakub Narebski <jnareb@gmail.com> wrote:
> I like this.

Me too.

> On Mon, 11 Oct 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =C2=A0 =C2=A0 ERROR: We couldn't run autoconf for you. But you're in=
 luck!
>> =C2=A0 =C2=A0 ERROR: Git doesn't actually need autoconf to build.

This is a bit cheeky though. Perhaps just replace that with

> =C2=A0 =C2=A0 ERROR: We couldn't run autoconf for you. However, Git d=
oesn't
> =C2=A0 =C2=A0 ERROR: actually need autoconf to build.

--=20
Cheers,

Sverre Rabbelier
