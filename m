From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 00/17] Series short description
Date: Mon, 17 Dec 2007 11:09:06 +0000
Message-ID: <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Dqw-0007IF-SA
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935453AbXLQLJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 06:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934343AbXLQLJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:09:09 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:54427 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934048AbXLQLJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 06:09:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1842346rvb.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 03:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rhsLHR6J6olxh/ASRpwMRk5hlOdP73xdvl0ocTtqNoE=;
        b=OtBCcCz40RLbqLSeqpiSNYefn2zvd3RWPZKoen3/0JNc790iL8M4jbr1Y2NDDw8q6q8qdX7RYT/5DDnvNnsYTX8YBP30h8florTTHfeKBeE9R9IMl5r9BEKaP6MWiMXUMmP+GhGGEfzJinZwVHgJuFk4CvlEm7+tRRXrL/mPR34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kwop8hSJeoYOgmJgFL4cwCQgORpZB8BElvgCEMmXnWVUym5pCYzqJ92TBZzFyhEmaP3U6tH4YJvDSAVSiUN9yPVVGv0ydHdOfI4LhjQmOhUUjC3tUgQYG4FbPlmfLG6YFH8spnIjUGdlrrgtl8Zo1dy1IgGUW54l9VlD/uYqohQ=
Received: by 10.140.164.1 with SMTP id m1mr165292rve.266.1197889746968;
        Mon, 17 Dec 2007 03:09:06 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Mon, 17 Dec 2007 03:09:06 -0800 (PST)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68541>

On 14/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> The following series an emacs interface to stgit patch stacks. It
> shows a buffer with the the output of "stg series" and allows you to
> do some common operations on it, such as push/pop, commit/uncommit,
> edit, rename, repair, and coalesce.

That's really cool stuff! Thanks.

> The coalesce command obviosly requires the kha/experimental branch.
> The edit command requires the edit fixes in kha/safe.

I'll start this week merging patches from kha/experimental (I'm a bit
slow because of the Christmas activities).

--=20
Catalin
