From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pretty format can't work on cron job
Date: Fri, 05 Nov 2010 09:37:54 +0100
Message-ID: <4CD3C262.6080108@viscovery.net>
References: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ellre923@gmail.com
To: chen_wang@trendmicro.com.cn
X-From: git-owner@vger.kernel.org Fri Nov 05 09:38:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEHoB-0004Pq-EN
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0KEIh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 04:37:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32110 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752043Ab0KEIh6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 04:37:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PEHo3-0001pB-IF; Fri, 05 Nov 2010 09:37:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 479031660F;
	Fri,  5 Nov 2010 09:37:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160805>

Am 11/5/2010 9:29, schrieb chen_wang@trendmicro.com.cn:
>=20
> For the command: git log 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2.. -=
M --date=3Dshort --pretty=3Dformat:"Author: %aN <%ae>; Date: %ad" --sho=
rtstat --dirstat --no-merges
>=20
> I run it on shell by manual can create correct format of output, such=
 as:
> -------------------------------------------------
> Author: Amit Shah <amit.shah@redhat.com>; Date: 2010-10-20
>  1 files changed, 14 insertions(+), 3 deletions(-)
>  100.0% drivers/char/
> -------------------------------------------------
>=20
> But when I put that command on cron job, even I run =E2=80=9C. /etc/p=
rofile=E2=80=9D and =E2=80=9C. ~/.bash_profile=E2=80=9D first, I can=E2=
=80=99t get correct format of output.
> -------------------------------------------------
> Author: %aN <amit.shah@redhat.com>; Date: Wed Oct 20 13:45:43 2010 +1=
030
>  100.0% drivers/char/
>  1 files changed, 14 insertions(+), 3 deletions(-)
> -------------------------------------------------

% has a special meaning in a crontab. See man 5 crontab.

-- Hannes
