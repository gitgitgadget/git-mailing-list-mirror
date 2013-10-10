From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git-related-0.1
Date: Thu, 10 Oct 2013 18:04:13 -0500
Message-ID: <CAMP44s0CpqaBndtbwBiGaQo4PF2=tRTNO+L_rx38wnyuwivDZg@mail.gmail.com>
References: <CAMP44s0wPzV6FkfON4zazkOWqTB0qbpdEtruHD01NybtiK6-Og@mail.gmail.com>
	<CAH5451=LPy5ybu6n457NPcnf=Bbsv4jNyiO6ve=-T0qXJwq_bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 01:04:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUPHI-0004gP-0r
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 01:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab3JJXEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 19:04:16 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:39981 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab3JJXEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 19:04:15 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so2682211lbi.24
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jDE3PazxCCUxTaMB/4oqzFDyzUkcN+Q7JFRfY+jPbeY=;
        b=xoC/fInVidtOrtUDPKxWfWy/smeMFNdcWfkhi/f5JxqNcfUwn++ekaWaGi5sCPjTLI
         GoBW2qNQqeBvF9clgcLw4C4dd623QN1GbWVUyaZJqV5S1BPyl7DAhj3S/koTz1J/d2GE
         21f2Te5crhwJkauCT7pGgQ4+1pKzVcJ8YaMVa4H0IuUTsuk4BaZHd43VAGnjvgJF7NNK
         zhcQbgWuCQ0AMHAL28wT07pJ/h4xkUb4mFiYR/RzdG8Pf7oe071JOGegVUBVuYgkFj2r
         p/J1B+dQeFJchsjxA2+I6433RJt2yvqtdcpQK5sLG6D4FDlzIbEIv8F7VcGpCTD/9Flm
         yIbA==
X-Received: by 10.152.203.233 with SMTP id kt9mr13398061lac.29.1381446253986;
 Thu, 10 Oct 2013 16:04:13 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Thu, 10 Oct 2013 16:04:13 -0700 (PDT)
In-Reply-To: <CAH5451=LPy5ybu6n457NPcnf=Bbsv4jNyiO6ve=-T0qXJwq_bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235890>

On Thu, Oct 10, 2013 at 5:24 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 11 October 2013 08:43, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> After gathering all the relevant
>> people, it groups them to show what exactly was their role when the
>> participated in the development of the relevant commit, and on how
>> many relevant commits they participated.
>
> It looks like you group by emails, any idea if anyone purposefully
> uses the same email but a different name? I don't know if the email is
> assumed to be the unique identifier, or if the name/email pair is,
> however I think the typical use case is definitely to group by email
> so it's a useful default behaviour.

Yes, I think I described that in the announcement. It was a feature
somebody requested, and it was easy to implement.

>> They are only displayed if
>> they pass a minimum threshold of participation.
>
> Out of interest, how is the threshold determined and is it configurable?

The threshold by default is 10%, but it's configurable with --min-percent.

-- 
Felipe Contreras
