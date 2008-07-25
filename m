From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Fri, 25 Jul 2008 10:54:53 +0200
Message-ID: <bd6139dc0807250154r141a5dabn9585f3e23e7736ca@mail.gmail.com>
References: <20080723145718.GA29134@laptop>
	 <20080724171952.GB21043@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807241837441.8986@racer>
	 <20080724182813.GA21186@sigill.intra.peff.net>
	 <7v7ibauz94.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMJ5q-0004ik-Ab
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680AbYGYIy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbYGYIyz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:54:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:18534 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbYGYIyx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:54:53 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3973303wfd.4
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ts/9RMZAsbjHRNF0V0gdmchFVExqyKSW0/jc0Z4jip4=;
        b=F8ccTveGU5Y+YYtAK7VCmAoSgL6CTPw/OmTx/+UNkpc/K3FWOjvFxR6FJvuBeJPHUz
         aHAstOOtl4akY1dlNyQyXhHvyljrrdt/qmdoU2BHvMLaotPe83w5gOCWRbq00avFqRm5
         xMP/geijYyXMUkMgq7M6MQENSbUDqmRsgzouk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=yC5Qh8yfrz+V+GktM1D6nKKPr+gVMn5Sz26NLwFtAZpW87cGLT9cCp7kbB8wrGwKIo
         lIcwqBtmkDm2KpO7Yyj2rA6q9lBHvsJ8amViLsQbpKkZvcnUAYT/rIjA3RjgaDkA0kze
         0TA3/MmLi4yFvNJUF82CxXvsFafb+gCkQ1qt4=
Received: by 10.142.239.13 with SMTP id m13mr460213wfh.218.1216976093158;
        Fri, 25 Jul 2008 01:54:53 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 25 Jul 2008 01:54:53 -0700 (PDT)
In-Reply-To: <7v7ibauz94.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90018>

On Fri, Jul 25, 2008 at 10:47, Junio C Hamano <gitster@pobox.com> wrote:
> For many projects that has src/ and doc/ (git.git being one of them), it

We are? That's great, that'd mean I can actually do a 'ls' in the
git.git root! Oh wait...
$ ls | wc -l
693

-- 
Cheers,

Sverre Rabbelier
