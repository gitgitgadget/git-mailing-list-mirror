From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 08:42:51 +0700
Message-ID: <AANLkTin1SjEzBnLd-HK9fANShLezAKHAOai9MyF-cuoT@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082047.44022.jnareb@gmail.com> <AANLkTi=AyCxn=dcKQQmT0_6Oc36AX6XDA4Dhhk7WLSN0@mail.gmail.com>
 <201012090144.19858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVYO-000282-Tz
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab0LIBoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 20:44:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60476 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab0LIBoC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 20:44:02 -0500
Received: by wwa36 with SMTP id 36so1882895wwa.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SyH5JcmKj6fCVFv8PU46nBJlOy0WRk0IOTKBXq78yoo=;
        b=bZAOcnA9fILtIofQai02C7VWv5YnRxXn1D1pjrZnJFidY31p+AE7WwD4XHcxer/bcG
         xalPvoMIznUZLOanJ85lqMW8W7G73faQcVx3gvOnJ/5TjwGwuVfdD2QcwfpNjjpCNgGD
         E5UPbLpsNyJmv/6wtZM1QPiG8iYufUwQGegLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UgizHuV0+jKhfijLw0zF9Q02+NhAdhqik/KJPIt9Dci/3Y1PLzG9uMsZU+NrzXlDCP
         RH/4h33T5yoJNm5vpcRBEXrLl/E9ZTUbWDou66kSLAl/YbODVrglyWE5tpRaVihXiJby
         L9CnrVVq3AQivElSVQWasVlGBJqgKS1uxqyQo=
Received: by 10.216.162.70 with SMTP id x48mr13350wek.4.1291859041278; Wed, 08
 Dec 2010 17:44:01 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 8 Dec 2010 17:42:51 -0800 (PST)
In-Reply-To: <201012090144.19858.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163253>

On Thu, Dec 9, 2010 at 7:44 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
>> 2010/12/9 Jakub Narebski <jnareb@gmail.com>:
>
>> > I wonder if it would be possible to make :/<regex> (which looks a =
bit
>> > like searching the index) to be an alias to --all^{/<regex>}...
>>
>> It looks a bit strange to my eyes to merge normal option name with
>> revision syntax. But I think it's possible. Do we allow branch/tag
>> name with leading '-'?
>
> Well, with below proposal it would simply be
>
> =C2=A0--all ^{/<regexp>}

This hardly works with range and may conflict with "--all" being
already used by some commands.

I think we can move '/' out of {}, the space between '/' and '{' can
be used for optional parameters: ^/{foo}.
--=20
Duy
