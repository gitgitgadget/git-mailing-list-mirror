From: "Miles Bader" <miles@gnu.org>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 22:29:13 +0900
Message-ID: <fc339e4a0810290629g57c6cec3idcbc4b1c1d5d0159@mail.gmail.com>
References: <49082514.9050405@gmail.com>
	 <buoprlj4vle.fsf@dhapc248.dev.necel.com> <490833AD.70806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Liu Yubao" <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 14:30:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvB82-00088g-7n
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 14:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbYJ2N3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 09:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYJ2N3P
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 09:29:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:42311 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbYJ2N3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 09:29:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3310938rvb.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=JKdfoRStyAwVObZAD1q8Bkxk1FOPSujs4qB4xrIaqEw=;
        b=YATQgKFntROAPJOuhqZtcU3E1UByQaR+x4/uQP+IZicAl7tMdvnNzDuu8E55P4rlgz
         pOTGPSGdLG4j3zryRshXwAsPd7vdUQjrXzu9aebPQM9eubUfc7j/ogAr2djsW8vdQNoI
         OqsefWv0LhgkVm0Q5VnbRwOakXNkw+j1h2xiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=XabhhTJhF2MdsrKPHAFwfLhajAFE1uhJplBaJCp/BEn550YkYurY1ffc7ROxlYRFOA
         a0O/YI5d7It4dn5+9FZGAYmQTdhDjwOaFB7kXFKyEgpQKzkcorthL1W+6BoSqw2iFsS8
         UPHgL2hMOF5ZyQ1stsya7KTdGeAX9n+xRwsrs=
Received: by 10.140.133.10 with SMTP id g10mr4889562rvd.151.1225286953757;
        Wed, 29 Oct 2008 06:29:13 -0700 (PDT)
Received: by 10.141.106.8 with HTTP; Wed, 29 Oct 2008 06:29:13 -0700 (PDT)
In-Reply-To: <490833AD.70806@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: ae735572aecf4c07
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99363>

On Oct 29, 2008 6:58pm, Liu Yubao <yubao.liu@gmail.com> wrote:
> > Extremely useful. I usually keep local branches closely synchronized
> > with a remote "central" version, and tracking branches make the frequent
> > push/pull much more convenient.
>
> In my work flow, I don't keep changes in local branch for long time,
> I rebase it regularly and push them to central branch or discard them
> if the upstream rejects.
>
> You are right, I realize tracking branches is useful for people who keeps
> local changes for long time and track the upstream branch at the same
> time.

I don't keep local changes for a long time, I push daily. The local
tracking branch and the corresponding remote branch are basically copies of
each other, in different locations. I also do regularly rebasing, but
against a _different_ remote branch.

There are never merge commits, because all merges done by pull are
fast-forwards. If I were to push changes from multiple working directories
to the central location, I'd have to be more careful about the pull-merging
-- a rebase-on-pull as you suggest would be useful -- but I generally don't.

-Miles
-- 
Do not taunt Happy Fun Ball.
