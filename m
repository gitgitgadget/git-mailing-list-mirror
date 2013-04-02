From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lint-duplicates: check numbering in contrib/remote-helpers
Date: Tue, 2 Apr 2013 11:46:05 -0600
Message-ID: <CAMP44s05-H23pEhxtZq76S5fqTsf5Uxs1UVpPypvXnbJkeCnRQ@mail.gmail.com>
References: <201304021853.48643.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, apelisse@gmail.com, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5I6-0003N7-LE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304Ab3DBRqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 13:46:09 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:43886 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317Ab3DBRqG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:46:06 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so750309lbd.38
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=6bRpVxDOy5EbFCWzlPFdtZiuaEplVfuFEZq9DopJAdo=;
        b=NLuBfgMILB+I7LlOs92wDZ+V2GXtMVPwAbNJ8zU3Mc2Wtec+Us+niG0FSStjEAEefP
         fnSHEpc2ihtOr4PLpTf1jOQXdbLMcbytNBZQf6Srp3SS3hzHIVu9U6AL0Ev+RLet9b4t
         O2kFITiGC9L1kZCRu99laUGa4yR7Tr1kuVXkmRLba4w1yhYlQE5txcRTPdeP8yFQfUec
         j6bHedoKpDnuIMigkCFwEEneZm54osREoJ6wsTeFQwDDMdhDl9lyiFfFehYbLY2iuYKb
         rhaEmZ20tLNLTNkSPcJNLiOjRLwsHIlp4wimLFFqUmp7RnHnJUXtKyCpm0x8VocdIxVL
         9KFQ==
X-Received: by 10.112.143.10 with SMTP id sa10mr4115741lbb.36.1364924765388;
 Tue, 02 Apr 2013 10:46:05 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Tue, 2 Apr 2013 10:46:05 -0700 (PDT)
In-Reply-To: <201304021853.48643.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219818>

On Tue, Apr 2, 2013 at 10:53 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:

> Rename the tests in contrib/remote-helpers into
> t5810-test-bzr.sh,
> t5820-test-hg-bidi.sh,
> t5821-test-hg-hg-git.sh,
> t5830-test-hg.sh
>
> Feed the numbers used in contrib/remote-helpers into t/Makefile
> and check that numbering is unique across both directories

TBH I don't see the point of this; we don't *need* to run
test-lint-duplicates here, the system should adapt to the situation,
and it already does, no need to add four digit numbers just so we can
run test-lint-duplicates.

--=20
=46elipe Contreras
