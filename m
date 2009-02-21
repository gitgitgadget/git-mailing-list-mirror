From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow to pre-commit
Date: Sat, 21 Feb 2009 06:05:25 -0800 (PST)
Message-ID: <m3k57jsx36.fsf@localhost.localdomain>
References: <499EF2B6.7060103@hvoigt.net>
	<C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com>
	<499FDDC2.90502@hvoigt.net> <200902211216.43964.trast@student.ethz.ch>
	<49A00215.9070106@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 15:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lasdk-0007tz-RN
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 15:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbZBUOMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 09:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZBUOMg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 09:12:36 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:47267 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbZBUOMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 09:12:35 -0500
Received: by bwz5 with SMTP id 5so3488177bwz.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=cSdahygzZ0xf0fovbkrHsBdcktZiIgIhSG2ehP062rY=;
        b=x/Px4iaChRbWU400ZuQnVqVD/gmti+gwudjqlPdbadPr/vsma+NZyti2FbhAYkuwF9
         UKDmf8PHraoVK8Qly80l6iW4TPkvgRlQW2huH+zl6HH8At84CKOvYf24xDCw/3QdZ9xj
         cRo+A200rPnIT+yHe29rlgpTrrq6fq2A1eyng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rne1Aci9UIeGADzW7OHimfLXFgrT0fJRwMKnQIwtshJMj089A88QVX47MYg12KxKp0
         +FXhUx3+ihZftDE6FXIUsCwd328A0XQitIcdYeYK2jO0TfRJu3bf2cWO0uvM8seAI3Ie
         683TugUvPJwXpR/TOi8f9lYOGI+wu5ymE0THw=
Received: by 10.103.252.17 with SMTP id e17mr2378930mus.14.1235225125607;
        Sat, 21 Feb 2009 06:05:25 -0800 (PST)
Received: from localhost.localdomain (abwx73.neoplus.adsl.tpnet.pl [83.8.247.73])
        by mx.google.com with ESMTPS id j2sm1772933mue.54.2009.02.21.06.05.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Feb 2009 06:05:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1LE6wli020550;
	Sat, 21 Feb 2009 15:06:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1LE6rQs020547;
	Sat, 21 Feb 2009 15:06:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49A00215.9070106@hvoigt.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110954>

Heiko Voigt <git-list@hvoigt.net> writes:

> How about combining my first approach with the second idea? Teach git
> different default sets of hooks. So something like:
> 
>    git init --workflow="topic-branches"
> 
> would initialize and install a certain set of hooks.
> 
> Implement the possibility to propagate this setting to the server, by
> using a config variable or similar. This way only secure hooks will
> automatically be inherited and the user has the benefit of a more
> specific workflow support.

Well, for an _installation_ of git you _have_ possibility to provide
hooks different than default ones, and that is via templates system.
With "git init" in already existing repository you would be able to
pick up new version of hooks.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
