From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Documentation: update description of shell aliases
Date: Thu, 2 Jul 2009 06:27:19 +0530
Message-ID: <2e24e5b90907011757r498b8c52v4cf5dfb7016bf8b5@mail.gmail.com>
References: <2e24e5b90907010900r23ddc8dfl67dee569b508a4b7@mail.gmail.com>
	 <7v7hysl0x8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 02:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMAcY-00037D-7B
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 02:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbZGBA5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 20:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbZGBA5T
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 20:57:19 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:38847 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZGBA5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2009 20:57:18 -0400
Received: by yxe26 with SMTP id 26so1872156yxe.33
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OJ7CZHRhFzEzeDjJLr98psPbdSSdvXJVcQecCbFUA00=;
        b=RHppconk1YAz+NmgTqrm8G2LgA+W0RMWCdHnotnM5iYQqEBr7Int6N5Tu9FWd0hqZp
         ogtWUmNbStlzv84/fEqx3AWV6Llw9VXhErPZmgrSyal7ke0JmSF40qYuiOlnikVsCbO/
         4QcxDRXSstCm9ybZyjzqk4t8GZBklvBJrPTTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WQBLfHZv0wdO/jGC4obO53uceZGaylqaEZEqCnbPfSY5PjsSK3mE1H1yyLV/0w9Vm/
         V5IH29weXqN9j8J3uhqXyJii777oJciyF6+E9YktQv09Oohr0Wi+aldDoBa5nCj92EfP
         Z29DPT6A59UxbI/zyUWO6xxgkCbo3uocARTAE=
Received: by 10.231.10.137 with SMTP id p9mr2911933ibp.52.1246496241239; Wed, 
	01 Jul 2009 17:57:21 -0700 (PDT)
In-Reply-To: <7v7hysl0x8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122615>

On Wed, Jul 1, 2009 at 11:51 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Aliases that invoke shell commands start from the top-level director=
y,
>> but this was not documented.
>
> Could you please also think if it is worth mentioning what happens wh=
en
> you do not even have a top-level directory? =A0I.e. in a bare reposit=
ory.

Yes I thought about it.  I decided not to add that because
it is:

  - not common enough (how many new users fiddle in bare
    repos?)

  - not surprising enough (I did test it; it just uses the
    current -- bare -- directory, as even a new user would
    expect)

(In contrast, the part I added _was_ somewhat surprising.)

And if we go that far, why not also document what happens
with various combinations of $PWD,$GIT_DIR and
$GIT_WORK_TREE?  I did not get a chance to test those, but
if you think we should add those also, I will do so and
document what happens.

I just think it may be a bit overkill, but if you think it's
not, and it adds value, just say so and I will test and
document it.
