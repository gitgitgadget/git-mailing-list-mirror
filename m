From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: Start git svn clone at specific revision for cloning subprojects in large svn repositories?
Date: Wed, 22 Oct 2008 08:07:47 -0700
Message-ID: <8c9a060810220807q14ede199u205d35223f8a4710@mail.gmail.com>
References: <pan.2008.10.22.15.00.21.403423@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff Kowalczyk" <jtk@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:09:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfKf-000752-2Y
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYJVPHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYJVPHz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:07:55 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41164 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYJVPHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 11:07:54 -0400
Received: by gxk9 with SMTP id 9so7499021gxk.13
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=laVODzFfZ9tnIlr+2G033RhAk40cdNsNqSjPd1ElP9c=;
        b=BUQTqc350pq6QbMgqou1z7zZWrhX84glk/wSSs1a6+2UWE5mraLse3FmfoRExrURka
         yV2Z83oOuPj8tA5n8lVOBVt1SsFR4NBwWsbnz73NfEi90Ln6s4Dw9GguDC1yV1OFWWl5
         ZUchqposOkJXrmTRLbkIh/z2Cz1MhQ47KmDao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a2wDGyd0KQHFBqNSTceElwcvDt8u9WwryGZrSd3cVj3IO24ENhBkRRGbWvpE4obu9a
         ptdvGvVyN5FWIr0MrKatgh/2bovLuAJFmFjN21bD+yTTE7zg2ylhmADD/R7IvUiFFQe3
         08ZthPATwBY65l1SddPZ2hhi0btU9B3MTTTvM=
Received: by 10.142.180.11 with SMTP id c11mr4391094wff.159.1224688067626;
        Wed, 22 Oct 2008 08:07:47 -0700 (PDT)
Received: by 10.142.215.8 with HTTP; Wed, 22 Oct 2008 08:07:47 -0700 (PDT)
In-Reply-To: <pan.2008.10.22.15.00.21.403423@yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98876>

On Wed, Oct 22, 2008 at 08:00, Jeff Kowalczyk <jtk@yahoo.com> wrote:
> I would like to git svn clone subprojects from a large community
> subversion repository (plone collective).
>
> The repository is currently at 74K commits, but subprojects of interest
> are typically much more recent, and their initial import revision is known.
>
> I would like to avoid a) unnecessary traffic to the svn server and b)
> the very long delay in git svn cloning these subprojects.
>
> Is there a way to specfiy a starting revision to git svn clone?
>
> Thanks.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Try git svn init, then git svn fetch --revision <revision#>:HEAD.
This is what I use for some of our larger projects at work.
