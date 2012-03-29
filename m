From: Kerrick Staley <mail@kerrickstaley.com>
Subject: Re: bash-completion now loads completions
 dynamically, so __git_ps1 is not defined when you open a shell
Date: Wed, 28 Mar 2012 19:00:35 -0500
Message-ID: <CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B61gmr9A@mail.gmail.com>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
	<20120328230642.GA16925@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: bash-completion-devel@lists.alioth.debian.org, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, gitster@pobox.com
X-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org Thu Mar 29 02:01:14 2012
Return-path: <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcsbc-bash-completion-devel@m.gmane.org
Received: from wagner.debian.org ([217.196.43.132])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SD2nh-0001Jf-UD
	for gcsbc-bash-completion-devel@m.gmane.org; Thu, 29 Mar 2012 02:01:13 +0200
Received: from localhost ([::1] helo=wagner.debian.org)
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SD2nh-000194-N1
	for gcsbc-bash-completion-devel@m.gmane.org; Thu, 29 Mar 2012 00:01:13 +0000
Received: from mail-ey0-f195.google.com ([209.85.215.195])
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <mail@kerrickstaley.com>) id 1SD2nb-0000ir-9V
	for bash-completion-devel@lists.alioth.debian.org;
	Thu, 29 Mar 2012 00:01:08 +0000
Received: by eaag12 with SMTP id g12so87794eaa.6
	for <bash-completion-devel@lists.alioth.debian.org>;
	Wed, 28 Mar 2012 17:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=kgkWyBOsgNQ3ld8SKoODZ+Jiq8nGgEnxEuicnrymdMo=;
	b=C6XB1guwYtJa1rD18IqGLxG3UPKnRN7lLRuXAIg2AuWxbo+C18KgC3sFVEF2/hU0La
	fCHKhvyyp3XHIZU5Q4Tbd6VuN3kOcdF0yMuiuw+YUDvuIYR9ZNJenSOeR9knlnkCOodO
	QkVXaMYdrd7Rkuw6yMuSDwGRIxQhZF6QGi8BeVpEiUMVhmPWlqubyJ4Ju5IKiB6lwdlb
	DFtUC+osleeSbqKaPRAQse44aAi/Pdd1iZq+Z1LsSf2HxkYLy7yosv9l61GtJPKcgZ/G
	vEvrb60gG9SqAcbR9mOV2WHdLxKIjhYxVIfxYU/DvF4seBTsAKT1qnkRSUdCywQuwXwm
	AthA==
Received: by 10.180.98.8 with SMTP id ee8mr31988wib.14.1332979258135;
	Wed, 28 Mar 2012 17:00:58 -0700 (PDT)
Received: from mail-lpp01m010-f47.google.com (mail-lpp01m010-f47.google.com
	[209.85.215.47])
	by mx.google.com with ESMTPS id gg2sm19912680wib.7.2012.03.28.17.00.56
	(version=SSLv3 cipher=OTHER); Wed, 28 Mar 2012 17:00:57 -0700 (PDT)
Received: by lagw12 with SMTP id w12so1904790lag.6
	for <bash-completion-devel@lists.alioth.debian.org>;
	Wed, 28 Mar 2012 17:00:56 -0700 (PDT)
Received: by 10.152.110.193 with SMTP id ic1mr25530068lab.4.1332979256218;
	Wed, 28 Mar 2012 17:00:56 -0700 (PDT)
Received: by 10.112.52.166 with HTTP; Wed, 28 Mar 2012 17:00:35 -0700 (PDT)
X-Originating-IP: [64.113.90.67]
In-Reply-To: <20120328230642.GA16925@burratino>
X-Gm-Message-State: ALoCoQk9C8gG6FvZk45LAEaJosQuKgzWyUu+D00fCCFVpEE0NXFsE5yzJtvehliLCXTsX0EfjnfD
X-policyd-weight: NOT_IN_SBL_XBL_SPAMHAUS=-1.5 NOT_IN_SPAMCOP=-1.5
	NOT_IN_BL_NJABL=-1.5 CL_IP_EQ_HELO_IP=-2 (check from:
	.kerrickstaley. - helo: .mail-ey0-f195.google. - helo-domain:
	.google.) FROM/MX_MATCHES_NOT_HELO(DOMAIN)=1; rate: -5.5
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on wagner.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW
	autolearn=ham version=3.3.1
X-BeenThere: bash-completion-devel@lists.alioth.debian.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: Coordination of bash-completion's development
	<bash-completion-devel.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/cgi-bin/mailman/options/bash-completion-devel>,
	<mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/bash-completion-devel>
List-Post: <mailto:bash-completion-devel@lists.alioth.debian.org>
List-Help: <mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/cgi-bin/mailman/listinfo/bash-completion-devel>,
	<mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=subscribe>
Sender: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
Errors-To: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on wagner.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194220>

On Wed, Mar 28, 2012 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, I don't quite get it. =A0"newer verions" of what?
>
> To me, completion scripts have always been to be dot-sourced early, making
> sure inclusion happen before PS1 is used. =A0Did we change anything recen=
tly
> to break it????

bash-completion 1.99 (still a "beta", but Arch Linux now ships it)
will automatically source the git-completion.bash script when you type
git <tab>. The script is no longer sourced when you first open a
shell.

There are two main ways to fix this:
1) define __git_ps1 (and friends) in a different script, which will
get installed in /etc/profile.d (this is the "proper way")
2) require that git-completion.bash always be loaded in the beginning
instead of on-the-fly (which is how it works now now)

I can submit a patch implementing option (1) if needed.

This is a very minor issue, but some recommendation from upstream
would be nice so that distros know how to handle this.

On Wed, Mar 28, 2012 at 6:06 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Yes, I think so. =A0Do the release notes for version 2.0 of the
> /etc/bash_completion wrapper script mention this change?

I'm not sure, but the feature is definitely there. The branch
implementing this feature has been merged into the project's master
(see http://anonscm.debian.org/gitweb/?p=3Dbash-completion/bash-completion.=
git;a=3Dcommit;h=3Db377dc5de84913b69efa325590e9d0bb97d02128).

-Kerrick
