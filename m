From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: suggest --amend --reset-author to fix commiter
 identity
Date: Fri, 7 Jan 2011 11:34:28 -0600
Message-ID: <20110107173428.GC16571@burratino>
References: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110107171329.GA16571@burratino>
 <vpq7hegmy66.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 18:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGDB-0004tX-Lm
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 18:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab1AGRep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 12:34:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60426 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab1AGReo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 12:34:44 -0500
Received: by fxm20 with SMTP id 20so17135284fxm.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7X53nOMPEOK4KJYg8Cew+8cEmhW747oZCJwZKCInP7o=;
        b=DdH7FJqmFna+wnXxc69wG3I7D3lUK2SHQC3EyJTE6uL44GtczlhnH02WqhmMModlis
         JcRj0YjWFTFbriDgVSxKBmeO3WauV/21d0X19bslOIyQf977KP2+SS6WWaDwVhb2EKDU
         nFKbPFtUGJQYFjMpQgF1H6WP4fDh/ghvxtVEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oaropekXq/QgBaSnvVkq5qxVs/CBnu0LWzZR126IMaBN5PUh4IuesQx07V4UjPIvVI
         CHrGcAZwhmLUHQBxiMzATf2yECEnQr19x8NSdUl5GD2K8aCSDfEKMKCgCUU9TGUBA3zJ
         6DrBXCSK4VfLWxGTi5TKnHRS9mgz+YkvMvaaw=
Received: by 10.223.103.6 with SMTP id i6mr2988938fao.84.1294421682680;
        Fri, 07 Jan 2011 09:34:42 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id n1sm6222130fam.16.2011.01.07.09.34.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 09:34:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpq7hegmy66.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164725>

Matthieu Moy wrote:

> The complete message says:
> 
> "Your name and email address were configured automatically based\n"
> "on your username and hostname. Please check that they are accurate.\n"
> "You can suppress this message by setting them explicitly:\n"
> "\n"
> "    git config --global user.name \"Your Name\"\n"
> "    git config --global user.email you@example.com\n"
> "\n"
> "If the identity used for this commit is wrong, you can fix it with:\n"
> "\n"
> "    git commit --amend --author='Your Name <you@example.com>'\n"

Sloppy reading on my part.  So the original text explains:

	how to configure your identity globally
	how to change the identity for a single commit

> "\n"
> "or\n"
> "\n"
> "    git commit --amend --reset-author\n";

Maybe:

	If the identity used for this commit is wrong, you can fix it:

	    git commit --amend --author='Patch Submitter <author@example.com>'

	To just use your newly configured identity:

	    git commit --amend --reset-author

(modulo wording).  The idea being to make it clear to the user why we
are telling two ways to do the same thing.

Sorry for the nonsense.
Jonathan
