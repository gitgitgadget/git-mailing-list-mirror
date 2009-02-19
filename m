From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git merge --abort
Date: Thu, 19 Feb 2009 15:26:48 -0500
Message-ID: <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFVk-0002y2-9d
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZBSU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754405AbZBSU0u
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:26:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:10832 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZBSU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:26:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so572079rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qfvvinNUpUwGyNxRDwBJY2dhHG+jyOsfHZAxAfwuUF4=;
        b=QrFQdz2CeYzsfRKm5mNYy3vFkBeOcUcXaAr3Vy1+QMkkWM9CpbiEMkBcA8n1uCwuAt
         QvTvzYRlwlqcYaj0ZEe3qWOmpa03Qo4niYhQC8QXxSavDw/xhW7R4sl7W5X/TU3iOCaW
         ZLFCtA0rHYXkPjkrvSQkq6rBXF/GDhU7gjXx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sqUoykJmlNf3tPyx8XX5vNGzU7CoL5iqtv9ZNZi5nsLYWG8uXlhsnG0nLI+oI5cpi7
         h1jS0p5B2/OuR0PL2O/PbyLgtjQ9O3pXa0BrIG2GF7SVUwNEqQlKg9SbYloaE7cMKi3p
         48WeF4EnXs3ENKZjgEhhCRoCFNbsMQOlJGJRs=
Received: by 10.141.50.11 with SMTP id c11mr3604539rvk.45.1235075209020; Thu, 
	19 Feb 2009 12:26:49 -0800 (PST)
In-Reply-To: <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110746>

On Thu, Feb 19, 2009 at 8:34 AM, John Tapsell <johnflux@gmail.com> wrote:
> There's no reliable way of getting back to the state before the merge?

Sure there is. Commit or stash before you merge, so that your index
and working copy are clean.

j.
