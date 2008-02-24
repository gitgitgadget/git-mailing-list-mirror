From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 02:03:27 -0800 (PST)
Message-ID: <m31w72d63a.fsf@localhost.localdomain>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git mailing list" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTDiI-0000N1-7O
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbYBXKDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 05:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbYBXKDb
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:03:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:10734 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYBXKDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 05:03:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so377098ugc.16
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 02:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=UHQxT6H0s97AAdEqS3CpP8qJ5AaF34cPh/dHjO0HCaY=;
        b=Qer9Ur4lts0WaKO7A1tCfslJE1iJPBCv360rwLXOeh1ajVBvGPcVsqU3jMncS5tsVcSPwpGiiHn8vra4hhzMC3T2xQHd6hlWvoPsCxr6HuFtAp6peJ3eiVVOGQQ3ZqJ9JH2mlYtYPiaVliu6+MJYvh76jlGULE34ZPBbqk2xPCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=lD4nqgnRuXYYAPZ2PEGhhUhZM/zvPCXEv+WUQ6K+Bs+ghghAEiAZOjdseTIh7FJq74EpfnYC7EwLmkt6oZNb2YAaZ/w5izkYD8/ckQ262yeAzUamwPsC07TQpJOp5ixuxKINjqtTu3hopzp5PmztCTijS8OfPwyl2KNzMqiJ0os=
Received: by 10.66.219.11 with SMTP id r11mr1576764ugg.31.1203847409071;
        Sun, 24 Feb 2008 02:03:29 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.46])
        by mx.google.com with ESMTPS id 5sm950838ugc.25.2008.02.24.02.03.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 02:03:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1OA3MxW020405;
	Sun, 24 Feb 2008 11:03:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1OA3Ljs020402;
	Sun, 24 Feb 2008 11:03:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74917>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> I'm going to implement subtree checkout. The plan is to save "index
> prefix" in GIT_DIR/prefix and update git commands to use index prefix
> when accessing the index. If I'm heading a wrong way, stop me now.

If I remember correctly previous trials to implement "partial
checkout" ("subtree checkout") feature, or at least discussions about
it, used index extension.

As far as I can see the problem lies in merging...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
