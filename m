From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor builtin 'git am' side-effect
Date: Thu, 20 Aug 2015 11:40:20 -0700
Message-ID: <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 20:40:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSUlG-0001HP-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbbHTSkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 14:40:22 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36298 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbHTSkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 14:40:22 -0400
Received: by pawq9 with SMTP id q9so33777358paw.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=aYdZ7u3RszIVj/1Q+VOcncGrEgTTD8nj6R9pc19CFPI=;
        b=GLF9yBgWzcjG+7+J0//IH4fNQ4lgjYj2oib5Ex00gObIB5AYGGRlXeaGelROh5r8Yu
         FtouCcSaO1ExChYh50ww5VOkGmL4x5oxcqAkW00QSGx2YoYbc1yh3Zt8/wgXuNedpvBd
         rCEXsRGY99YSi3bj30YEgnrxQ8FD8IQnwOX0eeuRM64CKJnb2Ncd2595x88g7erwm8fr
         zAYWMZukTNCUGUrmn1LACkM6oMGx1gvhtb2Qqe8WZext4C/te37EsuTJtdy0EDAG4HW9
         ossN9T3QEFdHm4Z21/En1cP8feBJ79t9rPTc5Bcf8cvXJiyVcu3HeQJoAYNzCSwlAIVs
         cfvA==
X-Received: by 10.68.241.103 with SMTP id wh7mr9024279pbc.88.1440096021367;
        Thu, 20 Aug 2015 11:40:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id hg3sm5132562pbb.52.2015.08.20.11.40.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 11:40:20 -0700 (PDT)
In-Reply-To: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 20 Aug 2015 15:22:47
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276260>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The format of the files '.git/rebase-apply/{next,last}' changed sligh=
tly
> with the recent builtin 'git am' conversion: while these files were
> newline-terminated when written by the scripted version, the ones wri=
tten
> by the builtin are not.

Thanks for noticing; that should be corrected, I think.
