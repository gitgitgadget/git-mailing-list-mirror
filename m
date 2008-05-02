From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 2 May 2008 12:28:38 +0800
Message-ID: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
	 <7vprs5xsvi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 06:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrmu0-0007tc-0N
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 06:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbYEBE2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 00:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYEBE2k
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 00:28:40 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:1810 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYEBE2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 00:28:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so273676and.103
        for <git@vger.kernel.org>; Thu, 01 May 2008 21:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ouiGmUNgFiEWSs8LnaEn6ANhpeYXkJFaHMYorJ+SsXU=;
        b=eiO5nTkAN4G8Z4bbzQ2x9gPTIsd2/JD/7p1uCJ3sM0oeoToF6H1aQQYMMivovWJo/mUIX7W/TLfFD957XFJbvdGvUSsHT3z4b89j5EL39DminuyOdsFZbuqDcFuIA2ejHzu7GxZoCdZrQ2Tb383ujSboqatEq+mKtb6ntBuLG/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mt+MD8yQuRok9A1k+7HXv651GjcgYFOHltA//+kQbRFJl6VZjOoTsOgL+G9v4rePudihOJ1vxKz64j956OcKYImB1CobgO5zz5OAbt4qPbrCqGrNMNVfmZuKAA2er2gidlz5TQDqCrdEAnC3ukRsqVw3G97bCrCSLLTI20QGcOs=
Received: by 10.100.10.15 with SMTP id 15mr4063204anj.152.1209702518855;
        Thu, 01 May 2008 21:28:38 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Thu, 1 May 2008 21:28:38 -0700 (PDT)
In-Reply-To: <7vprs5xsvi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80956>

On Fri, May 2, 2008 at 11:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>

>  I suspect a more natural definition of word boundary is between a run of
>  word characters and a run of non-word characters.  IOW, instead of saying
>  " " and "(these other)" characters are boundary, you would say
>
>         if (foo(arg))
>
>  between f and space, open paren and f, second o and open paren, that open
>  paren and a, ... are boundaries.
>
>  If you go that route, you would make the definition of "what is the set of
>  word characters" configurable.

I prefer nonwordcharacters to wordcharacters. With
diff.wordcharacters, to maintain the same behaviour as before, i have
to define a long list of characters. While with
diff.nonwordcharacters, i need only define it to "".

So how about just renaming wordsboundary to nonwordcharacters?





-- 
Ping Yin
