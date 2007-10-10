From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg branch command failures.
Date: Wed, 10 Oct 2007 09:47:15 +0100
Message-ID: <b0943d9e0710100147n5bcd52d4waa8b52efb41b4270@mail.gmail.com>
References: <cc723f590710092031w87511dfl6ee3b728375f0815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, kha@treskal.com
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfXDx-0004H8-IS
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbXJJIrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 04:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbXJJIrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:47:16 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:10866 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbXJJIrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:47:15 -0400
Received: by rv-out-0910.google.com with SMTP id k20so128715rvb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FdlRjLyoVbV59ssnISvPiPy/vQZvW4N5ZN9Zu1Qbwug=;
        b=mcfYE0M8LeLW/UlkHz2J5uBNn5wPJ8UjDXWAR+47QsVXhu9UeS6KEIwMt2d6YRcQHhGX9ttEdY2KVY3CF0VLbRW9yGJjb4iQVik0rN25spF7JJVIjW15aFnLFG0hSBQggf8d5/CCUNJ8bJwyi93qznMS8GlvKS82vycGL/nxiNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gumACgWkA3ZBDt482uQELmUnG2fMCAt5RWh7BMaQx07RCEMQrH2ozg5MnJYsSrHtlVsTyeNGoK0eBBUeGi5LoKY+AlDXsjTVckoe62WY5HHNGIT3L3AWx6P528JjkrIyqP4pFurGGRI4HHo1WOg4+bNtgscOeEOZdWkfmuLcKd0=
Received: by 10.141.23.7 with SMTP id a7mr168669rvj.1192006035082;
        Wed, 10 Oct 2007 01:47:15 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Wed, 10 Oct 2007 01:47:15 -0700 (PDT)
In-Reply-To: <cc723f590710092031w87511dfl6ee3b728375f0815@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60484>

On 10/10/2007, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> Both the below commands doesn't work
>
> stg branch --rename review test-large-file
> stg branch -c review v2.6.23-rc9
>
> It throws error
> fatal: Needed a single revision

What version of GIT are you using? I started getting this message
recently as well but only noticed it when renaming patches. However,
the operation completes successfully (the message is displayed by GIT,
not StGIT). I'll have to investigate.

-- 
Catalin
