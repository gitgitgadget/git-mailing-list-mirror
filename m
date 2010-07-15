From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Thu, 15 Jul 2010 12:55:27 +0200
Message-ID: <20100715105527.GC22574@debian>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 12:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZM4j-0008Re-5j
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 12:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026Ab0GOKxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 06:53:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53072 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933014Ab0GOKxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 06:53:44 -0400
Received: by eya25 with SMTP id 25so123946eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MaCLFaPUdIhqJqGLakJs0ie+8MvzRVpi/1we58n0Yxc=;
        b=COch0/4EmF47nQ2h2giOdGXGX11lRdBzVDFHz5C9q7RLSs2G461DAY3GoYVI6VMEVs
         WS9grTwLtm0mOt5HqrO1qR/F1t/Zak1YMdla2iDCTRi0fMO8RRDvLUo/9gErquEttvIO
         Cwdaw7HjebuiN1ZzEOw9eIeAK7RJ8+TAKw3Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XIQygNeSC2Hl5BHe3csX223Nd2unMRgME3zjq7Gsm/csVNWzLu8hLsmFH56AnCy0Rr
         tPzN4i9PUoPociDLAOYwjToSFIU3zU6zmierBAHcyJh1eCZXcE5rVg42XD4mo/n0pDsj
         91lPdlrzQgkAQ1WIbRn0dfm0DJNyE1zV2kQ0Q=
Received: by 10.213.3.83 with SMTP id 19mr5547147ebm.5.1279191221731;
        Thu, 15 Jul 2010 03:53:41 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm7147922eei.0.2010.07.15.03.53.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 03:53:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151073>

Hi Junio,

Junio C Hamano writes:
> Given you'll be maintaining a variant that can link with 1.6 subversion
> libraries anyway, I'd rather see you host this as an independent, related
> project, perhaps at repo.or.cz and/or github.com, and add a link to point
> at it at https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

I think that sorts it out then. Thanks. I've merged this series into a
new project on my GitHub [1]. I'll soon convert whitespace/ style and
add some instructions, and maintain a branch that compiles against
libsvn 1.6. Until svnrdump is in a re-usable library in the ASF, I'm
afraid the git-remote-svn toolchain will simply have to spawn the
executable and read the output from a pipe. Instructions can then be
simplified to: compile `svnrdump` and place the executable anywhere in
your $PATH.

[1]: http://github.com/artagnon/svnrdump

-- Ram
