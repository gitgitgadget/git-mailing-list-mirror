From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] git-gui: fix usage of themed widgets variable
Date: Sat, 20 Feb 2010 19:57:57 +0100
Message-ID: <20100220185757.GH15561@book.hvoigt.net>
References: <20100220180114.GB15561@book.hvoigt.net> <a5b261831002201047r153a067btb7d2a9cf96617df4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: 3uDCASwYKB7Qbpicanbpican.hYngmsmacnaiiafYaliojm.Wig@groups.bounces.google.com Sat Feb 20 20:08:05 2010
Return-path: <3uDCASwYKB7Qbpicanbpican.hYngmsmacnaiiafYaliojm.Wig@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f154.google.com ([209.85.210.154])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3uDCASwYKB7Qbpicanbpican.hYngmsmacnaiiafYaliojm.Wig@groups.bounces.google.com>)
	id 1NiuX1-0004Z7-Oj
	for gcvm-msysgit@m.gmane.org; Sat, 20 Feb 2010 19:58:23 +0100
Received: by mail-yx0-f154.google.com with SMTP id 26sf3756725yxe.25
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Feb 2010 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=d7FEzTlN67iV1p9sHHhDFHJagPJeA8fHQx3DmC5O0cY=;
        b=YNWWRpDc13pqV/h/DOulwFDXev9Ut3Nkwohw35fXk/yQZHTRGO+MEqEQVvqagA5RqN
         kVBD2BcQaK/sKdSgrdQQbY74I1uhq+tyt8F22J79lHX3IiQaTkZAJ4lT6c0idemk5p8K
         wEWfpQW5eo0P2krgsapf6MYBUrO2TjNpg+AfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        b=6Sacqd3O/ZpoQWWcM+zB8Fud5DcOc5GQFMK4z3VvTwKqdCL32zoXzPx0oguwjzjku9
         7g4fRrZpDEZQhxghLzXLhUxaEGxXha4p0xchhJDoy7ECiDINUenopr5qF+c1T+YklV1y
         qBRkZ9soLc9uvNQnPelpq7KHbMuvuL1+u4FP4=
Received: by 10.90.108.11 with SMTP id g11mr10592agc.34.1266692281627;
        Sat, 20 Feb 2010 10:58:01 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.26.205 with SMTP id f13ls1000693bkc.0.p; Sat, 20 Feb 2010 
	10:57:59 -0800 (PST)
Received: by 10.204.153.15 with SMTP id i15mr697189bkw.20.1266692279513;
        Sat, 20 Feb 2010 10:57:59 -0800 (PST)
Received: by 10.204.153.15 with SMTP id i15mr697188bkw.20.1266692279445;
        Sat, 20 Feb 2010 10:57:59 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id 17si189227bwz.11.2010.02.20.10.57.59;
        Sat, 20 Feb 2010 10:57:59 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 3093 invoked from network); 20 Feb 2010 19:57:57 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2010 19:57:57 +0100
In-Reply-To: <a5b261831002201047r153a067btb7d2a9cf96617df4@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	83.133.111.250 is neither permitted nor denied by best guess record for 
	domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
X-Original-Sender: hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/61aaff59563ed5ea
X-Message-Url: http://groups.google.com/group/msysgit/msg/242b6d99bb0ca74f
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140541>

There was one forgotten global so NS was not visible to the method
which resulted in an error.

The error was triggered by using git gui to clone a local repository.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
On Sat, Feb 20, 2010 at 06:47:12PM +0000, Pat Thoyts wrote:
> On 20 February 2010 18:01, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > There was one forgotten global so NS was not visible to the method
> > which resulted in an error.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
[...]
> 
> The commit message should mention what triggered the error I think -
> but this patch is clearly correct.
> You can have a
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> 
> if you like :)

Thanks, taken.

 git-gui/lib/status_bar.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
index 5fe3aad..95cb449 100644
--- a/git-gui/lib/status_bar.tcl
+++ b/git-gui/lib/status_bar.tcl
@@ -39,6 +39,7 @@ method _oneline_pack {} {
 }
 
 constructor two_line {path} {
+	global NS
 	set w $path
 	set w_l $w.l
 	set w_c $w.c
-- 
1.7.0.m5.rc2.13.g7abfa.dirty
