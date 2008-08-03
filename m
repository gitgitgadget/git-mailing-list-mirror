From: "Matt Pearson" <404emailnotfound@gmail.com>
Subject: Re: I've tried to read the manuals, but "git pull" just won't work
Date: Sun, 3 Aug 2008 01:21:32 -0400
Message-ID: <706b4240808022221we345b13md95e0dacf9436dba@mail.gmail.com>
References: <668c430c0808022158s56e22c56t3bbd61eef59d7b32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bruce Korb" <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 07:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPW3D-0004dl-1w
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 07:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYHCFVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 01:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbYHCFVe
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 01:21:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:21240 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYHCFVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 01:21:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so934442ywe.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7vikufprOvgekm0nkyliV8srJ2g1ByAN16P+8YmVb70=;
        b=IfpzXTM+bmpN/sHPXaCka6qCHO6maZjAPJ/7xEdMU0cfaJ3R7pYdKIMMi6kVcDLb7J
         g+7hzgCz2EEIFLCGPQsLopcbpn84crzdrSZ2oH9f+2g+hvSehO3y7uv9Z2TZwy8+Nuo9
         EADrLje/ju+VP0KEMWfiaj755HjcTFul/5qug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CkOwTw56CYyBn1vjTfsei9uh93uIsQjEkR5jBjcTskikuhnyvk4jzrN2dwUXEG51cB
         myUArn8UI7OTBr0xtYy/QChbhDSfNfEoEoU+Lsfw8w4P1lyQA+sv2fhvo3zidujFnOKK
         a9jYn387OXBwtp115Qi5up8nQcyr0rxw3Vkw0=
Received: by 10.150.219.18 with SMTP id r18mr4678763ybg.49.1217740892626;
        Sat, 02 Aug 2008 22:21:32 -0700 (PDT)
Received: by 10.151.99.15 with HTTP; Sat, 2 Aug 2008 22:21:32 -0700 (PDT)
In-Reply-To: <668c430c0808022158s56e22c56t3bbd61eef59d7b32@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91206>

On Sun, Aug 3, 2008 at 12:58 AM, Bruce Korb <bruce.korb@gmail.com> wrote:
> Sorry, I don't know where else to turn.
> I've modified my local copy of ChangeLog and my "git pull" says, "Oh, oh!
> You'd overwrite your changes" and refuses to pull.  I tried
> "git reset HEAD  ChangeLog", but it says all sorts of crazy things
> that make no sense and I'm still stuck.  I know I can fix this:
> pull my edits into a patch, throw away my repository, clone a fresh
> copy.  There has to be a better way.  The better  way is just too
> obtuse to figure out.....Help, please?  Thank you.

Depends on whether you want to keep the changes you made or not. If
you don't care about the changes, 'git checkout -- ChangeLog' will
remove the local changes. If you want to keep the changes, you can
stash them away with 'git stash', then do the pull, then re-add the
changes (and maybe have to resolve conflicts) with 'git stash apply'.
You could also just commit the changes. If you still can't get it to
work, you're going to have to paste actual program output (the output
from status would probably help).

Matt
