From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [BUG] stgit branch renaming into new dir crashes
Date: Fri, 16 Jun 2006 13:06:56 +0100
Message-ID: <b0943d9e0606160506g23179531v7921b67ac0e0aa0d@mail.gmail.com>
References: <20060613214053.GD7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 14:07:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrD6L-0001Zb-9b
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 14:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWFPMG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 08:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWFPMG5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 08:06:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:17268 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751112AbWFPMG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 08:06:57 -0400
Received: by nz-out-0102.google.com with SMTP id s18so794995nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 05:06:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ICfOgw2pn3W9qHOGH4hxYynncg08crn5iopPY/7lDVGYLZ5p6nZeodttEn0GFPgMQYgUqeStpTFjsJKMWgM77DxJEBdslOdYs5U7wxVoHczHnrr+gKE4KQJZ2XpbpSeEpTBR7mTGYT80FsFLw64covFSjxLU5Lyd4sB+9BM1xKw=
Received: by 10.36.159.12 with SMTP id h12mr3831027nze;
        Fri, 16 Jun 2006 05:06:56 -0700 (PDT)
Received: by 10.36.250.61 with HTTP; Fri, 16 Jun 2006 05:06:56 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060613214053.GD7766@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21939>

On 13/06/06, Yann Dirson <ydirson@altern.org> wrote:
> When trying to rename a branch to a name including a slash, there is
> no explicit creation of leading dirs, and stgit crashes:
>
> $ stg branch -r multitag dev/multitag
> Traceback (most recent call last):
[...]

What version of StGIT are you using? It seems to be OK with 0.10.

-- 
Catalin
