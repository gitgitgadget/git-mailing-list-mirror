From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Mon, 16 Feb 2009 11:40:13 -0500
Message-ID: <76718490902160840t2d6af366jf14ced67d125040c@mail.gmail.com>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
	 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
	 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
	 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
	 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de>
	 <7v1vtzf234.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902161140160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6XP-0002KN-BO
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbZBPQkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZBPQkQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:40:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:38372 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZBPQkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:40:14 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1094318rvb.5
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dfNCtkI69JCo7ZJC7QX1ExSkAHntswOpfXDuO9xpb0A=;
        b=YNva/cmkcXMxfiQFlSqTnv5jytWzyk/orEQCuROWZVE3J6e67OoOn+OhBfzAmVX8aT
         YR2aqw8R+HvQ+nwNOzFffta+D5ZGnujIob1P5jqOuJvXpBXhOxDuSVIUOf2Hl4X7aNrR
         Uoc4CCWlLdhqP8hhug1damz9sxzXgXX9ZEzmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AqfLsgdL65qj+b5OU4TR/rPLYegY3CXz7r5adQpab3VC20xaZfxQedA32HGiKmUusK
         eJ49Ut1jJ19NeOPpv79KsdkwFKFHoJgUVi5vLG9mLHdhEbxPTiFAbDuLj5fNqbiaKGCy
         1KvqdxYN1xO2MOf1OgwWuHSrEHg3adLfKsRwU=
Received: by 10.140.186.20 with SMTP id j20mr2753428rvf.230.1234802413674; 
	Mon, 16 Feb 2009 08:40:13 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902161140160.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110205>

On Mon, Feb 16, 2009 at 5:41 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> "git branch --history" anyone?
>
> For a moment, you had me convinced it already exists, and I only
> understood after "git grep history builtin-branch.c" came up empty.

And I've labeled that mail as TODO. :-)

j.
