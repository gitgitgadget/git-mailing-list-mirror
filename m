From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/5] git-cvsserver: take care of empty passwords
Date: Tue, 6 Jul 2010 18:05:40 +0000
Message-ID: <AANLkTilSvEf6DIM_JZql8pTnSCrnFQ2tAOGuqownVl4e@mail.gmail.com>
References: <3594077658746039911@unknownmsgid>
	<AANLkTinpjbOStczVo7NaPlxqyAh_32kLy0kWKc_AsLiI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:05:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCWm-0001fQ-Al
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0GFSFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 14:05:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57804 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0GFSFm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 14:05:42 -0400
Received: by iwn7 with SMTP id 7so6909829iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4ayS4cGeQTN6vzqJzKOm9HLHRnrk8AJE05ooyqQDAtA=;
        b=R9yVSS9qP74ENm0fkABc+QYIX1GBJiLlmXTmb860fwFJXBHUP1F2TvqwnNNNyajldQ
         9HO2qZq3GwQWitYQOUmtMhOVpQ17tIVTaKkECfuG2Auh9fR+7yBtQuLqDGKfPzEYvHfO
         T6fWBPQ5N1TAeB9QZyyZ07KPw8jpu9HocA738=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V1kgAOzYsXenqUD9L0oXuTu/E40FkmlbkF/8hZVjhbyvw4zErCsFxYh/qgn2up3SHI
         GH9ebRMLKNBfcqMySI6VPNniikp4bjqS9u0vT8XUuqLBf7u6Wzolb85m7wPtynMAetwh
         xtmJa4X9fg+/T6Fiz8573Nx1KZDQh0ALRPuao=
Received: by 10.42.4.75 with SMTP id 11mr1595722icr.50.1278439540865; Tue, 06 
	Jul 2010 11:05:40 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 6 Jul 2010 11:05:40 -0700 (PDT)
In-Reply-To: <AANLkTinpjbOStczVo7NaPlxqyAh_32kLy0kWKc_AsLiI@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150382>

On Tue, Jul 6, 2010 at 17:37, =C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@=
gmail.com> wrote:
> Do not try to descramble them.

This commit message isn't very revealing. What does this do exactly?
Is the behavior with empty passwords changed now? Does git-cvsserver
no longer support empty passwords? Is the on-disk format in the authdb
just different? (I.e. "" instead of "A" or something). Or something
else?
