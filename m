From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-write-tree strangeness
Date: Wed, 8 Aug 2007 18:10:52 +0200
Message-ID: <81b0412b0708080910u3aee166fo92ea73a4a0a78ccf@mail.gmail.com>
References: <20070808154211.GA25015@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIo7f-0000L8-DM
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 18:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbXHHQKz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXHHQKz
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 12:10:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36360 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbXHHQKy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 12:10:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so56917nfb
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 09:10:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EzWbGZlWveoI/GQgr42kbgt9zum2O398OxzkdeHXLi7GeuAXDWQoODWr6epu+lnOt1uQVj2/MZFuPW0d4q1J82MDlPqprLxY32brJwz+KGJca1uzCe+jHcqBIFlDLvTjKytpMNTxuzb3Yu/xRdsymv3tRYhNsalyVzvwO6l0s7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s2BXJIsOFEi3kddhW3fKv8nMDew8uQY/Am5R6LV0csE2EYbDV8y1DuedK5RDxLdkCk6ijxP9vVCu65DTFL3kGfNATQonlCNoZAy0kM1LE0Ot71VeaUOGa1cI9JFrbbJt9oSv7UOKKBHzv+EGRMRIAAU4enxV7QTelEA2XS4Uu8o=
Received: by 10.82.108.9 with SMTP id g9mr2072018buc.1186589452535;
        Wed, 08 Aug 2007 09:10:52 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 8 Aug 2007 09:10:52 -0700 (PDT)
In-Reply-To: <20070808154211.GA25015@dervierte>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55329>

On 8/8/07, Steven Walter <stevenrwalter@gmail.com> wrote:
> I'm importing a large repository from svn into git with a custom tool,
> and I noticed a strange issue with one of the commits.
>
> Upon investigating further, I found that when I ran "git-write-tree"
> followed immediately by "git-diff-index <tree>" I had differences.  Does
> that mean that git-write-tree incorrectly recorded the index, or do I
> misunderstand things?

What kind of differences? Different sha1 of content?
I can't simply reproduce it.
