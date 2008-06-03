From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/4] Handle non-ASCII filenames
Date: Tue, 3 Jun 2008 08:56:38 +0100
Message-ID: <b0943d9e0806030056x588474dcha3e14dd8dca952ba@mail.gmail.com>
References: <200806011046.51872.jnareb@gmail.com>
	 <20080602214212.18768.63775.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 09:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ROf-0007xN-99
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 09:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYFCH4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYFCH4k
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 03:56:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:19578 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbYFCH4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 03:56:39 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1450237rvb.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kqr1L+GhIrdrZrXk2JPWT+itfugyKK3y9RC8zUBmKGE=;
        b=j51A1srtyw2krCKcLrjyvYDhtslZMHk85O4DVsLdcQ30HsfxYjEUOvHfuDdgZvEazUmZkjHxZw6yd9Yja5CyOY0GS1Ast6R8X3/6Q9/TKDNiCi1Qv3bq6JjZwWaNRTBB1uFsIeVrLThT8px8OqNvCjbpJ9ORAuO92QWSzk48Yt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nOU3peL881v4sGOr2brVCrNebMYkHbRArDNmU5tezi3rbc7+urEUpQgQN3v8Xh6jxNVJetuJVYwTU+UVc0v/435p9iqAlQ/V9/MwK1UwcSIPeXpj/W+6KwBp4H0vxR9swgAvYPwq/HvuxCSYm22fh9V2WMV+prVAODYi11PZ6XI=
Received: by 10.114.181.6 with SMTP id d6mr1950447waf.50.1212479798936;
        Tue, 03 Jun 2008 00:56:38 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Tue, 3 Jun 2008 00:56:38 -0700 (PDT)
In-Reply-To: <20080602214212.18768.63775.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83626>

On 02/06/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I fixed the first problem, and while doing so noticed that a nearby
>  block of code had exactly the same bug. So I fixed that as well.

That was fast :-). thanks.

>  Catalin, this should go on the stable branch, I believe. It probably
>  warrants a new release too, since anyone rebasing patches past the
>  point where the "M=E4rchen" file was removed from git.git is going t=
o
>  hit the same bug Jakub did.

Yes, it will go in both stable and master. There are some more patches
on stable already, I'll try to release 0.14.3 this weekend.

Is the new infrastructure affected? We haven't got to the point of
converting "rebase" yet (doesn't have all the functionality it needs
in the new infrastructure). BTW, I created a new lib.git.Branch class
as the parent of lib.git.Stack and it takes care the extra things used
when creating a new stack like setting parent and remote branches.
I'll post the patches in the next few days.

--=20
Catalin
