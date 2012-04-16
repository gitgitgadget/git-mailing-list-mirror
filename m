From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 11:00:01 -0500
Message-ID: <20120416160001.GK5813@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoLl-0003wb-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937Ab2DPQAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:00:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39167 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab2DPQAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:00:13 -0400
Received: by obbta14 with SMTP id ta14so3792350obb.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Heqfid5EWOx+Wcf55hQgHmZj3QpCXAm4qo3ZuarYiCI=;
        b=C+cxCK7phCv0XlJQj+ncLpSCinFNDWyGZqyilqmvtZCv/pSdrCkvCsWYhc079w6HHE
         NftxZdU9yz934e1cRITQ7rlLBzcrsMAJaUZ4NUNzcNuG0RMAyp9jK07fe4ccLfKDJZh4
         si4NqL2gpTy2vRRpCyGD0mUi7zpMHKzNQjG1EYVMRU5JMiKu09bqqvofld4xo4aOYLJH
         trJfqJKHNC/nDq530Yx0Og2P01zuK3zRZxz6NVSPFEG+FhLVsy2jSWlVbSPfGcZP0LyR
         4FHpZsHTrlmvB7fYD5birigqmzgobRI70gMLifsBcXQDSBcHG8D7tm4TqxBhk1h/pK8P
         j30Q==
Received: by 10.182.74.4 with SMTP id p4mr16724918obv.79.1334592012578;
        Mon, 16 Apr 2012 09:00:12 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id in4sm19779397obb.2.2012.04.16.09.00.07
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 09:00:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195652>

Felipe Contreras wrote:

> Perhaps it's time to avoid the __ prefix for public interfaces;
> otherwise how would people know they are public?

I'm happy as long as all the identifiers the script exports start with
an underscore, as that is the usual convention for completion scripts.
Within that namespace, if people want to use ___git or _git__ for
private things or something, I don't mind.

If __git_ps1 is moved to a separate script library, it seems fine for
it to provide a git_ps1 identifier with no leading underscores when it
is not being implicitly included by the completion script.

Jonathan
