From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 0/3 v2] Improve your performance with our patch
Date: Wed, 29 Jul 2009 14:30:07 +0100
Message-ID: <3f4fd2640907290630s37285944y8a364ce958367b@mail.gmail.com>
References: <alpine.LNX.2.00.0907280131230.2147@iabervon.org>
	 <alpine.DEB.1.00.0907281307380.8306@pacific.mpi-cbg.de>
	 <4A704A62.2060402@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 15:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW9Ed-0004Jh-JG
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 15:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbZG2NaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 09:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbZG2NaL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 09:30:11 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:63310 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbZG2NaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 09:30:08 -0400
Received: by qw-out-2122.google.com with SMTP id 8so407049qwh.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zoQaMT1N+5Y/Emos4jW3vwEwflquWSs7GAMxBTUjysA=;
        b=JRb7NfF6dSZjHmCeQLox1nLI8Z+AR2dKtw5m4iT2DXtnqpVtSHFdwp0p4iwp8eQR8k
         FWAvAKBOi4wPRN6HSIRqS8hVURb9+4baWAgVxnd0aAD2ivJz5pi0hb/CDC1gaLKuI1ER
         9Y1mAZfl2/GzYR0C3y2PzuT5iyGvLLmf/auBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DQkh/J8YskY3XtmZwQdNsMdyNJRtIII3gtltzy6pGMx9tmMvZpitsgjFIOR6rva7Sl
         uR/HbtOHRoL6iV+CctkgUEPrREW5zZL7R6SllGzEty/OshmfpE9iXPqjNuiy7bWcLwaF
         sGexBd1+bPfkW4B/WlbviCdWJHBr+sGoiEWd0=
Received: by 10.220.95.73 with SMTP id c9mr2544547vcn.20.1248874207434; Wed, 
	29 Jul 2009 06:30:07 -0700 (PDT)
In-Reply-To: <4A704A62.2060402@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124349>

2009/7/29 Rogan Dawes <lists@dawes.za.net>:
> Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 28 Jul 2009, Daniel Barkalow wrote:
>>
>>> =A0Documentation/git-shim.txt =A0 =A0 =A0 =A0 =A0 | =A0 37 ++++++++=
+
>>
>> May I re-register my complaint about the naming?
>>
>> I mean, yes, I could think of something even worse when it comes to =
the
>> (ridiculously bad!) tradition of naming things "porcelain", "plumbin=
g" and
>> "potty", especially when it comes to "pushing objects" and
>> then "pulling".
>
> A Shim has nothing to do with plumbing or toilets. From
> <http://en.wikipedia.org/wiki/Shim_%28engineering%29>:
>
> In engineering, a shim is a thin and often tapered or wedged piece of
> material, used to fill small gaps or spaces between objects. Shims ar=
e
> typically used in order to support, adjust for better fit, or provide=
 a
> level surface.
>
> I suspect that it is being used in the "adjust for better fit" sense =
in
> this case.

Yes, a shim is a layer that acts as a bridge from one thing to
another. In this case, it is a bridge between the transport code and
the transport mechanism. Using shim as an external name is confusing
-- a shim to what? The fast-import code and git-svn/hg/bzr/cvs/...
could be a shim (as it is acting as a bridge between other version
control systems).

Here, git-remote-* where * is the protocol name is a better naming
scheme as it tells you about what the logic is doing. The
documentation can be under git-remote.txt.

- Reece
