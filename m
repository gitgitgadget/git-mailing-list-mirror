From: Eugene Sajine <euguess@gmail.com>
Subject: Re: global hooks - once again
Date: Tue, 6 Jul 2010 08:23:02 -0400
Message-ID: <AANLkTilZcuYxb6ASgJq82JVdgcRcuak5PvYXZF6fcojm@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
	<AANLkTimSvwo50Q9jsbKkzvplSPE82fNJJDSFmZVw3r5o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 14:23:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW7BK-0005Pu-7y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 14:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab0GFMXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 08:23:05 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46395 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756899Ab0GFMXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 08:23:04 -0400
Received: by qyk38 with SMTP id 38so1925003qyk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5Q/jEUUPyquYwYZmma8u36a7IbCpBSpruy8T/2NlZfQ=;
        b=BlxQ4VUQay/l0zklK29/Wh9lXY4B+l1fx3JzPwT+cnvSmFwA5CxYPDJzNOVcgJQfbm
         v0Yi3LOoRnJ7snsF1YDWrYKsTmZN/V0Pi3oydTVGYjfIA+C7uabGRLYoq6L4gNMapYDb
         isyR6kHLE5bf6UunbzyWJkyS1WJY1Ove2hAok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=N2vsyyZjT+ZS4DaMJYxS0tpVld2b+vpxRZRHZpN4HPNmIzCgSFAFKR6aoAe7OMCZ+c
         HS2xBa+Hfz6f17Gq6VNQKi9+PuvlI68Hniu8dU8/UWRgWwv94Nhb71CFLWf6Jw8gSeao
         wIeX1PCerPPQCzyt2+DA7LbOJWriNr8Xa4hHk=
Received: by 10.224.28.130 with SMTP id m2mr2436192qac.29.1278418982895; Tue, 
	06 Jul 2010 05:23:02 -0700 (PDT)
Received: by 10.229.212.209 with HTTP; Tue, 6 Jul 2010 05:23:02 -0700 (PDT)
In-Reply-To: <AANLkTimSvwo50Q9jsbKkzvplSPE82fNJJDSFmZVw3r5o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150347>

>
> How do your users disable execution of global hooks in this scheme?
> (to protect themselves from an evil system administrator)
>
In a corporate environment it is not the case, i believe. If sysadmin
made a mistake a with hooks, he will have to fix it, but there is no
point in overriding on user level as hooks in this case will be
something about company policy, aren't they?

Thanks,
Eugene
