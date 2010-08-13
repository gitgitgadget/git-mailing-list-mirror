From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Status of conflicted files resolved with rerere
Date: Fri, 13 Aug 2010 13:19:47 -0400
Message-ID: <AANLkTi=0dV54q6o3f-XrxKAHDKn8mhWFmsLDen_3+1G7@mail.gmail.com>
References: <20100812212828.GA17825@jpl.local>
	<AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 19:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojxv9-0002nT-Sx
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761883Ab0HMRTt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 13:19:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34741 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761863Ab0HMRTs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 13:19:48 -0400
Received: by yxg6 with SMTP id 6so1049930yxg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8jX6SGa4vtep0YDX1RwHjeU52b0dTSrOmpjNi+0KhG0=;
        b=A/EGgJSC21GNUK0rMhSN9IRShJmldZ+p+z2n6EKWt2N0eUU1xS0DMoPoPClKygsKRH
         l5wpKXXiYPgrkoMRPmwtFyPPewT0Yc1L05lK2M5Rn8Y1XfMoVdA3CmtteYEqcYzYbqby
         6q9CAS43GQu23dU3kr+Z9VgVZaywiDUTuQt5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rh9Ff9e63fzUQGWyEpRttNBSWZSWyi1V9da74szjyZRfLRoLkGK4jgXl3sPPuh2ERS
         CllCtOFFZ0f0Wmb7YN8mtsM+KQ8d5WISvfWI8FExy8reqCIo6+j3mPDU+3Iz9rKu2hG5
         CaIcKykTavzsMyyVNsHTKylr7mnv5gDOWgwtg=
Received: by 10.150.194.7 with SMTP id r7mr2374471ybf.157.1281719987764; Fri,
 13 Aug 2010 10:19:47 -0700 (PDT)
Received: by 10.231.170.199 with HTTP; Fri, 13 Aug 2010 10:19:47 -0700 (PDT)
In-Reply-To: <AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153477>

On Thu, Aug 12, 2010 at 5:36 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> That said, I've never had a problem where rerere did the wrong thing
> for me. =C2=A0Maybe there could be an option to override it.

$ git config rerere.autoupdate true

j.
