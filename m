From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Archiving tags/branches?
Date: Sat, 18 Oct 2008 13:50:42 +1100
Message-ID: <ee77f5c20810171950j9ab85bfi6eddca167f86fda2@mail.gmail.com>
References: <48F93F52.4070506@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pete Harlan" <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 04:51:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr1v1-0000Jn-DO
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 04:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbYJRCun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 22:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbYJRCun
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 22:50:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:60683 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYJRCun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 22:50:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so862595rvb.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=InEBo+JDiO5HhiUb6wGoNeI7+bUzazEP7HAAjXuW39Q=;
        b=YmeW31QgD7LnWAFwbk0iFE8IUiOM7dR69rwacMaR9jw16gaUfIBvwJoc8itOAOt03e
         rnZxNMZPxqBy/jnWGG8J95Q8m6W9WZNj2M1BXwqWbTzsYw7nxb4sBP5Zv9DaO5E1AGd7
         Fxj9KMU/9Adx3FM1Vrz8TYDozwG+tRM0com74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JJ6bILt89wDFwulpmxU6lYRyx0zNp64hwOw/KlSrFf32dFvHRNXADTcoVugGtxHz6W
         QvHptJ6v3oHbAOqO9PrDIqoJcz3/pmFX6Lbvoh24434oWFmrhrszGqohjI2b0NmoP9eF
         ZiKSQWxHyYaHTxniq75ZYAE+7ilvd+I1NRu/M=
Received: by 10.142.48.14 with SMTP id v14mr1759486wfv.133.1224298242381;
        Fri, 17 Oct 2008 19:50:42 -0700 (PDT)
Received: by 10.142.170.14 with HTTP; Fri, 17 Oct 2008 19:50:42 -0700 (PDT)
In-Reply-To: <48F93F52.4070506@pcharlan.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98517>

On Sat, Oct 18, 2008 at 12:43 PM, Pete Harlan <pgit@pcharlan.com> wrote:
> Hi,
>
> I'm looking for a way to manage an ever-growing list of tags.  I've read
> some git docs, but am new to git and wonder if the below method doesn't
> work or if there's a standard practice I haven't run into.
>
> Most of the tags in my repo are uninteresting to look at, but can't be
> deleted.  (Code releases for the most part, or stalled topic branches.)
>  If I wanted to archive those, it looks like this would work:

Is it really true that they can't be deleted? The only reason to avoid
it might be for preventing Git's GC from cleaning them up, but if all
your branches/tags are reachable via "interesting" branches/tags then
you could just slap the tag name and SHA1 in a text file somewhere.


Dave.
