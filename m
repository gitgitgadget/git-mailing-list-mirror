From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 0/3 v2] Improve your performance with our patch
Date: Tue, 28 Jul 2009 13:50:14 +0100
Message-ID: <3f4fd2640907280550g22e922fue0bbeeed36fba497@mail.gmail.com>
References: <alpine.LNX.2.00.0907280131230.2147@iabervon.org>
	 <alpine.DEB.1.00.0907281307380.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 14:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVm8S-0001e0-1K
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 14:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZG1MuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 08:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbZG1MuS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 08:50:18 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:45925 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbZG1MuR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 08:50:17 -0400
Received: by qyk34 with SMTP id 34so148625qyk.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xa6T6KJoIA44znh22z1CTnnW+gFUQiVGwo2nKj0P32Q=;
        b=x64REkr10leU/Pk8RtamFoXMPm78J4Y78ueBtPwchPmEN0R6V9UShJ+YpOrdHgahRy
         usCg1UzdIxIJKzlrVZ9iHX2vNywGYV1GUELdJTfV+GgZQINfaty7GWw49B3bT2frmqMb
         6Hezbl78JOBB622WzzDVWT/GdwbRoiYpaNOTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Iy91xSPvOEo/aXXf61atp2mOEFl1mRHx2M75Aa/NaWZSMm/mIUXea8G+ZXbyGPjGxz
         iHDijPPbBKkM3HCtZZs67um7WqupnFbdjlW8MqK2rLKMuMvhpQJERUWCmFpxHhc8EoD9
         mS/mH/IQ06cdek9pvErxz+8OBi4FbZ4vIYmHY=
Received: by 10.220.75.9 with SMTP id w9mr4425776vcj.82.1248785414726; Tue, 28 
	Jul 2009 05:50:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907281307380.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124244>

2009/7/28 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 28 Jul 2009, Daniel Barkalow wrote:
>
>> =A0Documentation/git-shim.txt =A0 =A0 =A0 =A0 =A0 | =A0 37 +++++++++
>
> May I re-register my complaint about the naming?
>
> I mean, yes, I could think of something even worse when it comes to t=
he
> (ridiculously bad!) tradition of naming things "porcelain", "plumbing=
" and
> "potty", especially when it comes to "pushing objects" and
> then "pulling".
>
> But now that we had a good laugh, it is time to get serious again, an=
d
> give this child a _way_ better name.
>
> I mean, you already had a good name for your foreign scm series. =A0W=
hy did
> you give that up in favor of this lousy naming?

How about git-http?

- Reece
