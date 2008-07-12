From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Sat, 12 Jul 2008 09:39:50 +0200
Message-ID: <bd6139dc0807120039q5e5a31a3xc9f23cb05e2435a5@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com>
	 <alpine.DEB.1.00.0807112257450.8950@racer>
	 <bd6139dc0807111550w1f4a9e5fl636df73572bd27de@mail.gmail.com>
	 <alpine.DEB.1.00.0807120028280.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 09:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHZis-0007gp-4R
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 09:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbYGLHjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 03:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbYGLHjw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 03:39:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:37396 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYGLHjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 03:39:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3983401wfd.4
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 00:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KCadEaFrv+WCXZY2RWTbUsI/evaa4UTjatrq/Gb3xYA=;
        b=c3/n+potZ3/I5wlNptJJ3sM0FI1ZEkj3eXCDzCU3UM0A70l7FB3eMrvv33IdX9bJA0
         pz5p9BlaNZJsOLFknnokqUoCIllRUchdkVhoVfmNdEVdPkrMKfDTO5J/2JJcOU0i02ZQ
         /7u9SJEkakEiN1xdLRnxx9wijAwh0bUa/6fs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Ip0HXdCbhewGw/U1xlP71FScTlUEncpd0glCmnjy1eBB5eSSTgJrfvN0FPtpppQ1Hv
         BldYkVHIC2/C03qsWYsRZYypC51ZLLeg+l3Q/vkfhEv/RCt2VeCA1LSYop917ErglSZp
         W4phAL8MrAiEk7i1S3GXOGCPTzk8HOXHaq5O4=
Received: by 10.142.140.15 with SMTP id n15mr3470318wfd.168.1215848390466;
        Sat, 12 Jul 2008 00:39:50 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sat, 12 Jul 2008 00:39:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807120028280.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88225>

On Sat, Jul 12, 2008 at 1:33 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If you were suspecting that I would write the patch once the semantics are
> finalized, you would be absolutely correct.

Awesome!

>> Mhhh, such would be beyond the scope of implementing manually indeed,
>> and should be left to the likes of a diff tool instead in order to
>> prevent reinventing the wheel :).
>
> That is why I was suggesting using the diff tool with munged input to find
> out what works best.

This makes sense, put the responsibility where it belongs, that way
someone else may use it as well.

> When that is done, I'll turn it into C.

Very much appreciated. I will start playing around with munged diffs
today and keep you posted of the result.

>> Correct, that's because that is what 'git log' tells me.
>
> I suspect that one big "git log" will not tell you enough.  You probably
> need to make your tool aware (at least a little) about merges, just as you
> probably made it aware about parent/child relationships (to track the
> changes along renames)...

Atm it is not aware of parent/child relationships in the activity
analysis. (This is not the case in the 'branch contains' metric, in
which I use 'git rev-list --parents' to extract and analyse that.) I
thought of tracking renames by honoring what "git log -C -C -M" tells
me (e.g., whenever it says {foo/bar.c => bar.c} I move all the metrics
under key "foo/bar.c" to "bar.c").

-- 
Cheers,

Sverre Rabbelier
