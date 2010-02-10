From: =?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>
Subject: Re: [PATCH 4/4] Add test for using Git at root of file system
Date: Wed, 10 Feb 2010 11:10:13 -0200
Message-ID: <4B72B035.9080603@jonny.eng.br>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com> <1265734950-15145-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 14:11:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfCLz-00056H-If
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 14:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab0BJNKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 08:10:20 -0500
Received: from roma.coe.ufrj.br ([146.164.53.65]:60228 "EHLO coe.ufrj.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab0BJNKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 08:10:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by coe.ufrj.br (Postfix) with ESMTP id B21161FA1D4;
	Wed, 10 Feb 2010 11:10:16 -0200 (BRST)
X-Virus-Scanned: amavisd-new at coe.ufrj.br
Received: from coe.ufrj.br ([146.164.53.65])
	by localhost (roma.coe.ufrj.br [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5uCzLsA4MsB; Wed, 10 Feb 2010 11:10:14 -0200 (BRST)
Received: from home.jonny.eng.br (unknown [187.14.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coe.ufrj.br (Postfix) with ESMTPSA id 1E9531FA080;
	Wed, 10 Feb 2010 11:10:14 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
In-Reply-To: <1265734950-15145-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139510>



Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This kind of test requires a throw-away root filesystem so that it ca=
n
> play on. If you have such a system, go ahead, "chmod 777 /" and run
> this test manually ("make test" with root permission won't work).
>  =20

I've seen you have a prepare-chroot.sh file in there.  Is it working or=
=20
not?  I mean, did you create a chrooted environment to test, or there=20
was any problem with that?
