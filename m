From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 01/19] Add struct pathspec
Date: Tue, 14 Dec 2010 19:50:53 +0700
Message-ID: <AANLkTikR_AGCH-UaTo9pNtKQxq=Nc4=p8xaMkj22503u@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-2-git-send-email-pclouds@gmail.com> <AANLkTim+6d+XZ7j4pxE+WwBCsAvcZfN2qYu4=1rs6AAn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 13:51:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSULp-0003i2-Uc
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 13:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758984Ab0LNMvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 07:51:25 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39110 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab0LNMvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 07:51:24 -0500
Received: by wyb28 with SMTP id 28so441106wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 04:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yX3wQv2aK1hiMrUB9spIzjFMltdUcQgwHOTwQp7IBe8=;
        b=bveo4ujUl9GDTneuR3zvLdzagcx2rIza68TGIyb9CVuEtIrqhfy9mHGi2saHWQvtrs
         yOE9Gxnh1gqRu7gLI9d4gNkhBd3Z/ECHtfp1tvsNtfmI0iysRpQwzl6liSCW6qzx+AGU
         OPvTwjDH6fgHGY/pj8UoJSFzo40zEPHbkB91g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h/Z95Vevchg0WY1AvpzoGExqDtQC089BTiqQIZ7d63xhjUOCuFmMLxYBdjBdvQnadh
         w4TKPQ832Iuz125AR7lGNw/ug9K5vrSwaj9ydUgcRr4HB26AhhNrInYR69omLYvEGLkY
         yCeEZQFf+4FFvotrZEzas3PDmk+uogVnxjXo0=
Received: by 10.216.169.71 with SMTP id m49mr5961420wel.4.1292331083265; Tue,
 14 Dec 2010 04:51:23 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 04:50:53 -0800 (PST)
In-Reply-To: <AANLkTim+6d+XZ7j4pxE+WwBCsAvcZfN2qYu4=1rs6AAn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163645>

2010/12/14 Thiago Farina <tfransosi@gmail.com>:
>> +void free_pathspec(struct pathspec *pathspec)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 ; /* do nothing */
>
> Of curse this ; here is not necessary :)
>

Well, can't please everyone [1]. It's for clarity only.
free_pathspec() becomes real in the next patches.

[1] http://mid.gmane.org/7vbp7ix20u.fsf@alter.siamese.dyndns.org
--=20
Duy
