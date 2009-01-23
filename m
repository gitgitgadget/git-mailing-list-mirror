From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 09:07:58 +0100
Message-ID: <46d6db660901230007x36368c79s724d1adb51d0818d@mail.gmail.com>
References: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
	 <alpine.DEB.1.00.0901230119490.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQH6W-0001Oi-OG
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZAWIIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZAWIIB
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:08:01 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:22726 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbZAWIIA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:08:00 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2754532muf.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 00:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5DxXciqMWibxe+NOFb9Ph3SQi6NStK5XXhL0djZjAmQ=;
        b=cDmujDPsXxXRO7S6y128urRdtZhVL47E43MAUcGaa0gvEStedLhdob35glStfTSImc
         QqVBpneO7pSZ3IzUPzeU4yLLldi/OfkcZpTw+HTLG/su9pQbXoWztTPMjOcpDLNyORIu
         teQ31CLmwgCKji8dKPcUuzgwlIdY3GxOyr21E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iE1ApsUX2+MAfILpilGB8aULRqfF/Ca5kIlTj95ikUSNkTMXnN3siSaNG0Kp3zUCOr
         frdPi6ufKzySnS7lbIoGK2+lY1Ew1u2e/FmJUyC34YLtxHQb8T2usxSfezetliaiTn//
         y53sx53lo+sCP4Jg//UMEYcI+KioPxz57tqio=
Received: by 10.103.226.20 with SMTP id d20mr682584mur.8.1232698078242; Fri, 
	23 Jan 2009 00:07:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901230119490.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106852>

On Fri, Jan 23, 2009 at 1:21 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 22 Jan 2009, Christian MICHON wrote:
>
>> I've a big set of patches in a mbox file: there's sufficient info inside
>> for git-am to work.
>>
>> Yet, each time I do import these, my sha1sums are changing because of
>> different commit dates.
>>
>> I'd like to force the commit date to match the info/date from the time I
>> received the email (and therefore always get back the right sha1sums).
>>
>> is this possible ?
>
> Have you tried setting GIT_COMMITTER_DATE to the given date?

yes, I did. This is what I want to change: I can fix the same
GIT_COMMITTER_DATE for all patches in the mbox, but I really want +
                   GIT_COMMITTER_DATE=GIT_AUTHOR_DATE


>
> Alternatively, you can always use a commit-message filter with
> filter-branch to fix it up.
>
> Ciao,
> Dscho
>

I'm curious if this could be done: the problem I quickly faced was
that this approach would double the amount of commits.

So I'm eager to test Junio's patch :)

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
