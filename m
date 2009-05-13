From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Re: update @version in file
Date: Wed, 13 May 2009 12:04:15 -0400
Message-ID: <20090513160415.GA4097@andros.launchmodem.com>
References: <1242205190383-2879913.post@n2.nabble.com> <4A0A8ED8.8000905@op5.se> <m3iqk5l4ps.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, takeshin <admirau@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 18:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4GwX-0002Hj-8L
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 18:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbZEMQEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbZEMQET
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 12:04:19 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:10038 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbZEMQES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 12:04:18 -0400
Received: by yx-out-2324.google.com with SMTP id 3so393456yxj.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cZYVkzgk7fhMiDJxTAxqJzqjDa58p5I0fcok3FSi0iM=;
        b=Ru96CNEM0mj+NFBgk5kiSSxPSD/goUxsBtpHaTDgkuKPwUfp1kfOe+/NSALea1O+hI
         O6g/0O81jsenQPoZeCrFlDYCbtreRWyutBw4ggFvtT4lpXPuym6XFskUkaaNNO3j9XgS
         mqj7tB+iPFWIrE4MRDj0FZk7tIts/YmQZq2QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a0P5vDOvbVuXBLed9lPLsER3/RuX/m7XdWeJNpzJ0MsYNkYo6iAQukbp0SeVymldab
         Amwj1/2aU6Y3LrRB4ywP71+wvKAATTt9jPOBQ57gzciK53x8Pldbax5fMmSTvqkRhP1/
         0VQV9FRc4JRxy6biqtVUyNDDNNLabXqCBV2vk=
Received: by 10.90.118.8 with SMTP id q8mr889588agc.80.1242230659296;
        Wed, 13 May 2009 09:04:19 -0700 (PDT)
Received: from andros.launchmodem.com (adsl-065-006-168-015.sip.mia.bellsouth.net [65.6.168.15])
        by mx.google.com with ESMTPS id 10sm228261agb.36.2009.05.13.09.04.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 09:04:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3iqk5l4ps.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119060>


On 13/05/09 02:42 -0700, Jakub Narebski wrote:
> Andreas Ericsson <ae@op5.se> writes:
> > No, but see GIT-VERSION-GEN and "git help describe" for info on how to
> > replace such version tags using a script when you cut a release of your
> > project.

Couldn't Git be a little more friendly? 

You can choose to ignore an uncommitted file through the `git update-index 
--assume-unchanged` command. But AFAIK, Git doesn't allow one to ignore 
uncommitted _lines_ in tracked files. If this feature were implemented, a 
post commit hook could write in the latest commit hash and git wouldn't care.

Is this something that is worth pursuing?

      Dan
