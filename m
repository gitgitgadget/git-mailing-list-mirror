From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 01:58:25 +0200
Message-ID: <20100713235825.GC12639@debian>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYpLH-0005Sg-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab0GMX4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:56:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44812 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab0GMX4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:56:40 -0400
Received: by eya25 with SMTP id 25so900580eya.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9O2M87Bqo5VFpJt3cuYowOTNKCm5qtcFnxNPBL6v9Fg=;
        b=XKypwyGW7MBBjYp4wtIMffM0V72vNrb/upuw7u1IPSv+N1MlsmNgzPj2apoZ6fP2lg
         VJ+EcRmJI7dQZae1TUv0krj5yDpevobvrjMJlWy9zA2glDMFtikzwjjFQSO4mJ24TiGw
         yGpyz2yYjiL7Pq73DqvptAhsC7TVgbLm44Y/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vVuxyz8+dHRLKhX7xf9v19YJPnggLutxcDAvEZzIfHeFmat+uicVrWfX5rOZMPsmm1
         yY7bv8MYrPXRbv5Mu8w1Kv/HO8ZuuFpLBtBcOVdEtKi2qaZAo+lgKejSESTL1he6s0we
         iM7K+4SuQEKEA6DAIWIqOf92Ftq5jeHgh/P9Q=
Received: by 10.213.10.12 with SMTP id n12mr533550ebn.71.1279065398463;
        Tue, 13 Jul 2010 16:56:38 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm51580224eeh.21.2010.07.13.16.56.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:56:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150950>

Hi,

Just to clarify again, I'm doing this roundabout dance because a lot
of other work in the git-remote-svn toolchain (svn-fe, a new dumpfile
parser I'm writing, and a future branch/ tag mapper that some people
are working on) is dependent on svnrdump; compiling the Subversion
trunk just for svnrdump is both inconvinient and non-trivial. It's
alright if the git.git version of svnrdump rots for a few months
(before a Subversion release includes it), as long as it works and
doesn't halt future work.

Thanks.

-- Ram
