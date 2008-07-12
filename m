From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 18:07:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807111750200.2875@woody.linux-foundation.org>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807120033490.8950@racer> <alpine.LFD.1.10.0807111638130.3459@woody.linux-foundation.org> <alpine.DEB.1.00.0807120043150.8950@racer> <alpine.LFD.1.10.0807111653500.2875@woody.linux-foundation.org>
Reply-To: torvalds@linux-foundation.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Steffen Prohaska <prohaska@zib.de>, Johannes Sixt <johannes.sixt@telecom.at>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 12 03:09:15 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.240])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHTbs-0002TH-M8
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2008 03:09:13 +0200
Received: by wa-out-0708.google.com with SMTP id n36so10148680wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-spam-status
         :x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        bh=DrYdYonnevvfQQ4c4JcrczwA7WnMBieUApe4YWCbMgM=;
        b=ZGRRB4pMiKf62xDPpcKgeIACOK8pa46ntDSO3yOMoRZafRxtyKzbWtfB3Ne9jfyxZW
         2GWzUnWaCSqGbxV8dnmFwRvr0RVjz/Fm/d2r/JlI/p/x4Pls/r4LgxOvka5zf5gWyEOV
         qT2ATzzInAL4MUpJaRPk0KOq+iT5xZlrQtj0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-spam-status:x-spam-checker-version
         :x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=MHuDNh7F2VwL+0ArS+Kg4+SaFM/aY6DoJLAGVmzt0bonW/7te/vRjkeODeUY+PeW99
         QlDU6dLipAF96eSVr3YAl+zq2S/YuePtN1/Oct7aKZ7kyxnGm/zVQXrJ+m/eXxaNBJOP
         PwztROgW9JZEHYSh26r2RtO8zttMkJIlVaT8s=
Received: by 10.115.55.1 with SMTP id h1mr723506wak.3.1215824892261;
        Fri, 11 Jul 2008 18:08:12 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2690pri.0;
	Fri, 11 Jul 2008 18:08:12 -0700 (PDT)
X-Sender: torvalds@linux-foundation.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.115.54.3 with SMTP id g3mr6797649wak.3.1215824889475; Fri, 11 Jul 2008 18:08:09 -0700 (PDT)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org [140.211.169.13]) by mx.google.com with ESMTP id m36si484082wag.3.2008.07.11.18.08.09; Fri, 11 Jul 2008 18:08:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) client-ip=140.211.169.13;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds@linux-foundation.org designates 140.211.169.13 as permitted sender) smtp.mail=torvalds@linux-foundation.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55]) by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6C17Z4m022125 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 11 Jul 2008 18:07:36 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6C17Ysx013736; Fri, 11 Jul 2008 18:07:34 -0700
In-Reply-To: <alpine.LFD.1.10.0807111653500.2875@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.387 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88212>




On Fri, 11 Jul 2008, Linus Torvalds wrote:
> 
> If it's something that should be merged, and if it concerns code that I'm 
> interested in, I want to know about it. It's that simple.

Btw, an example of where I think we need to look at both windows and unix 
behavior and not try to make them two different camps is in that
"start_command()" thing.

It was changed to have a totally separate __MINGW32__ part, but the thing 
is, the unix side could really be improved - and actually made more like 
the MINGW32 code at the same time!

For example, on many systems it is rather noticeably faster to use 
"vfork+execve" than it is to do "fork+execve", because you avoid a whole 
"duplicate and tear down page tables" sequence. So the UNIX code would 
actually be better off using "vfork()" instead of "fork()" there.

But it can't right now - because if "cmd->env" changes the environment, it 
would change it both in the caller and in the result.

It turns out that Windows has the exact same issue (because it uses a 
spawn thing), and already does a "copy_env() + change-in-copy + free" 
model for that reason.

If that was shared, the UNIX side could just use vfork, I believe. In 
fact, the following trivial - but horribly ugly - patch passes all the 
tests, by doing the vfork() in all cases except when the environment 
changes. But I don't know what coverage that has, though (maybe env is 
effectively always set?).

And I suspect there are other cases where we'd actually be better off 
trying to share things than having all the differences hidden away in 
compat layers.

			Linus

---
 builtin-grep.c |    2 +-
 run-command.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..5d3053a 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -168,7 +168,7 @@ static int exec_grep(int argc, const char **argv)
 	int status;
 
 	argv[argc] = NULL;
-	pid = fork();
+	pid = vfork();
 	if (pid < 0)
 		return pid;
 	if (!pid) {
diff --git a/run-command.c b/run-command.c
index 6e29fdf..200ba7b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -68,7 +68,7 @@ int start_command(struct child_process *cmd)
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
 #ifndef __MINGW32__
-	cmd->pid = fork();
+	cmd->pid = cmd->env ? fork() : vfork();
 	if (!cmd->pid) {
 		if (cmd->no_stdin)
 			dup_devnull(0);
