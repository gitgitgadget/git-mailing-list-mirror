From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: bash-completion now loads completions
 dynamically, so __git_ps1 is not defined when you open a shell
Date: Sat, 7 Apr 2012 16:01:55 +0300
Message-ID: <CAMP44s0rYpVhPpaf=C_aPoLUxy=EsiSxYNf04+B0_-MxzCftFw@mail.gmail.com>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
	<20120328230642.GA16925@burratino>
	<CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B61gmr9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	bash-completion-devel@lists.alioth.debian.org,
	git@vger.kernel.org, gitster@pobox.com
To: Kerrick Staley <mail@kerrickstaley.com>
X-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org Sat Apr 07 15:02:08 2012
Return-path: <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcsbc-bash-completion-devel@m.gmane.org
Received: from wagner.debian.org ([217.196.43.132])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SGVHL-0007mK-NQ
	for gcsbc-bash-completion-devel@m.gmane.org; Sat, 07 Apr 2012 15:02:07 +0200
Received: from localhost ([::1] helo=wagner.debian.org)
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SGVHL-0003hm-Hc
	for gcsbc-bash-completion-devel@m.gmane.org; Sat, 07 Apr 2012 13:02:07 +0000
Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <felipe.contreras@gmail.com>) id 1SGVHG-0002xw-EG
	for bash-completion-devel@lists.alioth.debian.org;
	Sat, 07 Apr 2012 13:02:03 +0000
Received: by eekc1 with SMTP id c1so696619eek.6
	for <bash-completion-devel@lists.alioth.debian.org>;
	Sat, 07 Apr 2012 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=p+tOD5NtXeuelioEBHW+zbkQyHx406DZWVcjKQvGXQk=;
	b=jZ+SWizPO1YUF0fH/w4GxB8yse7kw/xbV2tuQ+fWV9+R5El+B6hpdYjJbgv0O4d06Z
	JdDMCy8QYXMsEO9O+8fyFl4jbIneM7EML93oET37muVLrBmELyPiu0uudARixdZWLmo8
	krVbkV2amAD25kS2VpTrICnZc2zFTslYfVkUVquK5kwTCF5BIoytRGFRajBwm0woqCu5
	6v7d+3cYeqYgrKQf7hePEw0cqdUOKIlx2rZLFig72IyFgYIRRc+7lK7cZyqM9NBAFEkO
	dxEDrxU1sGtTaQaf4pDDVys2o/26vPjAOooTV30Lj3NV3y8UUAHz/21tJR4uzWmiiWvI
	M5yg==
Received: by 10.14.97.12 with SMTP id s12mr164698eef.8.1333803715474; Sat, 07
	Apr 2012 06:01:55 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 7 Apr 2012 06:01:55 -0700 (PDT)
In-Reply-To: <CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B61gmr9A@mail.gmail.com>
X-policyd-weight: using cached result; rate: -8.4
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on wagner.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194948>

On Thu, Mar 29, 2012 at 3:00 AM, Kerrick Staley <mail@kerrickstaley.com> wrote:
> 1) define __git_ps1 (and friends) in a different script, which will
> get installed in /etc/profile.d (this is the "proper way")

I prefer this because it's useful for zsh as well; not everybody uses
the bash completion in zsh. I believe somebody already proposed this
because of this reason. FWIW I named the script git-prompt.sh on my
side.

Cheers.

-- 
Felipe Contreras
