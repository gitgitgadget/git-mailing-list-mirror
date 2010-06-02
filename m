From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 2/7] gettext: Add a Gettext interface for shell
 	scripts
Date: Wed, 02 Jun 2010 11:38:48 +0200
Message-ID: <4C0626A8.50105@viscovery.net>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>	<1275435597-4017-3-git-send-email-avarab@gmail.com>	<4C05FAEF.2040205@viscovery.net> <AANLkTim-z6JYmyvl5QWycPV9orsUu8qLg2ZVFP6ZeVLC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:39:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkPZ-0007Dy-30
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650Ab0FBJiw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 05:38:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26211 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755083Ab0FBJiv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 05:38:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJkPQ-00045s-VK; Wed, 02 Jun 2010 11:38:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A7AF61660F;
	Wed,  2 Jun 2010 11:38:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTim-z6JYmyvl5QWycPV9orsUu8qLg2ZVFP6ZeVLC@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148235>

Am 6/2/2010 10:53, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> That hack doesn't work on bash ('\c' produces a space), maybe it
> doesn't work anywhere. Do you have a shell that doesn't support echo
> -n? What does it output there?

It's not just echo -n. You are dealing with text that is outside your
control. There are implementations of echo that interpret backslash in =
the
text (like \t, \n etc.). You are risking that they are treated as escap=
e
characters rather than printed as-are.

> I wouldn't be surprised if it did need to be changed to printf
> "%s". I'm just curious where it broke and how.

Actually, I don't know where -n does not work.

-- Hannes
