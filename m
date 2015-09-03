From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] git-p4: add config git-p4.pathEncoding
Date: Thu, 03 Sep 2015 11:18:36 -0700
Message-ID: <xmqqr3mfjrib.fsf@gitster.mtv.corp.google.com>
References: <1441271647-67824-1-git-send-email-larsxschneider@gmail.com>
	<1441271647-67824-2-git-send-email-larsxschneider@gmail.com>
	<xmqqa8t3l9km.fsf@gitster.mtv.corp.google.com>
	<9986CCDA-DB0B-4D7E-B758-668A46010188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de,
	sunshine@sunshineco.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 20:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXZ5u-0002Ui-KR
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 20:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843AbbICSSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 14:18:39 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35879 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbbICSSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 14:18:38 -0400
Received: by pacwi10 with SMTP id wi10so53828176pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=97VDVlwd9R+ZU3WMgJOX2OPtaF2wRCDDgIfJoEQuN5M=;
        b=taZqSyHA82BJwAVOF7PLTOw+KSWEfDg/GoFiv4+lMl5sYeC5h5g4nuxdktkWNaD7Dw
         vii4QM9z2eT4I9M0gk/yzm0dwHNMtYfikGXIAU3tVMMdl9AAAmUJEMU7IO8MwCGofaNG
         Gg0FseZnNkpxwuhtVSDPJMbweRkfhuW6jv5IvM2vHqZQG0repkuUCaSuweGwsj2u8vpD
         mY5P0vCAqPE16FGUehIoPJwseVMq+lb2Y6sVdnbPrV/eD+yRougWkNd2uF0CU3co+Itd
         pJVyUMvqJzVUlMylEkatL+zePlwthQaYu6CloH6HgERxBSeOqieaE/z0m4oZUhp+z5yy
         1mWw==
X-Received: by 10.68.232.104 with SMTP id tn8mr70176346pbc.155.1441304317989;
        Thu, 03 Sep 2015 11:18:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id y5sm23320138pdc.4.2015.09.03.11.18.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 11:18:37 -0700 (PDT)
In-Reply-To: <9986CCDA-DB0B-4D7E-B758-668A46010188@gmail.com> (Lars
	Schneider's message of "Thu, 3 Sep 2015 19:24:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277237>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 03 Sep 2015, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I'm tempted to suggest squashing the following in.  Thoughts?
>
> OK. The diff looks good to me. For some reason I can=E2=80=99t apply =
the
> patch though. git patch gives me "fatal: corrupt patch at line
> 10=E2=80=9D. Any idea? (I might do something stupid because I am not =
used to
> patches=E2=80=A6)

Sorry, but no idea.  I just saved the message I see on the list to a
file and did "git am" myself and didn't find anything.

Line 9 of the patch is a removal of your overlong test_expect_success
line, so if that were somehow line-wrapped by something between the
list and your "git apply" (e.g. with your MUA), it is very probable
that "git apply" would see there is something funny on line 10, but
line 5 (a hunk header "@@ -21,15 ...") is also rather long, so...
