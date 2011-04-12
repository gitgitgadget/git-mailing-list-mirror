From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFH] eol=lf on existing mixed line-ending files
Date: Tue, 12 Apr 2011 09:57:16 -0400
Message-ID: <BANLkTik9oKJSx-=dt0o28oqQ67p-OTX_qg@mail.gmail.com>
References: <20110407231556.GA10868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Mislav Marohnic <mislav@github.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:58:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9e6R-0008OO-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 15:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab1DLN5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 09:57:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58752 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab1DLN5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 09:57:47 -0400
Received: by bwz15 with SMTP id 15so5383053bwz.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wY7MEhKvnW9n84JM4fAq2Up1L77OqKqNl9ytpM5pGWw=;
        b=X6p85XYvIefcTDo9B3Jb9ipoXePdou8zTcOyQbBFug1k7k+LRpI8Ohc1wHcxw/6H9w
         JcZLJ1Hr6IQEb8cqtSLYdCOMoBBrrCNexxoU8kV4dSX+VqUHMA3UZjlLxLVf3+I0SGpf
         mvjniOoBEQU/x/pfsI/wz+ImuqTG187MIA+E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aZ2kKflinVhMCQAE801emvAkiMCZ1vSlbXmkPjS+Yx82NEdwOym/2jZrBa1CL7JXwk
         6W4vmxI0pnpSQtLnP0DRmYyYnpbbB324hQuLjbxlZ+gxJd4+2C6DS7mwWpkSXqLd8JG6
         KtzSgjUQh/GOQ3A2XgECcGW1RF3yw4iyWReaA=
Received: by 10.204.49.87 with SMTP id u23mr6179567bkf.171.1302616666112; Tue,
 12 Apr 2011 06:57:46 -0700 (PDT)
Received: by 10.204.82.80 with HTTP; Tue, 12 Apr 2011 06:57:16 -0700 (PDT)
In-Reply-To: <20110407231556.GA10868@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171393>

On Thu, Apr 7, 2011 at 7:15 PM, Jeff King <peff@peff.net> wrote:
> I investigated some odd git behavior with the EOL gitattributes today,
> and I'm curious to hear what others on the list think of what git does.
> In particular, index raciness means git produces non-deterministic
> results in this case.

Relatedly, http://article.gmane.org/gmane.comp.version-control.git/169476

j.
