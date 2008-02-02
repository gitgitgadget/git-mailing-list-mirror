From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A note from the maintainer
Date: Sat, 02 Feb 2008 03:06:50 -0800 (PST)
Message-ID: <m3hcgr7h2z.fsf@localhost.localdomain>
References: <7vlk64562x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 12:08:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGE6-0000TE-Ku
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbYBBLGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760068AbYBBLGy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:06:54 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:50634 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760050AbYBBLGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:06:53 -0500
Received: by py-out-1112.google.com with SMTP id u52so2142651pyb.10
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=yb5hdSRQRqWY1MGAv+gGTqCME2fe909HMimZe6OdTIM=;
        b=Warce1gVzJSBhUsHkQKr5KP+IBxRu410b2MlwDAkXlwS/yYMuTaj0WMUHVClH9flktJ1zzisxvjgBvXAQGWy+j5gCuKimk9VjNV6qrz81tWedJXo4vrGVMhT7/UVBcAlcnJ5PITklE9drdffyrMXYVxrlISODnNvSi4TiPCv6Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=OeynlCGWegXE4cXoGQ6wd+W6dtapi2UvWZtFJ6EG/nABOMykOG9UfXk6GmPOOkQ/g++bhuB8Ayxl99oPkDSa/eqW9+sW+AJFWjmCYEX0BdKXIVxSY5RdP65u1EQm67uZUbieX/9Os5BfAuYQM7aPce3twXf5egrFrlKDpccsBmc=
Received: by 10.65.96.6 with SMTP id y6mr7894578qbl.24.1201950411732;
        Sat, 02 Feb 2008 03:06:51 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id f4sm5351307nfh.31.2008.02.02.03.06.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:06:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m12B6jEw029312;
	Sat, 2 Feb 2008 12:06:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m12B6igq029308;
	Sat, 2 Feb 2008 12:06:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vlk64562x.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72259>

Junio C Hamano <gitster@pobox.com> writes:

> Now a new feature release is out, it's a good time to welcome new
> people to the list.  This message talks about how git.git is managed,
> and how you can work with it.

> There are four branches in git.git repository that track the
> source tree of git: "master", "maint", "next", and "pu".

Actually there are five: you didn't mention "offcuts" branch,
nor wrote what this branch is about (for example how it differs
from "pu").

>  gitk     -- this file is maintained by Paul Mackerras, at:
> 
>              git://git.kernel.org/pub/scm/gitk/gitk.git

It is gitk-git/ subdirectory now (why not simply gitk/ ?).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
