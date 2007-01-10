From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: suggestions about stgit commands renaming
Date: Wed, 10 Jan 2007 23:35:10 +0000
Message-ID: <b0943d9e0701101535q68505b7cpf63b7bbe44620f53@mail.gmail.com>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
	 <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
	 <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070110195212.GH17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 00:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4myS-0004vk-R0
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 00:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbXAJXfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 18:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbXAJXfN
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 18:35:13 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:20903 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXAJXfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 18:35:11 -0500
Received: by nz-out-0506.google.com with SMTP id s1so211014nze
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 15:35:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=upsjT7WRdixHQqBSbT7lHVidgy9DJu8AF1cEfeYPoLiZ7XNLFEe7aU2RvW2OTmPJJBFTwuMGyLINXPoT9UiMPbdrVLs1RWYpKyRKFvRBLFejN/QCkCGSqkDu1FeWIcI5lK8SkZOXQEEdGvTAbOYavEB/G8V8m4zljJryuZ+8I/4=
Received: by 10.64.125.17 with SMTP id x17mr8560385qbc.1168472110325;
        Wed, 10 Jan 2007 15:35:10 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Wed, 10 Jan 2007 15:35:10 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070110195212.GH17093@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36539>

On 10/01/07, Yann Dirson <ydirson@altern.org> wrote:
> Thinking twice, the current "shortcut prefix" mechanism would already
> allow us to use shortcuts like "stg p show" and "stg b create".

(I'm a bit busy for the next week or so and I won't be that responsive)

The initial command StGIT set was meant to be close to the Quilt's one
so that it offers an easy transition. Some commands like 'import' or
'branch' got more complex and I don't have anything against using
subcommands with them. The help tries to categorize the commands
somehow.

However, I would still like the main commands (push/pop, series,
applied/unapplied etc.) to remain as primary commands and be similar
to Quilt. It would become impractical to type 'stg patch push' for
example, even if you have abbreviations.

There are tools with a much more unintuitive command/key set and
people still use them successfully (thinking of emacs).

-- 
Catalin
