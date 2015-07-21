From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Tue, 21 Jul 2015 12:41:37 -0700
Message-ID: <xmqqa8upuwlq.fsf@gitster.dls.corp.google.com>
References: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
	<55AE95EE.1080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdQ8-0001lu-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbbGUTlk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 15:41:40 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33441 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbbGUTlk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:41:40 -0400
Received: by padck2 with SMTP id ck2so124672601pad.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=qclseFC9NKZvijJwc6D1FT0zoMamzZd0L4oMmf6T+bs=;
        b=xnBOIY5/+/YLRW4k+lb5jptgn/2pONAChB/5KXTAuTYs1vNX+JO6H3F99FTMC/1yqc
         4RW4wsCtY3/z3AA3lJrmzxL0iTAibnJzzAXVfbxz1Px17nOgPwRRn8maqK2E22JNYwJD
         F9QMW7SXBlcHPND0oJUgOdM2IU/XhAioxHmjTbjBpZQxxE227L5zIH1gWZzq5ZgfIwCu
         DxMTTg+UdnbfN1l4vtFV0O+JfJ5hRdHc6V/t9nnHlrziZSEK2ZlayspdXwe6/Z6ww9Oy
         rP39MHdjJfP2I4iLYtzSBnjGUFy7uMtGniquXOdiVXl/yxWcXRjZSWtwW19Idm435pzK
         dPaA==
X-Received: by 10.70.140.173 with SMTP id rh13mr77332589pdb.24.1437507699589;
        Tue, 21 Jul 2015 12:41:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id bd5sm11227475pdb.41.2015.07.21.12.41.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 12:41:38 -0700 (PDT)
In-Reply-To: <55AE95EE.1080500@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Tue,
	21 Jul 2015 20:56:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274404>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On 2015-07-21, Junio C Hamano wrote:
>
>> --------------------------------------------------
>> [Stalled]
>>=20
>> * sg/config-name-only (2015-05-28) 3 commits
>>  - completion: use new 'git config' options to reliably list variabl=
e names
>>  - SQUASH
>>  - config: add options to list only variable names
>>=20
>>  "git config --list" output was hard to parse when values consist of
>>  multiple lines.  Introduce a way to show only the keys.
>
> Errr... isn't it what we have -z / --null for?

Yes, but try to read that from a bash completion script ;-)

>>  Adding a single --name-only option may be a better way to go than
>>  adding two new options.
>
> But that is a good idea anyway.

Yup, I think that is where the discussion ended, IIRC.
