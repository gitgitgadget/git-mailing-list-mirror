From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 18:22:02 +0200
Message-ID: <CALWbr2xxND4xz49jmwXUTTr1f=Z3nmHCTQd+bBcK_Etv5oB0Fg@mail.gmail.com>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
	<20130524161243.GB2104@goldbirke>
	<CALkWK0n8iuwNHfxV4AHUV+721pqLUOPhM6h+e0_opmkVuOV_4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:22:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufukz-00088E-Of
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab3EXQWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:22:05 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:49564 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab3EXQWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:22:04 -0400
Received: by mail-qe0-f54.google.com with SMTP id i11so2710974qej.13
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JrKujrDcBPTjefn2Fmu2KT50GZ0Fl91rX6N7d9fWKsU=;
        b=YgqFSpouMoVdxCWJcXiwhzwrnrnFpGHJLGYTOofZPTkmlpEbvUEPuFrrF4ukFJLv2J
         cIlzrPfm5tWiAJLTP7aphuNaXKYJ3wTjFODOMGlEbuXLav1iZAezfMJBQAJAF+BXwaRB
         4oN9wlTEghEhZs70jCI1qYFwFXNKThWL5Od7K8M2K7UwZzet0E/Wvlv262laYIvTa7zv
         qAU0jCNb5PgB07nhv2q0E3MJngxnJQ6eBmETCS3J2MFCDl6Djl1Im8JkjBvqx6RekA/u
         RPicc11cd3aLMNHNhrRX+6i+HpViIDAUVUXPaiFxYWW+IhXRG0QTEomsF8Z6TEpxDLZH
         3Ahw==
X-Received: by 10.49.96.104 with SMTP id dr8mr12174459qeb.43.1369412522807;
 Fri, 24 May 2013 09:22:02 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Fri, 24 May 2013 09:22:02 -0700 (PDT)
In-Reply-To: <CALkWK0n8iuwNHfxV4AHUV+721pqLUOPhM6h+e0_opmkVuOV_4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225375>

On Fri, May 24, 2013 at 6:18 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Damn; so it's impossible to have a custom-sorted completion list in
> bash.  Any idea about zsh?  I know that there are completion groups,
> but I'd really like custom sorting.

I think sorting is required for faster look-up, most likely with
dichotomic search. Otherwise it would have to search the whole list
each time.
