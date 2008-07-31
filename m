From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Merging submodules
Date: Thu, 31 Jul 2008 21:03:26 +0200
Message-ID: <8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
References: <20080730230336.GA6481@Hermes>
	 <20080731092104.1a6ce8bd@pc09.procura.nl>
	 <20080731143955.034f0577@pc09.procura.nl>
	 <20080731130626.GQ32184@machine.or.cz>
	 <20080731170123.79e0d3e9@pc09.procura.nl>
	 <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
	 <20080731201530.067be667@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdSD-0004kj-SF
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbYGaTD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 15:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757300AbYGaTD3
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:03:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:47441 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbYGaTD1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:03:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so422758ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vhy7rEeTE0rnXG6pRzKx7JVKBROSmzt06HwVwiZL/R8=;
        b=Av8MDpeXDey9AV8Z25BsJBm1V0aEV7x3i7f6K7UdBJ8/OWFXyngwIlA4kHIV2+o5Ss
         I5DPQ2XWkeM4vu8whmI3gVuOqlgiYlHhPlNQVSnYomrfRpA302iug5aVkU6kbD/Seshf
         da4LmvI5ylKpsrhPMp8oVoErsqGze71tYij2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oYFRomdva1gQ2Oaw+yeDM6A6FM1BsflYcft/mKBX5mfd3EDAe9x87q2U1HyJWTjU7x
         WA+kQjkNT/Ge9274vkis6cXfzXDygnzHmsIziPD9CSBPri62IGyfNt8fPDYe68XlBWF0
         HJCw6VkvQF8PRHS9RzGnORk+UXzroPFlHdoRk=
Received: by 10.150.186.12 with SMTP id j12mr1731178ybf.187.1217531006677;
        Thu, 31 Jul 2008 12:03:26 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Thu, 31 Jul 2008 12:03:26 -0700 (PDT)
In-Reply-To: <20080731201530.067be667@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90966>

On Thu, Jul 31, 2008 at 20:15, H.Merijn Brand <h.m.brand@xs4all.nl> wro=
te:
> On Thu, 31 Jul 2008 17:24:40 +0200, "Santi B=E9jar" <sbejar@gmail.com=
>
> wrote:
>
>> I see all OK. Can you provide a self consistent simple testcase that
>> shows what is wrong?
>
> Yes. was rather easy.
> http://www.xs4all.nl/~hmbrand/testcase.tgz
>

It is because you cannot merge a branch with an empty branch. So, or
you create an initial commit in the "superproject"  or you create a
commit just moving the files of the first module as in:

http://article.gmane.org/gmane.comp.version-control.git/79887

Santi
