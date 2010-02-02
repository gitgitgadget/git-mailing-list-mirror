From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: cat: .git/rebase-merge/head-name: No such file or directory
Date: Tue, 2 Feb 2010 20:20:30 +0100
Message-ID: <40aa078e1002021120u1a692301q1c4f6a952d4df5a3@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: 3AXtoSwkOBzAWgeYMNUfQSaaSXQYMUX.OaYYekeSUfSaaSXQSdagbe.OaY@groups.bounces.google.com Tue Feb 02 20:20:53 2010
Return-path: <3AXtoSwkOBzAWgeYMNUfQSaaSXQYMUX.OaYYekeSUfSaaSXQSdagbe.OaY@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3AXtoSwkOBzAWgeYMNUfQSaaSXQYMUX.OaYYekeSUfSaaSXQSdagbe.OaY@groups.bounces.google.com>)
	id 1NcOIu-0002hj-QS
	for gcvm-msysgit@m.gmane.org; Tue, 02 Feb 2010 20:20:52 +0100
Received: by gxk28 with SMTP id 28sf685261gxk.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 02 Feb 2010 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to:date
         :message-id:subject:from:to:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=bhLs06Ilfjk3mpMVgeU2/SPky1fIWP077Yz8j5MFmq4=;
        b=zQZYWRE7HQ+iOHCEaP47ZiAic0ITA4+/aNRW5qtmUWwQmRuh7sUm2vRxqqDzVcpyFV
         utimJWwf4gJyTj16r1rkMUuwafG3h2dCs/MdK37rKlk7RS+R/dIuKmCYh97V651YQEwE
         3nMML0zLUlE0AfFqYHY3zLMvaEbEAQLuzRsRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:date:message-id
         :subject:from:to:x-original-authentication-results:x-original-sender
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :x-thread-url:x-message-url:sender:list-subscribe:list-unsubscribe
         :content-type;
        b=N4eRJAvE/63DWiho/PioCL/wP6NQ/2WLrqwd9GmCMopoSERMNMugEyMtVNM7LgquNC
         WUbI+cCpoqQkx55LXItSaql/lavnfcHTDeimy0ltMhm7AwgLRSphAMDWmB0NHAUaHAOD
         UpxRa5NyU/ChXuF0yLxovlkkFmkCo6V2HL1sE=
Received: by 10.101.175.1 with SMTP id c1mr189629anp.18.1265138433897;
        Tue, 02 Feb 2010 11:20:33 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.58.206 with SMTP id i14ls755986fah.1.p; Tue, 02 Feb 2010 
	11:20:31 -0800 (PST)
Received: by 10.223.21.18 with SMTP id h18mr266853fab.8.1265138431471;
        Tue, 02 Feb 2010 11:20:31 -0800 (PST)
Received: by 10.223.21.18 with SMTP id h18mr266852fab.8.1265138431433;
        Tue, 02 Feb 2010 11:20:31 -0800 (PST)
Received: from mail-fx0-f217.google.com (mail-fx0-f217.google.com [209.85.220.217])
        by gmr-mx.google.com with ESMTP id 17si574753fxm.3.2010.02.02.11.20.30;
        Tue, 02 Feb 2010 11:20:30 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.217 as permitted sender) client-ip=209.85.220.217;
Received: by fxm9 with SMTP id 9so463819fxm.30
        for <msysgit@googlegroups.com>; Tue, 02 Feb 2010 11:20:30 -0800 (PST)
Received: by 10.216.87.80 with SMTP id x58mr3859708wee.92.1265138430224; Tue, 
	02 Feb 2010 11:20:30 -0800 (PST)
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.220.217 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/77c495a1483249d0
X-Message-Url: http://groups.google.com/group/msysgit/msg/2e8f535a895d6e17
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138740>

I just applied an interactive rebase to one of my repos, and got a
pretty confusing error message:

$ git rebase -i HEAD~4
<edit, rebasing ticked forward to the end>
rm: cannot unlink `/c/Users/kusma/Documents/My
Dropbox/src/gb-asm/.git/rebase-merge/done': Permission denied
rm: cannot remove directory `/c/Users/kusma/Documents/My
Dropbox/src/gb-asm/.git/rebase-merge': Directory not empty
cat: .git/rebase-merge/head-name: No such file or directory
$ git diff
cat: .git/rebase-merge/head-name: No such file or directory
$ git status
# On branch asm-test
nothing to commit (working directory clean)
cat: .git/rebase-merge/head-name: No such file or directory
$

Now, I figure that rm failed due to my virus scanner kicking in, so
that's no mystery. And there is a commit in msys AFAIK that makes
unlink retry on failures. So I expect the issue to go away in future
versions. However, I'm not entirely sure what to do to repair my repo,
though.

Any ideas?

-- 
Erik "kusma" Faye-Lund
