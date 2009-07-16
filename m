From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v4] Re: git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 06:10:56 +0200
Message-ID: <20090716041056.GF12971@vidovic>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org> <eae6ce0ac7ff600e3e7ab261a5f020651e39ddfa.1247717023.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 06:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRIJM-0005bk-2d
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 06:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbZGPELC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 00:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZGPELB
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 00:11:01 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:39513 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZGPELA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 00:11:00 -0400
Received: by ewy26 with SMTP id 26so4544513ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 21:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=vancuAxZw0X//MV95wVaRgyxPgYcIFi4BZUF7fAwOiA=;
        b=sdI36Uj/DcAZMwuQdVR3D6wEgSrfed4bmrmMWS9Z+Y7cSFgmCg3OL+/MdmDXcshMqy
         dAYQhFgxGtAt0qT9w9xeGGotm44kD4oIQhHlS+kkVozUWJefrtRlm7HKok2HLjgddoiZ
         u+DfiaE0eHUJu9aknP7oJiayjja8XNcdcc7tM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vzS0fps+4H2tZi5ynpNJXW9hIr5ZOjNHAIrZR+ZoEHBAvqXNJDpwcP6wx+wyPIWhe2
         VPEUw61HcBrqljEVHGUoeRvVWsNuGy5nU7TcqE5hBlNEAa5IBulMq+tbr0OyLTfcOg/M
         uBGNY5EUpza70RzCoTZabbNmgTtJBqV2RJ5gI=
Received: by 10.210.28.4 with SMTP id b4mr51283ebb.47.1247717459806;
        Wed, 15 Jul 2009 21:10:59 -0700 (PDT)
Received: from @ (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 23sm3229830eya.49.2009.07.15.21.10.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 21:10:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <eae6ce0ac7ff600e3e7ab261a5f020651e39ddfa.1247717023.git.nicolas.s.dev@gmx.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123362>

The 16/07/09, Nicolas Sebrecht wrote:

> +	# then, accept (series of) email(s)
> +	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
> +	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null &&

And again, it's wrong here.

-- 
Nicolas Sebrecht
