From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] make-static: master
Date: Mon, 12 Sep 2011 11:44:16 +0530
Message-ID: <CALkWK0=TovazpdOvS_va7L0Fv=HcAc9x1-f+LEH_mXgKa-wCQg@mail.gmail.com>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk> <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 08:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2zp8-0007hd-TO
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 08:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab1ILGOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Sep 2011 02:14:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33931 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab1ILGOi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2011 02:14:38 -0400
Received: by wyh22 with SMTP id 22so3123763wyh.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RhTmjAjU1bIiVxAnBYSORfKLimUijDBX98DKnPG+a/E=;
        b=SHCOiYdovtBeqHlHgQOkMF5wAXNNGt3j/Dr52suIxS8P0FArziuC6XmNxCbSMWHHxo
         I2I9on4PqSbWSSU+hYXVQugLyLMf07RB/31OwdrBhKZeLq1+6dHG29EM3jRd73tXvgF8
         +WgeooR5LpPS1NVZkBWIK8Cp2WeEz0SJJLSfA=
Received: by 10.216.186.205 with SMTP id w55mr2547474wem.102.1315808077074;
 Sun, 11 Sep 2011 23:14:37 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Sun, 11 Sep 2011 23:14:16 -0700 (PDT)
In-Reply-To: <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181209>

Hi Junio,

Junio C Hamano writes:
> Many symbols that are exported to the global scope do not have to be.
>
> Signed-off-by: Junio C Hamano <junio@pobox.com>
> ---
> =C2=A0* To be applied on top of 3793ac5 (RelNotes/1.7.7: minor fixes,=
 2011-09-07)
> [...]

Awesome!  I've seen many similar "make-static" patches come up on the
list, but turned down due to code churn issues.  I'm happy to finally
see it being merged.  What does this mean: should we try to get such
things merged immediately after a release?  On a related note: I'd
also like to know if we can do anything about restructuring the source
tree (moving files around, renaming etc).

Minor nit:  I can see commits with "Author: Junio C Hamano
<gitster@pobox.com>", and "Signed-off-by: Junio C Hamano
<junio@pobox.com>" on both 'pu' and 'next'.  They seem to be different
people at first glance :)

Thanks.

-- Ram
