From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Special characters in file name
Date: Sat, 3 Sep 2011 09:46:17 -0500
Message-ID: <20110903144617.GA17893@elie>
References: <4E60C6D0.7090609@intland.com>
 <loom.20110902T143646-347@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Tajti =?utf-8?B?w4Frb3M=?= <akos.tajti@intland.com>
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Sat Sep 03 16:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzrUQ-0000pi-8k
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 16:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab1ICOq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Sep 2011 10:46:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42784 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab1ICOq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2011 10:46:28 -0400
Received: by iabu26 with SMTP id u26so4203036iab.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F5rqYTUgJZgwuWZUBTHm4Ic/KkfzYkutC1iwVVLkSao=;
        b=UQ8etDNZjlWzKmcsY/oqhsDsv+0xb/GuJH6KCgVtgo6r7N4360UXnlIrAYDnjXtFJz
         DOhM8GPaJJFbpJs2pk930oTIdexAS5UerwizSbTafYePsQlOx+QDlqPYJGSeYIPtRnhM
         RyfoPY3SSeBtUASwSdINNoNeSBfdTLXw0ouik=
Received: by 10.231.8.195 with SMTP id i3mr4191209ibi.10.1315061186537;
        Sat, 03 Sep 2011 07:46:26 -0700 (PDT)
Received: from elie (adsl-76-193-160-165.dsl.chcgil.sbcglobal.net [76.193.160.165])
        by mx.google.com with ESMTPS id n14sm4253278ibi.4.2011.09.03.07.46.24
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 07:46:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20110902T143646-347@post.gmane.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180654>

Hi Alexey,

Alexey Shumkin wrote:
> Tajti =C3=81kos writes:

>> I have a file named "=C3=A1rv=C3=ADz.txt" in my repository. When mod=
ify that file=20
>> and execute git diff, the first line looks like this:
>> diff --git "a/\303\241rv\303\255z.txt" "b/\303\241rv\303\255z.txt"
>>
>> Is there an option that (if specified) will get git to print "=C3=A1=
rv=C3=ADz.txt"=20
>> instead of this escaped string?
[...]
> please, refresh your memory )))
> http://comments.gmane.org/gmane.comp.version-control.git/177849
>
> see my comment
> http://permalink.gmane.org/gmane.comp.version-control.git/177857

Cc-ing =C3=81kos so he can actually get your message this time. :)  (FW=
IW
the convention on this list is always to reply-to-all.)

Thanks,
Jonathan
