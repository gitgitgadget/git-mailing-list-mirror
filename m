From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: add option to show whole function as context
Date: Mon, 01 Aug 2011 17:37:36 +0200
Message-ID: <4E36C840.9000808@lsrfire.ath.cx>
References: <4E357BE2.8030409@lsrfire.ath.cx> <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 17:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnuZC-0007ls-2U
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 17:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab1HAPiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 11:38:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:55728 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1HAPiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 11:38:00 -0400
Received: from [192.168.2.104] (p4FFD8EFC.dip.t-dialin.net [79.253.142.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 6FB672F8035;
	Mon,  1 Aug 2011 17:37:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178350>

Am 31.07.2011 19:34, schrieb Sverre Rabbelier:
> On Sun, Jul 31, 2011 at 17:59, Ren=C3=A9 Scharfe <rene.scharfe@lsrfir=
e.ath.cx> wrote:
>> Add a new option, -S, to show the whole surrounding function of a ma=
tch.
>=20
> Perhaps a different option name so as not to conflict with the -S fro=
m
> 'git log'? It would be nice to have this available in 'git log -p'.

Do you mean a diff option to show whole affected functions as context
instead of the fixed number of context lines -U gives you?  That sounds
useful as well.

How about -W?  It's not used by GNU grep either.

Ren=C3=A9
