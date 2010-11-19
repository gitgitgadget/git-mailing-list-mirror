From: Scott Chacon <schacon@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 15:56:08 +0000
Message-ID: <AANLkTikTEcPqeGtLEFKMCsiv9zC7Jj-E_3mrjDrR7fJR@mail.gmail.com>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
	<AANLkTik5ZYC66NicUvbDxJMiR_0iK3vPRAf9dGAQu+qW@mail.gmail.com>
	<AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
	<m3vd3t48uy.fsf@localhost.localdomain>
	<AANLkTi=wdWkZCyg6vHOaDZS=oeWAX_EhCgOLFGJOwC9G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Patrick Doyle <wpdster@gmail.com>, Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 16:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJTKo-0005EJ-PC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 16:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab0KSP4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 10:56:11 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33140 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab0KSP4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 10:56:10 -0500
Received: by eye27 with SMTP id 27so2757598eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=R4dAK0ssRfwIkpK9yjBIgtmgf8xUcXPnA1ma3RQAygg=;
        b=pOBLxCLrCQC30r1XHBXLwFyWaKNamcDEMR5ave19AiuTUTrg/YlJnCeOomn8PiYnBY
         CcZfwpwUcJPjREYR8jlsgptif68YyvDuE9CJlmUU21nkFzuT1TPKHLVpXWBg2Us50uKH
         vX/ZI+BHYVj/ZDtvNrDXIrBRWCQTLocf+vouM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nDsYM49XhLDRhgoxN2X4QT7n7m12rjfbg3cYsoAqnzUSHZejrbVUk8OHMWB4Crlls0
         i5rRV5E6FLUNHa9BFpvs6kKmesU/27FJd6ZpGDbTUKUK/IxADi561PnHJugkOIPdt39I
         YPO9Q5orb7eVWLWQB45XSkMeGBjexct9iydbY=
Received: by 10.14.45.78 with SMTP id o54mr780288eeb.41.1290182168459; Fri, 19
 Nov 2010 07:56:08 -0800 (PST)
Received: by 10.14.119.197 with HTTP; Fri, 19 Nov 2010 07:56:08 -0800 (PST)
In-Reply-To: <AANLkTi=wdWkZCyg6vHOaDZS=oeWAX_EhCgOLFGJOwC9G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161762>

Hey,

On Fri, Nov 19, 2010 at 3:47 PM, Dun Peal <dunpealer@gmail.com> wrote:
> On Fri, Nov 19, 2010 at 3:44 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Pro Git" out of date. Oh really? It is kept quite up to date (for
>> example adding information about "gitolite" and "smart" HTTP
>> transport), see https://github.com/progit/progit
>>
>> As to other documentation, see
>> https://git.wiki.kernel.org/index.php/GitDocumentation
>
> Wow, that's pretty cool. Any idea how often the online version at
> http://progit.org is synced with the github version?

I merge it in and push changes every month or so now.  It was more
often, but the errata and translations are coming in less frequently.
I have a number of pull requests pending, mostly for formatting fixes
and translation additions.  I'll probably do another merge/push around
Thanksgiving.

Scott
