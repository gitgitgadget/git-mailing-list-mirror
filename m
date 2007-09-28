From: Dan Farina <drfarina@gmail.com>
Subject: Re: backup or mirror a repository
Date: Thu, 27 Sep 2007 17:51:44 -0700
Message-ID: <1190940704.2263.32.camel@Tenacity>
References: <1190921742.2263.17.camel@Tenacity>
	 <Pine.LNX.4.64.0709272255360.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 02:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib45K-0000wz-Fq
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 02:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbXI1Avz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 20:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756896AbXI1Avz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 20:51:55 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:48102 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbXI1Avy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 20:51:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2461301rvb
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=UkzxheqbzCfuSlxubuPpE0acIsFM/gBGp4V0zEaRvwk=;
        b=t1EaxkJPho+gh6afJ30Z+fJ5yxZyOpCFbqDy50p5BzVWCJfiC8AmW5JmiMC9SeI3pU+peuOVKbfGOEXYOT896MJ3leVyvFyOsAUEt5opfZp+AUfVdtgsLUD/D15NVjbXeJvupfAcc2LZq/PYlBXvDgo4YnzGrzVp7UV/xPNubhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Wm6Io6EC29AUaIegVU94GbvZBJpKNvciHY9HwWh76BIXP2rad9QRr1Jb5P25Hf8PD7SNOa6RW99COQCjzcXZUyvvAfMSantRgnXkuEC8EaId1Y9BlrocAthr9CCDPh+UrtIseyxVnjG7fT62FAXh3dfegwUJS6Kwg7eU27zUX+4=
Received: by 10.141.50.17 with SMTP id c17mr1290221rvk.1190940713709;
        Thu, 27 Sep 2007 17:51:53 -0700 (PDT)
Received: from ?192.168.1.101? ( [71.134.240.3])
        by mx.google.com with ESMTPS id b39sm5070870rvf.2007.09.27.17.51.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 17:51:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709272255360.28395@racer.site>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59349>

On Thu, 2007-09-27 at 22:56 +0100, Johannes Schindelin wrote:
> I guess you're looking for "git remote add --mirror origin <url>".  AFAIK 
> this is not in any released version yet, though.

I just tried a bleeding edge git with --mirror.

It's close, except (unless there is some other provision to take care of
this) remote branch deletes. (Which, after more gmane trolling, seemed
to be "git remote rm", which doesn't seem present just yet).

Of course, it is completely possible I'm using it incorrectly. In brief,
I did "git init" "git remote add --mirror backup <url>" "git
pull" (perhaps I should have used "git remote update"?) And the behavior
of this is more or less what I wanted, as far as sending branches.
Convenient removal of branches and propagating that removal still stumps
me. Is there a preferred way to do this yet?

Thanks,
fdr
