From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: git gui diff widget (was Re: [msysGit] Re: [cheetah]
 Questions about NOTES)
Date: Wed, 30 Jan 2008 22:14:34 +0100
Message-ID: <71B7B7C0-BDB3-4E50-8EB5-E45C3F1224F9@zib.de>
References: <ecf0120c-2bde-407d-8a4e-2f50ea7d4b54@f47g2000hsd.googlegroups.com> <alpine.LSU.1.00.0801281126350.23907@racer.site> <20080129031713.GJ24004@spearce.org> <alpine.LSU.1.00.0801291207080.23907@racer.site> <20080130040336.GN24004@spearce.org> <75E9DFB9-BE1B-4B60-921D-EE0898DFA9F3@zib.de> <20080130071304.GS24004@spearce.org> <1201679921.6348.10.camel@bod-tarcila2.ad.mc.com>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Kirill <kirillathome-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hetro <whee-Q1H67ocemw/0qnVlFUAYEw@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Thomas Arcila <tarcila-s5SjKpinsOs@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 30 22:14:22 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.240])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKKG5-0007WM-M0
	for gcvm-msysgit@m.gmane.org; Wed, 30 Jan 2008 22:14:14 +0100
Received: by wr-out-0708.google.com with SMTP id 56so711218wra.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Jan 2008 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=UlAnDv+M/N+mBtDxiqcr7Ph+yNQBQHXGuS5jZy3Zq2o=;
        b=xi4WAIXL/cCk9L/t8Ux5AVsH/rJ9WQd8uv4q7xRw6iO2Dkxkqjem60BagMEx3EdzNYAt/Xc7gY08uUoLAHd56Ds0u1OKBwq21/TA6wDlZKo/nw0Rzf9ZEJMtmoqbKVtNLM6Q8Ymcp1/1ElN7wYxmm1qZcUTwobDp9AoWkPOquCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=j2zOXlfNrD0JHvCoxHmQUCRYDcNViBgdX8VY93mvmGbxrc/G9eYNnJikF/FfT7uf1deNSDTNRZATbZWlTrLJ7Ula2ik1zOH69s8NIUnZYUsRkVs0b7QlS5erHXLIXdMmEVsStW0NetiVNVgVs5TJufYWazgxMMMkFTYEDmSMBos=
Received: by 10.100.136.15 with SMTP id j15mr483880and.21.1201727620201;
        Wed, 30 Jan 2008 13:13:40 -0800 (PST)
Received: by 10.44.187.4 with SMTP id k4gr1546hsf;
	Wed, 30 Jan 2008 13:13:40 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.99.14 with SMTP id b14mr12696229pym.4.1201727619606; Wed, 30 Jan 2008 13:13:39 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si3785763pyg.1.2008.01.30.13.13.38; Wed, 30 Jan 2008 13:13:39 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0ULDZtP014393; Wed, 30 Jan 2008 22:13:35 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82455.pool.einsundeins.de [77.184.36.85]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0ULDY9R018797 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 30 Jan 2008 22:13:34 +0100 (MET)
In-Reply-To: <1201679921.6348.10.camel-+NgBfe53rIlR1FB8S1TzorOUoyqYp7Dr@public.gmane.org>
X-Mailer: Apple Mail (2.753)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72071>



On Jan 30, 2008, at 8:58 AM, Thomas Arcila wrote:

> Here is a patch to gitk that allows to run an external diff viewer.
> I think it might be a suitable solution.
> It can be configured in Edit/Preferences/External diff tool.
>
> To see the diff between two files:
> - select revisions to diff
> - right click on a file in the patched files list view
> - choose "External diff"
>
> Any feedback is welcome.

The basic functionality works for me, however ...


> Subject: [PATCH] gitk : External diff viewer.
>
> Right click on patched file list view gives "External diff" popup  
> menu entry,
> launching selected external diff tool.
>
> Signed-off-by: Thomas Arcila <tarcila-s5SjKpinsOs@public.gmane.org>
> ---
>  gitk |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
> ++++++++--
>  1 files changed, 105 insertions(+), 4 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 5560e4d..0e2c902 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk

[...]

