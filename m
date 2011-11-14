From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Compile warnings
Date: Mon, 14 Nov 2011 22:55:24 +0100
Message-ID: <op.v4yhummo0aolir@keputer>
References: <op.v4xyekju0aolir@keputer>
 <CACBZZX6d_ykc9CbN7H-ACWNUxACb9+TH4ffJ-+9T=SEv6Ai0Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjar?= =?utf-8?Q?mason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 22:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ4V2-0001HC-4a
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 22:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab1KNVz3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Nov 2011 16:55:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51623 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1KNVz2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2011 16:55:28 -0500
Received: by fagn18 with SMTP id n18so3508120fag.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 13:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=c2nrERbS4gM3VgcxNBj/1n/eCaAaz0OGJfIBrSX5GYw=;
        b=tp2bG/KN3zJ6kGt+eDDmeOuCF330UuRBXR1SyAsCxc374MRFywpo9ZY3u6202G/kkr
         m3oSGuma5NtGMa+k8QkaI16HjqWA6miUe4DUG8AWOV95xXp5KQb5sNq/4JBEKNZKBA8z
         A60DxvPO+pxAX9owX6Lfp8gctKQ6VuSSsPc8M=
Received: by 10.14.11.10 with SMTP id 10mr1809675eew.112.1321307726935;
        Mon, 14 Nov 2011 13:55:26 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm63359680eef.9.2011.11.14.13.55.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 13:55:26 -0800 (PST)
In-Reply-To: <CACBZZX6d_ykc9CbN7H-ACWNUxACb9+TH4ffJ-+9T=SEv6Ai0Ug@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185407>

On Mon, 14 Nov 2011 17:58:20 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son =20
<avarab@gmail.com> wrote:

> On Mon, Nov 14, 2011 at 15:55, Frans Klaver <fransklaver@gmail.com> =20
> wrote:
>> Every now and then I see an 'unused result' warning come by during =20
>> building.
>> What is the general attitude towards these warnings? Remove them (by
>> properly checking)? Or leave them be as a kind of documentation -- w=
e =20
>> know
>> we're ignoring the info, but it's good to be reminded?
>
> Under what OS / version and compiler / version and what's the warning=
?
> Paste the full warning(s) you get verbatim.

This question was triggered by

     warning: ignoring return value of =E2=80=98fwrite=E2=80=99, declar=
ed with attribute =20
warn_unused_result

appearing in diff.c, graph.c, grep.c and several others. I'm using gent=
oo =20
linux, gcc 4.5.3.

So the specific question would be, do these fwrites need to be checked?
