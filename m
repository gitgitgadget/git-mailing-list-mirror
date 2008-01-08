From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 12:41:33 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org>
Reply-To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 21:44:10 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLIo-0004Kt-8k
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 21:44:02 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1553252wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Y709d3LBeSf4t61617n7KZifVfKrzjVsdo3bZgPUblE=;
        b=2/SYYOAjSNh5neSLlrKXHsyFigEo0H8KF9bFXk7bmDhbpwmoyYLR7kV0IVKm4qN2wdvrEZI7JK5c+I+wJuNaTiB+S/1cIGgztXqX4iWdPf3JUUfWb8kwOX1WMwazTcgoHY6viFvdtMYYIeWPZA5rhpmNDjD9yN6BFddZtguM4CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=Ddv4p6rGiCL1363MnHKmzSkAZKHnejuNOGdMGmYw06t5HgYCmwTARRWrdf6wpHgH7H354gARsvIM0+joFlD/Y6Gztr0+fTzcfIfWP+1f3DA5HBz1IC5NwZ2LWSGMMJ2yVg+1fxSqlZ9oui/tb/S6Ty+XCbVqgvcjUyRujvZTBiE=
Received: by 10.141.67.21 with SMTP id u21mr786206rvk.2.1199825015102;
        Tue, 08 Jan 2008 12:43:35 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1332hsg;
	Tue, 08 Jan 2008 12:43:35 -0800 (PST)
X-Sender: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.115.91.2 with SMTP id t2mr12537455wal.24.1199825014619; Tue, 08 Jan 2008 12:43:34 -0800 (PST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14]) by mx.google.com with ESMTP id k36si5047109waf.0.2008.01.08.12.43.33; Tue, 08 Jan 2008 12:43:34 -0800 (PST)
Received-SPF: pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) client-ip=207.189.120.14;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) smtp.mail=torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08Kfjs7029030 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 8 Jan 2008 12:41:47 -0800
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08KfX2X030313; Tue, 8 Jan 2008 12:41:38 -0800
In-Reply-To: <7vir24rtfp.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.423 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_48
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69918>




On Tue, 8 Jan 2008, Junio C Hamano wrote:
>
> I think the project can mark text files as text with attributes
> and if the port to the platform initialized core.autocrlf
> appropriately for the platform everything should work as you
> described. 

Yes, I think core.autocrlf should default to "true" on Windows, since 
that is what it's about. The alternative is to have "fail"/"warn", to just 
make sure that nobody can do the wrong thing by mistake.

We could just do something like this, although that probably does mean 
that the whole test-suite needs to be double-checked (ie now we really do 
behave differently on windows outside of any config options!))

People who really dislike it can always do the

	git config --global core.autocrlf false

thing.

(And no, I don't know if "#ifdef __WINDOWS__" is the right thing to do, 
it's almost certainly not. This is just a draft.)

		Linus

---
 environment.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/environment.c b/environment.c
index 18a1c4e..5766bee 100644
--- a/environment.c
+++ b/environment.c
@@ -34,9 +34,23 @@ char *pager_program;
 int pager_use_color = 1;
 char *editor_program;
 char *excludes_file;
-int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
+/*
+ * Automatic CRLF conversion on files that look like
+ * text:
+ *   0: none (unix)
+ *   1: convert to LF on check-in and to CRLF on check-out
+ *  -1: only on check-in (check-out with just LF)
+ */
+#ifdef __WINDOWS__
+  #define DEF_AUTOCRLF 1
+#else
+  #define DEF_AUTOCRLF 0
+#endif
+
+int auto_crlf = DEF_AUTOCRLF;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static const char *work_tree;
