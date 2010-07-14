From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 13:26:20 +0200
Message-ID: <20100714112620.GC3496@debian>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
 <20100714001530.GB2308@burratino>
 <20100714002235.GF12639@debian>
 <20100714002843.GC2308@burratino>
 <20100714004959.GG12639@debian>
 <20100714070323.GB25630@jack.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Stefan Sperling <stsp@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 14 13:24:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ04v-0001wo-9u
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 13:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab0GNLYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 07:24:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48025 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0GNLYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 07:24:35 -0400
Received: by eya25 with SMTP id 25so970341eya.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=96c0aDAep8zR6E63Z1mKLU5R1KGVHCpeNaT4aVOLgZg=;
        b=XujnHkERFQqczH+qYaVX6phvTtxvUJ1W2MTJxvqWHkmHQVXhtlSn+PF9l6OIFni37l
         RMBfPTzVEj/q7d4X9OJL3/2qSVxRxnuL5nFmeK/7JJtxtilmXXSup1JdOeboykcPBZxi
         mCV20eOXz9k586l45cxa2EXFokzNTJESNjBbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NxpPqRKvB8cJ4LC/MOkApv4xaDmB9kFsG4XA7F7adbLtHZEMNCcGIE0etYuNIE7tpP
         cPfjNWp3NEFRtG6y1yVi/KDGuK24siJHVmw19smmvkwdqe3O9WgGBB+6fQoaderXx4y9
         e9o7b3LXq8qqaKYKf/qz8OU/FnrklxDsf9mMI=
Received: by 10.213.25.130 with SMTP id z2mr1152066ebb.42.1279106673918;
        Wed, 14 Jul 2010 04:24:33 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v59sm56395699eeh.4.2010.07.14.04.24.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 04:24:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714070323.GB25630@jack.stsp.name>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150979>

Hi Stefan,

Stefan Sperling writes:
> Git devs will want a version of svnrdump that compiles against
> the 1.6.x libraries. We'll want a version that compiles against
> the trunk (so we can release it with 1.7).
> 
> So depending on which APIs svnrdump is using, it's likely that
> you'll have to maintain 2 slightly differing versions anyway,
> until 1.7 is released. (The current ETA for 1.7 is autumn, BTW).

Right, that's alright. I'll just have a commit that I'll keep `rebase
--onto`ing to have the 1.6-specific changes.

> > Also, could the Subversion
> > people confirm that licensing isn't an issue?
> 
> I didn't catch any licensing discussion. What's the issue?

I guess there's no issue then- sorry, I know close to nothing about
licensing.

-- Ram
