From: Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [BUG] - git-read-tree segfaults
Date: Wed, 11 Mar 2009 08:59:06 +0100
Message-ID: <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
	 <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhJMl-0002Ki-UW
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 09:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbZCKH7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 03:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbZCKH7K
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 03:59:10 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:50592 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbZCKH7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 03:59:08 -0400
Received: by ewy25 with SMTP id 25so1555615ewy.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S4FH/8pzCNIPE38zI5Qwv98Ml2mCLMAQ+Sb79rTnl5c=;
        b=cWlUA+TcuXiGcHEcuB5HPYGDzCHNYLMSKKTeTHUb/V8UL7jEVR+TQnjg/4i7g67MOj
         5q39UHZgvvWUPYj7UTKt6YG7Tzzr8KdeOSJozdTi6Nm7F5YCpZ+jiLnPEury600o4Uhu
         sRZYvuW1C9jNA1i2UvJpT4ODIiDf/U8/GnD7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q5xDR6zHBp8Ttmc6XBX4EZpB5aqffw9dtb/A8HxMCp4YYbg8UlZI+7+evR7+5I6eQz
         yb5P/4lcm4TuCVcSw2bnAnGiBX74gWVGegP0r93Trfy1q6kX4DY/E977orulZgYiJxfO
         qUM0UajR8fk8VezdDSvurviLq7B/KjR0B7VME=
Received: by 10.210.66.1 with SMTP id o1mr4201896eba.16.1236758346210; Wed, 11 
	Mar 2009 00:59:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112891>

On Tue, Mar 10, 2009 at 9:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 10 Mar 2009, Jiri Olsa wrote:
>
>> mb=3D$($GIT merge-base HEAD yyy)
>> $GIT read-tree $mb HEAD yyy
>
> While I agree that it is a bad thing for Git to segfault, I think thi=
s
> here is a pilot error. =A0You try to read 3 trees at the same time, b=
ut not
> perform a merge. =A0IMHO you want to add -m at least.

agreed, I've already said I executed it like this by an accident...
it was easy to recreate so I shared... I'm not saying it is a show stop=
per :)

jirka

>
> Ciao,
> Dscho
>
>
