From: David Aguilar <davvid@gmail.com>
Subject: Re: Configuring the location of ~/.gitconfig
Date: Wed, 26 Sep 2012 11:34:05 -0700
Message-ID: <CAJDDKr6q1k+nM9VTukLvze2E6wRBrMOHeZRAoAbKp0MbGv4cQQ@mail.gmail.com>
References: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Anurag Priyam <anurag08priyam@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 20:34:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGwR6-0005lS-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 20:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268Ab2IZSeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 14:34:07 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63206 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975Ab2IZSeG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 14:34:06 -0400
Received: by vcbfo13 with SMTP id fo13so1052594vcb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dqEY7QpyhzsvkDEIJeeQQoSDCdAygwb7IiGXrSL4dyc=;
        b=kxtxVA0YN0pljlBD/v+OK4MrnsvOc8WmubDLZTvEzoeMpsvwb6soouOKU9jiguUUtw
         Z8GkHLjcDR/s6UIn3zEneFeyPEoAfeNYjnpvx5EomW2cysyyf2EHqrlwCW8OlwCxDrCC
         UhFnvBPxjee45w6rbNoHUco+fQP8/49WqgccVwf+e3Lw7DMK1iTHLta40gwDW+QX3VRr
         +YpnG5hW8ZYpUbH1Ze6UBMjtswzy6aVjPzeN2E4c+uHX7yxTJSZC5/OWwEMgfzxkiSqk
         elqE1QOxkjeY04k8JDkimIUVlSb4CLPW0riz/IGjGM0l+VZXs19GWtOYEBmE5Xto+MF1
         EJFQ==
Received: by 10.58.240.15 with SMTP id vw15mr789501vec.36.1348684445819; Wed,
 26 Sep 2012 11:34:05 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Wed, 26 Sep 2012 11:34:05 -0700 (PDT)
In-Reply-To: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206427>

On Wed, Sep 26, 2012 at 7:14 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> I'd like to configure the location of ~/.gitconfig through an
> environment variable.  My usecase is a simple enough: I have a
> repository with all my dotfiles, and I don't want to symlink
> ~/dotfiles/.gitconfig from $HOME after cloning it.  Does anyone else
> think the feature will be useful?
>
> A couple of similar examples:
> 1. The git templates directory is configurable via the
> GIT_TEMPLATE_DIR variable.
> 2. The location of ~/.zshrc, ~/.zlogin etc is configurable via the
> ZDOTDIR variable in ZSH.

There was some work recently to teach git about the XDG_CONFIG_HOME variable.

Would that help, or are the XDG variables too global for your usage?
-- 
David
