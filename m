From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Buglet in i18n?
Date: Fri, 22 Oct 2010 10:49:53 +0200
Message-ID: <4CC15031.7030004@viscovery.net>
References: <4CC13AC1.7080402@viscovery.net> <AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:50:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DK5-0001Um-Dn
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab0JVIt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 04:49:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3635 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab0JVItz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 04:49:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P9DJx-0001BX-MB; Fri, 22 Oct 2010 10:49:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6A21A1660F;
	Fri, 22 Oct 2010 10:49:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159666>

Am 10/22/2010 10:20, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> So maybe the shell on Windows doesn't behave the same way wih regards
> to eval_gettext()?

It's the gettext fallbacks that do not work. Try this on Linux:

  GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=3Dt ./git-am -3 some-mbox

(with some-mbox that has a conflicting patch).

-- Hannes
