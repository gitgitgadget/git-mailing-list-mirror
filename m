From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 16:31:55 -0400
Message-ID: <s2i46a038f91004101331g1cdca78cya3e125275446a0a9@mail.gmail.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com> 
	<l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com> 
	<m3k4sfgmjc.fsf@localhost.localdomain> <20100410194154.GB28768@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Simon <turner25@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Apr 10 22:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0hM0-0002vV-Va
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 22:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab0DJUcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 16:32:16 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:39742 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab0DJUcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 16:32:15 -0400
Received: by iwn35 with SMTP id 35so419043iwn.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JCnyU7aTo+1e63Epn8jfBJK9KGxSQuv0ceDobi6vkD0=;
        b=ORMiw8v+GQHMO0c/1dXH4thHK0SbdongkhBubqqns+5FQ+SXOoUub4h+GID6y3s4l2
         6nPjKzItrJu7U5mjOhYfcdoYRsOgaC4NZ7P2MZVibq+5FZx7B7rka7+5djHsKMgC/7eE
         Go5kEKQnZBdfBH3punghwuSiGIwy1ARyl9g3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sCixn2k55xMoI4F8TC0o1zLhvk2TF8U2BqFFJGpSnw4KI7dP5BqmjKLrzgttIAmTBu
         pM/lK5o/89yAWzaok7JITqCP/i4rPZPSrpQVdox33XooGE+7qPe7BZvpR+38dfv7qbNi
         zSDoVft66qHyS5Mq+NKH2A7A6QZtsCFFi0D+E=
Received: by 10.231.207.67 with HTTP; Sat, 10 Apr 2010 13:31:55 -0700 (PDT)
In-Reply-To: <20100410194154.GB28768@thyrsus.com>
Received: by 10.231.169.145 with SMTP id z17mr847914iby.83.1270931535188; Sat, 
	10 Apr 2010 13:32:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144590>

On Sat, Apr 10, 2010 at 3:41 PM, Eric Raymond <esr@thyrsus.com> wrote:
>> I could understand providing JSON format, specified using --json
>> option.
>
> You know, that's actually an interesting idea. =A0I mentioned it
> previously as the not-XML if we want to build on a metaprotocol;

One issue is that there's no stream-parser JSON implementations that
I'm aware of.

Everthing I've seen is in-memory, therefore apt only for memory-bound
operations. Not sure if all commands with -z output options can be
assumed to produce bound-sized datasets.

cheers,


martin
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
