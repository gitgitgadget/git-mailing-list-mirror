From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 01/12] t5520: implement tests for no merge candidates cases
Date: Thu, 7 May 2015 22:47:02 +0800
Message-ID: <CACRoPnSCvitGfVKyqV7PJd_TzLJEs8U_mjYhaRy3KOFrWjBEwA@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-2-git-send-email-pyokagan@gmail.com>
	<554B2AEB.3020608@web.de>
	<xmqqh9roscty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 16:47:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqN4w-0004O3-69
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 16:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbEGOrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 10:47:04 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35920 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbEGOrD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2015 10:47:03 -0400
Received: by lbbqq2 with SMTP id qq2so32745104lbb.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2bug84MxeCh5Glgvp+xPbzIqxjyAC17nNamWi3QWZhI=;
        b=z1r/AuijPy/1TN9f52P+lYpHACYp8SrjBn3zGDA7HbvVWGKGk2bvbWQp5WV5vd/QLu
         9XEwPDchcDx5tdPjOfkKp7M3Q+Qr95BQWEiJJDiRDnqiUKIovxf+AM0okra1YSLAr0kC
         4E5zVi6xDJhqFOw79FnUy17LbYYBgwTUa5hSS78yHpepAa0IX7oqIweOFVCiubNkW72+
         2xWjNugenyKCTbH0NAweiVtNsMOea7jIixWSId2TYTPXoLYD34yorQOb9PYNYGe1DBLg
         Z5dW8CWmokA2zfS7mTsNurPhnsfcG+GiyNEDLf7Pl1sJaZMHM++GJu+nuTcccPdHg/p+
         hVzA==
X-Received: by 10.152.87.204 with SMTP id ba12mr3408643lab.35.1431010022122;
 Thu, 07 May 2015 07:47:02 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 07:47:02 -0700 (PDT)
In-Reply-To: <xmqqh9roscty.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268533>

Hi Junio,

On Thu, May 7, 2015 at 10:04 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> In other words:
>> test $(cat file) =3D file &&
>
> Is there a guarantee that file has a single word?  Can it be empty?
> Can it contain "foo bar\n"?

It can, but it should not ;-). But yes, this will need to be quoted as
well to be safe. Whoops.

Thanks,
Paul
