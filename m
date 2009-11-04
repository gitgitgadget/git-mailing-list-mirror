From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for
	bare repos
Date: Thu, 5 Nov 2009 00:52:42 +0100
Message-ID: <20091104235241.GA12984@vidovic>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net> <alpine.DEB.1.00.0911041422170.2788@felix-maschine> <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5pem-0006oe-Kk
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373AbZKDXwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758262AbZKDXwm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:52:42 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35001 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbZKDXwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:52:41 -0500
Received: by ewy3 with SMTP id 3so3744995ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 15:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=UAzHARc1EC3y36RqZTXPUKywY41yCxY3GcK0FBW6Xi8=;
        b=eTbEGxiyNfr6zOrtpNYB6HPTs3dkDBB9QUPCEJa2axrwOUAYSuTfKMp0PFYM2lZxDH
         rHOdrRtouVRJY5FPm0w7xlOOLoIu9SB6ivvFZQKlpJLCVU/HdPR9vFL0ocPypI+5FEeZ
         7e8ovc+tiXjBsSm1nBmJCz8qNrY12bcAOdRA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jmI20EYiZM9GewR2XwoyHZd0A67tZaR0WAhJsGIidtKJ294NJRuX81QD3Rc0GQy1Lv
         1YE6MGAYchQUdvsJAPTA4NhSv5R9yt5oTgNq+FW6O4lDBiKvb3tZaHUop6gtJy0cFYhL
         MUCLB1CSHnDUQ/MFv8pEFEpj6A7KPITT6dQGs=
Received: by 10.213.97.30 with SMTP id j30mr3014726ebn.94.1257378765898;
        Wed, 04 Nov 2009 15:52:45 -0800 (PST)
Received: from @ (91-164-138-67.rev.libertysurf.net [91.164.138.67])
        by mx.google.com with ESMTPS id 5sm494780eyh.26.2009.11.04.15.52.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 15:52:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132174>

The 04/11/09, Sitaram Chamarty wrote:

> But if you are able to do "gc" manually on any repo you can also do
> "reflog expire" before "gc" can you not?  Please correct me if I'm
> wrong.

"If we are able to do 'gc' on any repo"... But a lot of users aren't
able to it because they aren't the admin.

Or did you mean if "non-admin users could" ?

-- 
Nicolas Sebrecht
