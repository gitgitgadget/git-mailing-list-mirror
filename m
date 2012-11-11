From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: t9350-fast-export.sh broken on peff/pu under Mac OS X
Date: Sun, 11 Nov 2012 10:32:53 +0100
Message-ID: <509F70C5.4080405@gmail.com>
References: <509E66B0.3040308@web.de> <CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com> <7v4nkxozep.fsf@alter.siamese.dyndns.org> <CAMP44s0dQ8EeCkHo8Lh3odG3qQoeLFModec+7doLeTHnZoJ_pg@mail.gmail.com> <509EEF09.6060109@gmail.com> <CAMP44s3SSjDqA9cvG9T=-oVH0ADndbxi1MkWF6wR9gxcoCi_xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 10:33:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXTuk-0003Nr-Lk
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 10:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab2KKJc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 04:32:58 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:60186 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2KKJc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 04:32:57 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so2002335eaa.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 01:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=jzj+cTmct+Tkci6PzxDYMladz6Bd5mX72SE8/NkNlEk=;
        b=A/QeDfQQ2i7r/lmfsEbiXO2xJioiaT53cHVpt+E1SvofojjHSb+DeZWa+SJmRurOp/
         e5hgYaTgQGUR4MCuZib8Zryae4710XwQjks2RLsudIGpv5qMTOnC6kErAsXg5vRSgO39
         cf8nfqTqM3RpVdiCNVEjy+izuBdP/OayJFu3DVaCLqylkYee1hgznuNWc8K7VTjzAbwL
         VDqJ5c2T5DrHnIEmf0AUxnBjfsK9t4yu2cAWZ81NMl/sbAS7boBKkD+7QV810ZeRUS09
         7UMCWp2obrO31y2hLzhyxaOIDJa4i+DwuJKdkW0cwMEhn4Tz5w9UG9rkFGloRTV3+Wft
         N9VA==
Received: by 10.14.203.132 with SMTP id f4mr52671041eeo.11.1352626376205;
        Sun, 11 Nov 2012 01:32:56 -0800 (PST)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id t7sm8633928eel.14.2012.11.11.01.32.54
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 01:32:55 -0800 (PST)
In-Reply-To: <CAMP44s3SSjDqA9cvG9T=-oVH0ADndbxi1MkWF6wR9gxcoCi_xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209328>

On 11/11/2012 01:58 AM, Felipe Contreras wrote:
>
> It doesn't seem like zsh listens to that variable in sh mode:
>   $ zsh -c 'emulate sh; NULLCMD=foobar; > content'
>
Right; "emulate sh" by itself is probably enough today (autoconf, trying
to make its generated scripts extra-portable, tends to accumulate a lot
of cruft unfortunately).

Thanks,
  Stefano
