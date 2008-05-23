From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: git cvsimport error
Date: Fri, 23 May 2008 15:24:40 -0500
Message-ID: <799406d60805231324o209692d2o59a700024e52100c@mail.gmail.com>
References: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com>
	 <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com>
	 <63BEA5E623E09F4D92233FB12A9F794301FC8B2D@emailmn.mqsoftware.com>
	 <799406d60805231301l1ff158b7k73bb193c472a8211@mail.gmail.com>
	 <63BEA5E623E09F4D92233FB12A9F794301FC8BCA@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzdpU-0002O0-R0
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbYEWUYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbYEWUYl
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:24:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:29069 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbYEWUYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:24:40 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1006526rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pxNA7fy2TcT9h7yylgvgNX3R7460TV3ErvdGlnnj39g=;
        b=VVxHNRkOJKUkV/3HnMsHccYIij6kwjn/UCiZnP9VkIxUp7A5r170LoHuJBjoqsbvwQEwSBRsPVvXlO0Stk8Q26mM6alkg7TDF15fTVIZzn1WY9BV87I5PjwRgnHhXAYdDZrpnSI+fWPAxFnBEZyoFL11ke/PCPk277tbJ9RX5o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlpy2aeYxSWZFQCn9XC5pt0Fny3HGFTXhB5caHPBWLOrVWeNSfB51uEVko+ZYgnSYy1NCU1KooNHhg6JGJhIWDimGgCNfp+AiN4tSu5qB9r7tlJETd1ZIl15XZXHxnHVjUTZxTbtpqpC5XXztbBCqrtG9HdUyHhXi0qbWW8GO80=
Received: by 10.141.89.13 with SMTP id r13mr851486rvl.177.1211574280503;
        Fri, 23 May 2008 13:24:40 -0700 (PDT)
Received: by 10.141.203.9 with HTTP; Fri, 23 May 2008 13:24:40 -0700 (PDT)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794301FC8BCA@emailmn.mqsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82731>

On Fri, May 23, 2008 at 3:05 PM, Craig L. Ching <cching@mqsoftware.com> wrote:
> Yeah, I don't know much about it at all, but my advice would be to run
> cvsps by itself and generate a cache that git-fast-import can import.
> That's the approach we're taking because it gives us a chance to figure
> out where things have gone wrong as we have some bad, buggy commits in
> our archive (CVS created the bad commits).

I thought of using git-fast-import but the problem is that the CVS
repository is still in use so I need to keep the git and CVS repos
synchronised and it seems like git-fast-import can't be used in this
case.

Cheers

Adam
