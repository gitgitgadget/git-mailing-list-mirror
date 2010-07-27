From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing 
	test
Date: Tue, 27 Jul 2010 17:08:32 -0600
Message-ID: <AANLkTikZO=RENz9HnHsiPoAv+fSz03p-zZPMepcX=KKK@mail.gmail.com>
References: <1280249698-11001-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 01:08:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdtGI-0000zr-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 01:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab0G0XId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 19:08:33 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56024 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab0G0XId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 19:08:33 -0400
Received: by qyk8 with SMTP id 8so3048870qyk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6fMGAaA1yPxZcJMLoESX9WYBle6mIPsCb/sMlxNT03c=;
        b=eq2jMyCgbZTZs6ibAmINcZFYJRBkkA2WfzwY+gveAaRds9P7x7Ofdr6FbZKApZ63R0
         7r8VgekWtOXugKcvbGtWSdmjGdU5mN4vXfErcM8n/UitMpR4NZoBzeIaiYV0HauwhGS9
         9HuJynyovEIeSdB45y+uwdWrspL/QwoOCKkik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oHkjG2kujMB3pUaoIVes/gjLE+Fm+4U7EO6KTZTJ4Qfk/IHHeqvNFJIEope9Ub3fy7
         aKFUOR/QP+3RLw1tlWJwKPl/2ThdpHn0S19yqZf/bmUrgZYNPlLWSeBaJspgnDXe1htf
         SLzCjoV0rwvBf/gmcpCd6y1tnZwnqPj/lGucw=
Received: by 10.224.66.88 with SMTP id m24mr8127586qai.217.1280272112283; Tue, 
	27 Jul 2010 16:08:32 -0700 (PDT)
Received: by 10.220.97.15 with HTTP; Tue, 27 Jul 2010 16:08:32 -0700 (PDT)
In-Reply-To: <1280249698-11001-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152014>

Hi,

On Tue, Jul 27, 2010 at 10:54 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> Various merge-recursive cases were fixed in "merge-recursive: Fix D/F
> conflicts" by Elijah Newren. Some tests were changed from
> test_expect_failure to test_expect_success, but one fell through the
> cracks.
>
> Change that test to use test_expect_success.

Weird, I know I tested all of these individually and worked to make
sure they all passed; I have no idea how I would have forgotten to
update this particular test.

Anyway, thanks for cleaning up after me.  :-)
