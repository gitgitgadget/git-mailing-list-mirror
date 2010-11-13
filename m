From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] [WIP] Allow running git init on a remote repository specification.
Date: Sat, 13 Nov 2010 22:29:22 +0100
Message-ID: <AANLkTimqLeyDW9sJVR8NPOXQ1Xdz+kRmu9-8fPn1yj_j@mail.gmail.com>
References: <cover.1289561504.git.peter@softwolves.pp.se> <ba28273f7efb0fa3e403a8a9d7b923b61bb62ce3.1289561504.git.peter@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 13 22:35:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHNkX-0007Bl-IL
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 22:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab0KMV3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 16:29:45 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47450 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab0KMV3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 16:29:44 -0500
Received: by yxn35 with SMTP id 35so605131yxn.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 13:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=2wUbN1slnYDsE78zHLliPYVxB6UW9gpknlHFnLFpXf0=;
        b=JV37Rgj8g+1AFImXcZtdm4OAfNU+zBcOvg0lJvo2Ise2FlQlI0CjCGYkL1KAh8B7j0
         9XnSs4CG7jwRQsKcfd5T8HCYVxm3Pj8C9DGNtydl/GiJmHVFIlNulIgQc5xNsj8Q4FOJ
         U0sqIFhHTOZfMgCbQ3d2455hy8hX+PuHheUQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hAbYzb+fmxlYPW7erT9ib0yts8aOhCfN6J4y+diBAuXRZ8mF/op6MlMsHqHGrVRfzh
         Q0sYJXOVLW314Du8F8J6dfNI5h6CTQ0Y/MiJBlAy0aKy2dk20ovHNOP/HJKsIAhCr/9E
         V9C2CWnPhH+efGKB7oUoT256AMIraIWWJ0zpg=
Received: by 10.150.217.1 with SMTP id p1mr6579245ybg.185.1289683783560; Sat,
 13 Nov 2010 13:29:43 -0800 (PST)
Received: by 10.151.100.3 with HTTP; Sat, 13 Nov 2010 13:29:22 -0800 (PST)
In-Reply-To: <ba28273f7efb0fa3e403a8a9d7b923b61bb62ce3.1289561504.git.peter@softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161397>

Heya,

On Fri, Nov 12, 2010 at 12:30, Peter Krefting <peter@softwolves.pp.se> wrote:
> If we pass a remote repository specification to git init, we should try
> connecting to the remote and run git init there. Not all transports
> can support this, so fall back to reporting an error message for those
> that cannot.

I remember some discussion about this before, I think Scott and Jeff
(cc-ed) were involved at least, maybe they remember? I remember the
idea of a new remote service (e.g., in addition to 'git-upload-pack'
and 'git-receive-pack') to create a new repository. The reason for
making this a new service was so that (among others) the github guys
could make that do something sensible for their service.

-- 
Cheers,

Sverre Rabbelier
