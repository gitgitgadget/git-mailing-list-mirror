From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: After successful push, all files are listed as modified, uncommitted changes on origin server
Date: Mon, 28 Apr 2008 08:40:29 -0700 (PDT)
Message-ID: <m33ap6oump.fsf@localhost.localdomain>
References: <1d2b97db0804280834g8457151q658f54ff66e469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tyler Silcox" <tsilcox@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:41:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVUF-0007Ub-58
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbYD1Pkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbYD1Pkh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:40:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36387 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965007AbYD1Pke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:40:34 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1910211nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=IqheVf7/Nhnk5vN/CRvqLPoNAzE6ao/edXvw4jVgFsM=;
        b=H7Tnx3Bct+uJxZj2XKAZbuygbLzO35Gwo9TjouwmNTecKE+no8AYOH39GX/eclcWsSYFWMv61WxHxlVK0StlNMB4nqtK5A0cKD+rq8LyP6DZFp7vtmbPx0gZtyP1P4YDGxJB4EmouQhcrTKqxcM/sf7svyDb74O3s6RWzjP7RzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=BrO9AunUckLeIvF5eThlS1GV9e91087ZI/YuyQ7KKukwjm3FQK8+U66wmOGmoWFD4sZJxuuxUzbaUz7hb5qyXLKGTBX4x1Y9Nomwq/sHLz1MxzoPSO08BPXhNuWzMhiQAKNvjB88K6dMuigiUktPEg5zSU5cVnzUCYODzVABmBI=
Received: by 10.210.62.12 with SMTP id k12mr5937314eba.166.1209397232471;
        Mon, 28 Apr 2008 08:40:32 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.217.96])
        by mx.google.com with ESMTPS id b30sm9913023ika.8.2008.04.28.08.40.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 08:40:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3SFeWpQ024071;
	Mon, 28 Apr 2008 17:40:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3SFeVZK024068;
	Mon, 28 Apr 2008 17:40:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1d2b97db0804280834g8457151q658f54ff66e469@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80549>

"Tyler Silcox" <tsilcox@gmail.com> writes:

> Myself and another developer are both experiencing this 'issue'. We
> will run a local commit and pull (on Macs), then push to the origin
> server (which is on Windows.) If you view the git status, it will list
> all files as modified, but I can't pull any details about what was
> modified with diff. In gitk, it shows all the files under 'local
> uncommitted changes, not checked in to index', but again, it doesn't
> tell me what was changed, it just lists the file names in the left
> column.
> 
> I'm thinking it's an OSX file browser process that is modifying the
> files' meta data when git is checking the repository. It is not
> affecting our workflow, but it is an annoyance. Any info that can help
> prevent this would be appreciated.

This is not the case of "do not push into non-bare repository"?
Or different autocrlf on both machines?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