> @@ -1747,6 +1762,78 @@ proc flist_hl {only} {
>      set gdttype [mc "touching paths:"]
>  }
>
> +proc external_diff {} {
> +  global gitktmpdir nullid nullid2
> +  global flist_menu_file
> +  global diffids
> +  global diffnum
> +  global gitdir extdifftool
> +
> +  set diffidto [lindex $diffids 0]
> +
> +  if {[llength $diffids] == 1} {
> +    # no reference commit given
> +    set diffidto [lindex $diffids 0]
> +    if {$diffidto eq $nullid || $diffidto eq $nullid2} {
> +      # diffing working copy with HEAD

That's not quite true.  nullid refers to the work tree but
nullid2 refers to the index. So
  - if $diffidto eq $nullid the work tree needs to be
    compared against the index
  - if $diffidto eq $nullid2 the index needs to be compared
    against HEAD.


> +      set diffidfrom "HEAD"
> +    } else {
> +      # use parent commit
> +      global allparents
> +      set diffidfrom $allparents($diffidto)
> +    }
> +  } else {
> +    set diffidfrom [lindex $diffids 0]
> +    set diffidto [lindex $diffids 1]
> +  }
> +
> +  if {! [info exists diffnum]} {
> +    set diffnum 0
> +  } else {
> +    set diffnum [expr $diffnum + 1]
> +  }
> +
> +
> +  set diffdir [file join $gitktmpdir "$diffnum"]
> +  set diffok "true"
> +
> +  file mkdir $diffdir
> +  if {$diffidto eq $nullid || $diffidto eq $nullid2} {
> +    set difftofile [file join $gitdir ".." $flist_menu_file]

This needs to be modified, too.


> +  } {
> +    set difftofile [file join $diffdir "\[$diffidto\] [file tail  
> $flist_menu_file]"]
> +    if {[catch {exec git show $diffidto:$flist_menu_file >  
> $difftofile} err]} {
> +      error_popup "\"$flist_menu_file\" [mc "cannot be found in  
> revision"] $diffidto. [mc "File has probably been created, \
> +                  deleted or renamed, in a different commit."]"
> +      set diffok "false"
> +    }
> +  }
> +
> +  if {$diffidfrom == $nullid || $diffidfrom == $nullid2} {
> +    set difffromfile [file join $gitdir ".." $flist_menu_file]

ditto.


> +  } else {
> +    set difffromfile [file join $diffdir "\[$diffidfrom\] [file  
> tail $flist_menu_file]"]
> +    if {[catch {exec git show $diffidfrom:$flist_menu_file >  
> $difffromfile} err]} {
> +      error_popup "\"$flist_menu_file\" [mc "cannot be found in  
> revision"] $diffidfrom. [mc "File has probably been created, \
> +                  deleted or renamed, in a different commit."]"
> +      set diffok "false"
> +    }
> +  }
> +
> +  if {$diffok} {
> +    # here we don't use shellquote because \ and everything must  
> be escaped and not enclosed between ''
> +    set quotedextdifftool \"[string map {\" \\\" \\ \\\\ \  \\\ }  
> $extdifftool]\"
> +    set cmd [concat | $quotedextdifftool [shellarglist [list  
> $difffromfile $difftofile]]]
> +    if {[catch {set fl [open $cmd]} err]} {
> +      file delete -force [ file join $gitktmpdir $diffnum ]
> +      error_popup [mc "$extdifftool command failed: $err"]
> +    } else {
> +      fconfigure $fl -blocking 0
> +      filerun $fl [list file delete -force [file join $gitktmpdir  
> $diffnum]]
> +    }
> +  }
> +}
> +
>

>  # Functions for adding and removing shell-type quoting
>
>  proc shellquote {str} {
> @@ -7802,9 +7889,13 @@ proc showtag {tag isnew} {
>
>  proc doquit {} {
>      global stopped
> +    global gitktmpdir
> +
>      set stopped 100
>      savestuff .
>      destroy .
> +
> +    catch {file delete -force $gitktmpdir}
>  }
>
>  proc mkfontdisp {font top which} {
> @@ -7933,7 +8024,7 @@ proc doprefs {} {
>      global maxwidth maxgraphpct
>      global oldprefs prefstop showneartags showlocalchanges
>      global bgcolor fgcolor ctext diffcolors selectbgcolor
> -    global tabstop limitdiffs
> +    global tabstop limitdiffs extdifftool
>
>      set top .gitkprefs
>      set prefstop $top
> @@ -7980,6 +8071,11 @@ proc doprefs {} {
>      pack $top.ldiff.b $top.ldiff.l -side left
>      grid x $top.ldiff -sticky w
>
> +    entry $top.extdifft -textvariable extdifftool
> +    button $top.extdiffb -text [mc "External diff tool" ] -font  
> optionfont -command {set extdifftool [tk_getOpenFile -title  
> "External diff tool" -multiple "false"]}

Could you wrap the line using \

	Steffen
