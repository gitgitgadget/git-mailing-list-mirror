From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/3] Submodules: Add the new "fetch" config option for
 fetch and pull
Date: Fri, 8 Oct 2010 00:33:22 +1100
Message-ID: <AANLkTikUdNdDDK9-+AjuSO_RJHNBZEp5mHPRnsV0Fo0v@mail.gmail.com>
References: <4C7A819B.3000403@web.de>
	<7vocckhcb6.fsf@alter.siamese.dyndns.org>
	<778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>
	<89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org>
	<4C9221B6.7070807@web.de>
	<AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org>
	<4C9351A7.7050609@web.de>
	<4C9359D4.2030109@viscovery.net>
	<4C935D77.3080008@web.de>
	<329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
	<4C953DE5.6020900@web.de>
	<DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
	<4C963D00.9050207@web.de>
	<28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
	<4CAB8DDF.8080004@web.de>
	<4CAB8E33.1030208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 07 15:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3qbG-0007Bc-5W
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 15:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab0JGNd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 09:33:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41451 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab0JGNdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 09:33:25 -0400
Received: by ywh1 with SMTP id 1so285959ywh.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HDKQzKg8EnWNpU4LMTxtcH1nlHU7CowtuqdNTGumImQ=;
        b=LKYfrhwZLBApa6xewlBC5BOSsghhrQqUT204wWz9fVhSaNm0LtUW8cTWt54MrV7rBQ
         xPmdv/qC+pvaFhsL22G+/zwyh7I9w7er6FMcTmTAQqdWJTIIqt3xjRcHw/ppBTIrQr6N
         vvEQtJqdNmy0w6fiuin/KrUXIikfKjiKlVfro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oN/Kyi7b/1ABkU9bcKhAW1BAveFJ5h024NQ6Byy8hnqfM6D2slPx2od15se9saFWdg
         WyTUFhPkrRhrd7o2TtuzaB2TuBnvA7CLoEudvY114W9LuM+kmQiB2JZIzdXMp7VeXYLS
         uIx+VSgaljNJAPcHWTg7O18F9zkfpw4JUm2Ck=
Received: by 10.151.87.4 with SMTP id p4mr1068856ybl.397.1286458402731; Thu,
 07 Oct 2010 06:33:22 -0700 (PDT)
Received: by 10.151.48.14 with HTTP; Thu, 7 Oct 2010 06:33:22 -0700 (PDT)
In-Reply-To: <4CAB8E33.1030208@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158399>

> The .gitmodules file is parsed for "submodule.<name>.fetch" entries before
> looking for them in .git/config. Thus settings found in .git/config will
> override those from .gitmodules, thereby allowing the local developer to
> ignore settings given by the remote side while also letting upstream set
> defaults for those users who don't have special needs.
>

I wonder if the name is a little too general for the function of this
configuration variable and if it might not be better to qualify it a
little further, perhaps
with the recursive suffix, e.g.:

    submodule.<name>.fetch.recursive

This would allow us to define other attributes that configure fetch on
a per submodule basis later should the need arise.

jon.
