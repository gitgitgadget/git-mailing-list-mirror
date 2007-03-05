From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Mon, 5 Mar 2007 08:34:38 +0100
Message-ID: <8aa486160703042334w511c03c3if955f2e52b6d2268@mail.gmail.com>
References: <87ps7oslwk.fsf@gmail.com>
	 <7v8xec4mej.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO7jd-0004FW-NJ
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXCEHem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 02:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXCEHel
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:34:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:53255 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbXCEHek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 02:34:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2000932nfa
        for <git@vger.kernel.org>; Sun, 04 Mar 2007 23:34:39 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VdwJ74HtW5bzWbR3dGQdegSDksVo6sA2Mv7CabZOmRCEQnRky/ZnNaW11peW4O6f0Ro4IJSOolXWelNjRDIkA41s/K0AycegFpwgIBVEG3MDKYlB/UgxHAjoRZyF4Fvu27KgcrrSPf1PNZ4Glf/iDZTxXKa2zCx62jFv9JbU7hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ly3wLWAfScXF3kqtshMORf7JonAfBHTtDZhuLYT5/fXNwKEmCjKIJd6awHhBH1EKZrfaUq2x+Jl0/JmbDEeArSm46gNnQS/arIR0+kSb9xwcMcNp5UGOIIuJHZkKWFFszNaj/FVGNJ2IeKHV1nOMiESLtRyXvQNlqoAbvSPE0+w=
Received: by 10.78.180.18 with SMTP id c18mr585595huf.1173080078605;
        Sun, 04 Mar 2007 23:34:38 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Sun, 4 Mar 2007 23:34:38 -0800 (PST)
In-Reply-To: <7v8xec4mej.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41406>

On 3/5/07, Junio C Hamano <junkio@cox.net> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
> > ---
> >  Hi *,
> >
> >    it is a much reduced version (63 instead of 400 tests) but conta=
ins
> >  also tests for the fetched tags (missing anything else?).
> >  I think it is suitable to be included.
>
> Thanks.
>
> One thing I found lacking from the last round was that the test
> stripped the origin information later used by git-fmt-merge-msg
> (which made the test not very helpful when I tried to use it
> while working on the partial rewrite of git-fetch you see in the
> 'next' branch).  I haven't checked your patch this round yet,
> but it would be nice to check for that to catch regressions.

It is stripped, I'll send another patch with the whole .git/FETCH_HEAD =
content.

Santi
