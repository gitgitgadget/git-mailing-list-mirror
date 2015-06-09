From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] status: differentiate interactive from non-interactive rebases
Date: Tue, 09 Jun 2015 11:07:20 -0700
Message-ID: <xmqqy4js7o2v.fsf@gitster.dls.corp.google.com>
References: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433860962-13222-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<vpqbngp3oxy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guillaume =?utf-8?Q?Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2OLH-0003bT-GY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbbFISdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 14:33:40 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37295 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbbFISdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:33:38 -0400
Received: by igbsb11 with SMTP id sb11so17135523igb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=S/n2K8hMWpExXnk/bVqm1dE1bYoqPUAjm5M/kXSpbps=;
        b=pcfCQGEyjhxVWvOAy6PWIhgmw9lizTFTnlMNeczWFMWqovQSaxz7CjBXQS5Fa+4ESC
         kPSCwgRycZ1dUvN6Qva1ElGvPEF1ROBxfN7zDOMZNwDAkGk+cbu4sPJd75Hee3Tsxzkw
         hRkRe1QLRje2oUiqw0B/f5UQuRN9uc7xX8fQmq6tUeYZjX8juzStjcDm490X04jK8Beu
         lGw1rrD1Oiu+/le6G67pbAm+OBOKfc1tLTZ5+TKn6Lis+xb56+0CEVnpIhtktYDS+wjW
         lP+HN/ze9eRfmq3Yvf2h1LvleVTTxhgsj+fb14MczHJ53QSWWVoihEXjS2lNHK3frzk3
         qdtQ==
X-Received: by 10.42.119.83 with SMTP id a19mr9524icr.83.1433873242066;
        Tue, 09 Jun 2015 11:07:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id q10sm1603885ige.16.2015.06.09.11.07.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 11:07:21 -0700 (PDT)
In-Reply-To: <vpqbngp3oxy.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	09 Jun 2015 17:02:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271221>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr> writes=
:
>
>> Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenobl=
e-inp.fr>
>> ---
>>  t/t7512-status-help.sh | 28 ++++++++++++++--------------
>>  wt-status.c            |  5 ++++-
>
> Are there any change since the last version? Please, help reviewers b=
y
> anticipating this question and versionning your patches ([PATCH v3 2/=
4]
> in the subject, git send-email -v3 does this for you).

Plus, it would help to say something like "no changes since v2"
after that three-dash line before the diffstat graph.

Thanks.
