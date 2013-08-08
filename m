From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 8 Aug 2013 20:43:53 +0530
Message-ID: <CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <52027B17.7040602@googlemail.com> <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com> <vpqfvukdy39.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 17:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7RvD-0003Ix-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965784Ab3HHPOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:14:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33567 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965745Ab3HHPOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:14:34 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so2024648ief.40
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C8PY8jjZ/qgH6hL49CcN4SXJ11Zk2ut/X79pmoPrAyU=;
        b=ceWDj1cFtCH7EVN8qXh90AMRywKzhyBnINYlNHtroAMTTHzoPaLGgwi/N/HuZ/PAnF
         AJXA7ZfSVjYIVklbKfsfh2osaknTI4pWcwqq9xkl6kvfCUf/PNtcjKrXfznfS+vx840D
         WrwhKtCFCbf3/tvIGcgANGkMxUlJbreIAPl1GtfRcXiMIsRL3WpENOXNoUaPJz9cLw9H
         yAIleNki6/E0wZgV8RJx703VqayN86xcfRMnrthtbxRWRl1jY7ylAK7WNcCWRVcdIdMB
         XFhK/SwazZbruLAteXATmCWDLoQrHTlHxMyCMiHB5Pc1wfcz1z9AoEawqNpaSes8lzzJ
         RbPA==
X-Received: by 10.43.88.3 with SMTP id ay3mr2276319icc.61.1375974873954; Thu,
 08 Aug 2013 08:14:33 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 8 Aug 2013 08:13:53 -0700 (PDT)
In-Reply-To: <vpqfvukdy39.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231894>

Matthieu Moy wrote:
> ... but I do agree that the doc is really confusing. It would be much
> better if the doc could be reduced to:
>
> "This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
> Please refer to the documentation of that command."

I don't think there's an exact correspondence with any combination of
command-line options. Perhaps we can describe it in words, and ask
people to use log instead?
