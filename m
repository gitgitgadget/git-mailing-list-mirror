From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo with git protocol?
Date: Wed, 17 Dec 2008 20:35:45 +0800
Message-ID: <856bfe0e0812170435t32fce496q41f825c01ee7045c@mail.gmail.com>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
	 <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
	 <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
	 <bd6139dc0812170353y5d78f03ao1c0619c9bd68f309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvlP-0008Ox-AE
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbYLQMnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYLQMnM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:43:12 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:44788 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYLQMnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:43:11 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Dec 2008 07:43:10 EST
Received: by gxk6 with SMTP id 6so430943gxk.13
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tH49zLPx8AG2lBdOujBqUg0QgYybWhPxw266sG1eSRM=;
        b=A+39GpSgDrnqj1B5lV/Tsq7HZVHMAf/IZE0SyvMuUYxcWLoVY+bO+yKlpsAWwnBCoZ
         WsneaZbrHKG9ltlCAgjLZKfGxA+roTLY2E7G/MVynJP1nOzLBeHIvgCTfON+t52I7MJw
         vEGBDHhaEiZUfLah6QQHRBKD/e+C+nZcM3fFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PUFykwUgU7jxMAWDmrc6UQcergAf53EWO6QtKQ5BpZuIcxvyY71mgH5sskVjbbx8v8
         yTByS0IqC89Wo4rW8Oys3SvWSBGWbAIAXYjtTTiEfMQ85tKS91Mpmnbc2woH3TNJzY6X
         0DfZeu4P44n7p5Vo63zosX3Kbk07wQOfuov9c=
Received: by 10.151.109.11 with SMTP id l11mr1279271ybm.183.1229517345394;
        Wed, 17 Dec 2008 04:35:45 -0800 (PST)
Received: by 10.151.11.2 with HTTP; Wed, 17 Dec 2008 04:35:45 -0800 (PST)
In-Reply-To: <bd6139dc0812170353y5d78f03ao1c0619c9bd68f309@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103347>

Sverre,
Thank you for your information !
As far as I know, gitosis can control someone readonly/writable to
some repo, it has no access control on branch/tag level. Am I right ?

I'll look at github and gitorious, are they free software ?

Thanks,
Emily


On Wed, Dec 17, 2008 at 7:53 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Dec 17, 2008 at 10:15, Emily Ren <lingyan.ren@gmail.com> wrote:
>> I want some group can pull these branches or tags from my repo, while
>> other's can't, Need I maintain two repositories ?
>
> I think gitosis should be able to do that? Otherwise you could look
> into hosting sites like github or gitorious, I think they have at
> least some form of access control, yes?
>
> --
> Cheers,
>
> Sverre Rabbelier
>
