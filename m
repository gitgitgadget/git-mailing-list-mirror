From: Eugene Sajine <euguess@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Thu, 2 Dec 2010 16:07:20 -0500
Message-ID: <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
	<7v8w07rje3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 22:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POGNE-00035e-4l
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 22:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab0LBVHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 16:07:22 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56901 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454Ab0LBVHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 16:07:22 -0500
Received: by bwz15 with SMTP id 15so7662662bwz.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QeHlUk5v2Bk3Fy0dXQvaNZu7k4h9Gg1uOzMsxTYzOCw=;
        b=l0tM1vo46MiAKN+vgDxbSgBkcUxQ+T1Ptfum4niCsPXNoCbGb80fvnTKlS5FWwJEMa
         8AWtJMi60rBl8jWW8fActfGalKIesOMDBFebA/n08tPi8NtKZt15TtkgzEZewQS+/p0v
         71Yl5LNnY9gIwgiS0Dg8CY/PQE61Pecj+Xvhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ngM2k7FWvDeodfCTDQ0venyfg4TxH6k2o1z6HL+lmxTD2M2V4nqWYB0FNKVTuEgybG
         M4GZvrXxolWZJVBHBvvYOUZtBhy/jpi2nDiMBCsEbAfqk6Cj10ah8PXYgZ8fRNKF8dvE
         iLpQTmzAEBGpJIk+e5UeF3OnjyvHU6uTlj4SQ=
Received: by 10.204.66.204 with SMTP id o12mr1462929bki.29.1291324040288; Thu,
 02 Dec 2010 13:07:20 -0800 (PST)
Received: by 10.204.152.206 with HTTP; Thu, 2 Dec 2010 13:07:20 -0800 (PST)
In-Reply-To: <7v8w07rje3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162746>

On Thu, Dec 2, 2010 at 3:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> I have a strange issue (git v 1.7.3.2). I'm cloning the repository,
>> navigating to the folder containing some scripts and performing
>> git hash-object <one_of_my_scripts>
>>
>> Then I'm trying to run:
>>
>> git log --raw --no-abbrev | grep <resulting SHA1 from previous command>
>>
>> And i don't see anything.
>
> Do you see it in the output from "git ls-tree -r HEAD"?
>


yes. I do see it with your command.

git ls-tree -r HEAD | grep <resulting SHA1 from git hash-object>

Thanks,
Eugene
