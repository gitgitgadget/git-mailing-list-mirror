From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Mon, 3 Mar 2008 09:47:06 +0800
Message-ID: <46dff0320803021747y6e334903pf8b5a77168bc7882@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
	 <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 02:48:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVzme-0000xY-8w
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 02:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbYCCBrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 20:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbYCCBrI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 20:47:08 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:55287 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbYCCBrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 20:47:07 -0500
Received: by hs-out-0708.google.com with SMTP id 4so1730205hsl.5
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 17:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nHgKKatk5dRs0BuIKSJ0SIsRmvnIMXZyZDNWpxFHUXU=;
        b=oA4158ygwLs4Z4pPsa/MGxKELBBCyEZuOxcbeVwGDUqWRYYeERbXA19GeaLO//8V4RBHSG8SbpP1T3t0t+8nXUkSJyMmIZFWqARHO9OSQ8ceiGR4vwm6uUFsU9PlpBeDgH3ZxvSS62BCfE+fmZmwNvP+gJ8rRWIROIMFnqUc9lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=In7R7Oi7dAeYnADWQfNvGrZUUMsQnLNJ7Y87SvYdPkaRhSgSHA20ckFpRyobUoEGnC9gomMdrdV/Dx6XcH5LwYAM/r/JEs3djFCfMf/flf4kjMncJ9McJeQ6N6hTngtO77kzmX5Q9CXPeXW44rVDx1lC7PyGMMm5+StmDcv6vxo=
Received: by 10.100.174.2 with SMTP id w2mr27843267ane.71.1204508826235;
        Sun, 02 Mar 2008 17:47:06 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sun, 2 Mar 2008 17:47:06 -0800 (PST)
In-Reply-To: <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75864>

On Mon, Mar 3, 2008 at 2:18 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Sun, Mar 2, 2008 at 6:11 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >  4. Do we really need 'init' subcommand?
>
>  Yes: .git/config tells git which submodule(s) the user is interested
>  in and where to fetch updates from for these submodules, while
>  .gitmodules is used to map a submodule _name_ to a submodule _path_
>  and also to provide a url where submodule updates _can_ be fetched.
>
>  So the actual use of submodules is strictly a local configuration
>  issue and as such it needs to be kept in .git/config. And to help the
>  user populate .git/config with submodule information we have 'git
>  submodule init'.
Is it always a local configuration issue? In a project with hundreds
of submodule, will anybody modify the submodule url?
I think .gitmodules can be the default repository configuration, and
when we have local configuration issue, we can override the
configuration in .git/config with the help of git init. But why always
use git init even when we don't have the local configuration
requirement?
>
>  --
>  larsh
>



-- 
Ping Yin
