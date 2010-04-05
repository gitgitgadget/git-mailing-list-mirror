From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1/2] diff: add --word-diff option that generalizes 
	--color-words
Date: Tue, 6 Apr 2010 03:53:41 +0900
Message-ID: <s2kfc339e4a1004051153yc950b858lb919740f0de80e9@mail.gmail.com>
References: <cover.1270388195.git.trast@student.ethz.ch> <a1e9ef6a4eb1d7930f69e9ac4b63dc3152ebc98c.1270388195.git.trast@student.ethz.ch> 
	<7v39zay7or.fsf@alter.siamese.dyndns.org> <201004051220.47400.trast@student.ethz.ch> 
	<7v6345pwjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:01:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrXs-0000SA-8M
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab0DETBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:01:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65283 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0DETBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:01:05 -0400
Received: by pwj9 with SMTP id 9so554431pwj.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:received:message-id
         :subject:to:cc:content-type;
        bh=HCmx0Xf/J2MmN/J4oHBzlf46sCVZhVFkrfnSVs6B3Fk=;
        b=rNNs/ecvIvd6MmFhgIcGk4BRCszc0uu3y3nN1Te60ajLaZlDY9wmY67tTKpHXLStzP
         0IUoRXK01WzNKK6qoPtifertZTzeoQZgYufcAAJwgtUHVv1DRAuP0n5DBXAXz3c1+kDx
         cNrz3j0Td1TN/BPnnC7f/MzmEr4OMt1m3vXaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=NLZvnqBKFltmBnwiRQElBY+Vm5UaT53PB7cwUpXUS0ade45KZjSElT/KsQuXJmcSHI
         mBmef4/traaR/Pu13zFGy2JWu2X63PgKTBDgkgUZQaAM3+0mv+nRCqk4qcZxJ+2JcywI
         YSXL8KS9lP34kJYOn8Xfoo32dypJbxOhVssjo=
Received: by 10.231.16.141 with HTTP; Mon, 5 Apr 2010 11:53:41 -0700 (PDT)
In-Reply-To: <7v6345pwjw.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 3e01e521ff328a8a
Received: by 10.114.253.34 with SMTP id a34mr4548444wai.43.1270493641347; Mon, 
	05 Apr 2010 11:54:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144048>

On Tue, Apr 6, 2010 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I also think --color --word-diff=plain could show "{+new+}" in green and
> "[-old-]" in red and that may make things more consistent.

I agree.

For some reason, even though I can see the red and green well enough,
I find the current --color-words output hard to parse.
The use of _only_ color to distinguish old/new somehow doesn't jive
with my brain...

I find _highlighting_ using color very useful, but I think using
syntax and color together is better than using just color.

-Miles

-- 
Do not taunt Happy Fun Ball.
