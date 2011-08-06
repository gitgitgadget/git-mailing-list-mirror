From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC] gettext: add gettextln, eval_gettextln to encode common idiom
Date: Sat, 6 Aug 2011 14:58:40 +1000
Message-ID: <CAH3AnroSJcJeFmFq-NKfCfGG3PQ2yOzmZ8_RedHbVEvkY_JaRA@mail.gmail.com>
References: <1312604164-19980-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: avarab@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 06:58:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpYyL-0008Gy-FI
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 06:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab1HFE6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 00:58:41 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59218 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1HFE6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 00:58:41 -0400
Received: by vws1 with SMTP id 1so2353762vws.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 21:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O85sRdfFx6qimU+2McvUITdYyGSvfnf0FzWP9hlLfmY=;
        b=ZuinOK6FPrDPyCYCdpUDoPRUHmzzv0fXKEF58iJGsWFAsdpjjEFgFJ191BbucKtWeO
         d7uPdJw+8lv3kOk2WSPYB+Yt+J66RlKG+zw9wPJaxjH8H3eNtCMrtPheq4al0R4RYK/k
         5UJLqEjOBE8XxFWC6c5e3qoNXg1nzdMjm9E/4=
Received: by 10.52.27.171 with SMTP id u11mr3236174vdg.131.1312606720214; Fri,
 05 Aug 2011 21:58:40 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Fri, 5 Aug 2011 21:58:40 -0700 (PDT)
In-Reply-To: <1312604164-19980-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178825>

On Sat, Aug 6, 2011 at 2:16 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>
> An example of its use in git-bisect.sh is given.
>

Other scripts which could benefit from such a function are:

git-am.sh
git-pull.sh
git-quiltimport.sh
git-stash.sh
git-submodule.sh

jon.
