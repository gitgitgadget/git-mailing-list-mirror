From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] submodule: remove redundant check for the_index.initialized
Date: Sun, 09 Jun 2013 19:41:03 +0200
Message-ID: <51B4BE2F.6060700@lsrfire.ath.cx>
References: <1370795625-10506-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2cidZt6YWx-f5VMO3uhcTbV-SA-ze6xojHn2y_Pi1=NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljc7-0003xG-FZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab3FIRlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:41:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:59103 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab3FIRlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:41:06 -0400
Received: from [192.168.2.105] (p4FFD9DEC.dip0.t-ipconnect.de [79.253.157.236])
	by india601.server4you.de (Postfix) with ESMTPSA id 87E941DA;
	Sun,  9 Jun 2013 19:41:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s2cidZt6YWx-f5VMO3uhcTbV-SA-ze6xojHn2y_Pi1=NA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227049>

Am 09.06.2013 18:44, schrieb Felipe Contreras:
> On Sun, Jun 9, 2013 at 11:33 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> read_cache already performs the same check and returns immediately i=
f
>> the cache has already been loaded.
>
> This time I beat you to it first ;)
> http://article.gmane.org/gmane.comp.version-control.git/226701

Good to see we're agreeing on something for once. ;)

Ren=C3=A9
