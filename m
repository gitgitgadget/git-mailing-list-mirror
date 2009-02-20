From: John Tapsell <johnflux@gmail.com>
Subject: Re: git merge --abort
Date: Fri, 20 Feb 2009 04:47:39 +0000
Message-ID: <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
	 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 05:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNKR-0005s7-TP
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 05:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbZBTErm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 23:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbZBTErm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 23:47:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:54796 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZBTErl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 23:47:41 -0500
Received: by gxk22 with SMTP id 22so2096924gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 20:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q86y3JuW1n2ocAekWUK9DKdOzRJGA9bUrt/REo0ttn4=;
        b=STZPQNuxAyjnUsCqLRgvhHjnMsDwlejhKg472P5dzh3HiaItRUzh3IEP6eNOKifInM
         KhsRRH3gZL7HdYQpSi29rhWx1sDNoQrOheECeK2zkvdTsu8CNzGH7egyENRI/tiat+hv
         tC9nH3NSFjskVGue3iE8y4om1xzFMvS9qjuUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r+AzOGBrlXF0cAyYQRpHjxLpPRdXkvWKHQS+LFPqbVSwsb/91QwZdFtraXZq9gAJfJ
         ZZn0FOSFkLsMGcyCuB/mj0h53ip/wD9MdvyD9ai1qe4dZD8JQKlqCvKZe01Aea6tazGK
         2BwJSM8Y2I+C/9WnO5d9rY32HHL4BLozIORr4=
Received: by 10.151.51.13 with SMTP id d13mr369037ybk.120.1235105260001; Thu, 
	19 Feb 2009 20:47:40 -0800 (PST)
In-Reply-To: <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110789>

2009/2/19 Jay Soffian <jaysoffian@gmail.com>:
> On Thu, Feb 19, 2009 at 8:34 AM, John Tapsell <johnflux@gmail.com> wrote:
>> There's no reliable way of getting back to the state before the merge?
>
> Sure there is. Commit or stash before you merge, so that your index
> and working copy are clean.

Could a stash be done automatically by the merge command, for just a case?

John
