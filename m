From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 20:15:24 +0200
Message-ID: <20090728181524.GC16168@vidovic>
References: <200907280513.59374.elendil@planet.nl> <20090728142219.GA16168@vidovic> <200907281938.24960.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVrD8-0006I0-9t
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 20:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbZG1SP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbZG1SP3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 14:15:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:35334 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbZG1SP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 14:15:28 -0400
Received: by ey-out-2122.google.com with SMTP id 9so60902eyd.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=9h5/deaRRXIM7U9V3s3m8J4liZrq0mfL/brbkEeMwxE=;
        b=rd8vBj+sfcbzXumWJX7TqbF9TYmdMJUYHDrCt0aqI5zqdd7EYxws18TyzkSso5b9RE
         m6qJMXcCHl6bwA2H56p7mgGxkcZUpJK1hxMZzzxIqMqF55R76xLryUAdKsMyKQ76lbIT
         rI/gfHQZ4bAFT+IySgO7jakNHg2H3Cmkcaf2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AHWuV3Y7xadBMaR/nxXyoHb/TyJWg6/SYhB3o9qMABJ9PmlVTfhMDuWYBkUH13XvXL
         pJJqat973d8lUF46MfJI8kPuXlwRRR5gzFvLPG7SRzI6hc6LJoIKmgVvzN30OfNjTS3K
         UqmDI35UnCKliOi6X0mC3Z+77bUvlhF0sd75Y=
Received: by 10.210.61.8 with SMTP id j8mr10375109eba.2.1248804928328;
        Tue, 28 Jul 2009 11:15:28 -0700 (PDT)
Received: from @ (91-165-131-3.rev.libertysurf.net [91.165.131.3])
        by mx.google.com with ESMTPS id 24sm276521eyx.53.2009.07.28.11.15.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 11:15:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200907281938.24960.elendil@planet.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124268>

The 28/07/09, Frans Pop wrote:
> On Tuesday 28 July 2009, Nicolas Sebrecht wrote:
> 
> If my feature request is implemented I'll of course make sure to omit the
> '---' line if needed.

This is already done.

> Here are some other examples (some of which would equally need to drop or 
> change a separator line).
> http://lkml.org/lkml/2009/6/25/62

Uses "From:", "Date:", and "Subject:".

> http://lkml.org/lkml/2009/6/22/114

Uses "From:" and "Subject:".

> http://lkml.org/lkml/2009/6/30/109

Uses "Subject:" only.

I guess there are as results as contributors but it could be possible to
add some rules to the format. This could ending up with an unuseable
feature in practice, though. I don't know.

> http://lkml.org/lkml/2009/6/30/224

Broken link ?

> As Mark Brown has already said, that won't solve the issue for an 
> introduction or comments added by the sender of the mail.

True.

> Also, people use all kinds of quoting schemes, not just leading ">".

And people don't use the same rules with the "inline headers" too. :-)

> And I've also seen plenty of cases where quoted lines _were_ a desired 
> part of a commit log.

Yes, that's why it's an _option_.

-- 
Nicolas Sebrecht
