From: "Stephen Cuppett" <cuppett@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 12:58:47 -0400
Message-ID: <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 18:58:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDkCM-0008Fq-Fv
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 18:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbXGYQ6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 12:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759822AbXGYQ6u
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 12:58:50 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:32950 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbXGYQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 12:58:49 -0400
Received: by py-out-1112.google.com with SMTP id d32so470480pye
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 09:58:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ve9m4J6cxgvGQZvzIz1CdZ434eJyGJzcrzPLvsmrpsnZ5I+fEWirlV7Bz/AOp9e5ViujJ6EV22qOWsiQEifyteKxDnTyXwhnVZJ097ZOBnl8htCvr/Tkmh/5912cp1Ff0oFhmJoXZxmYRSMtOdesWNDJ+ek+ffeZ0YjGG2duISc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hdn2/bDXVLdCNiQXSJbu7E8gG/dipX1MfOKMeiL47kyY2l+qjC8bLUzCWQQlfblMa0FIdw4VPzXGl4qI6u6yBzN4zXYYmV4jFnkhHmFiYIPX73jHZiK0kGUErXpTb/CKFhNDvDAS3FlqIKdt8QcjDp3mrWo1APUreJ0odcjeBPs=
Received: by 10.64.179.12 with SMTP id b12mr1482339qbf.1185382727887;
        Wed, 25 Jul 2007 09:58:47 -0700 (PDT)
Received: by 10.64.47.16 with HTTP; Wed, 25 Jul 2007 09:58:47 -0700 (PDT)
In-Reply-To: <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53701>

On 7/25/07, Steffen Prohaska <prohaska@zib.de> wrote:

> Is it just that windows developer hate cygwin because it's to
> complex to install or is there any severe limitation?
> functionality? stability? performance?

I actually have no problems with cygwin and find it works pretty well
with git repositories.  Starting the xserver to run git-gui is pretty
annoying though.  Windows-based development teams are going to expect
easy access to those kinds of tooling.  Otherwise, the champion will
be pushing a type of workflow change that would hinder adoption anyway
and leave a sour taste for a long time.

In addition, performance is atrocious.  In my particular case I have
an older P4 running F7 and a newer machine running Windows and cygwin.
 On a pserver based cvsimport of a large, enterprise project, Linux
was able to generate the full history in 4 hours, cygwin took 3 and a
half days.  When I sync up every now and then, typical times for
windows are 25 minutes and Linux is around 4.  That should give you an
idea of what kind of multiplier we are talking about.

I don't know if the performance problems are cygwin or not.  More
knowledgeable people might be able to answer, it's just what I'm
observing right now.  It could be more fundamental to the types of
access being performed en masse on inode-based versus NTFS systems.
