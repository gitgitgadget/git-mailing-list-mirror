From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: git gui diff widget (was Re: [msysGit] Re: [cheetah]
 Questions about NOTES)
Date: Wed, 30 Jan 2008 08:00:56 +0100
Message-ID: <75E9DFB9-BE1B-4B60-921D-EE0898DFA9F3@zib.de>
References: <ecf0120c-2bde-407d-8a4e-2f50ea7d4b54@f47g2000hsd.googlegroups.com> <alpine.LSU.1.00.0801281126350.23907@racer.site> <20080129031713.GJ24004@spearce.org> <alpine.LSU.1.00.0801291207080.23907@racer.site> <20080130040336.GN24004@spearce.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Kirill <kirillathome-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hetro <whee-Q1H67ocemw/0qnVlFUAYEw@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 30 08:00:35 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.189])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6vv-0000mB-A9
	for gcvm-msysgit@m.gmane.org; Wed, 30 Jan 2008 08:00:31 +0100
Received: by ag-out-0910.google.com with SMTP id 32so494504agc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 29 Jan 2008 23:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=JA/LO+RBdMLMZKJzzzoMeu/ZuoLFr1opEIya5clFT2w=;
        b=ue3AR1boBaN5DiQK3M82BIO3UmBupM0ivDOrAgvJklf3sQsBecsyExNf3WgVwpz5uIhLYqgnZVFMr9Qz7tb+JyWh4uv3urPyH2nvBSFvM9UTLz99c2UfAJvAfRlpqa25uJ0CaozHxua+T82DMZMNn0V2d9O+zrlezrIXglaUMYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=NHFv4feJwYX1XEySITdVZ/toafPr8n7mTgkY11nOQrDqm0kqgd0Eb00VMrjM9maikS85OGdqcpEItCRN3LNpPMEBH0rrlxP+hv2ERODtCwl/MmT81/tebRySX0qe9KapUx7wdI8tGGIS01cSWsKdwT1hTjjojlZMizBkh4UQCC4=
Received: by 10.100.163.8 with SMTP id l8mr440290ane.5.1201676400304;
        Tue, 29 Jan 2008 23:00:00 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1540hsg;
	Tue, 29 Jan 2008 23:00:00 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr11843432pyi.7.1201676399722; Tue, 29 Jan 2008 22:59:59 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id a28si2810339pye.0.2008.01.29.22.59.58; Tue, 29 Jan 2008 22:59:59 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0U6xuS8009021; Wed, 30 Jan 2008 07:59:56 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82455.pool.einsundeins.de [77.184.36.85]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0U6xt5i003093 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 30 Jan 2008 07:59:55 +0100 (MET)
In-Reply-To: <20080130040336.GN24004-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72041>


[ I put the git list on CC and chose a new topic. ]


On Jan 30, 2008, at 5:03 AM, Shawn O. Pearce wrote:

>
> Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> wrote:
>> On Mon, 28 Jan 2008, Shawn O. Pearce wrote:
>>> Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> wrote:
>>>>
>>>> Another thing (and this concerns you, Shawn): there is this lovely
>>>> program called git-gui, and it has most of what we will ever  
>>>> want to
>>>> drive from git-cheetah.  Is there any method to call git-gui  
>>>> such that
>>>> it performs a certain command, or is there a chance to get such a
>>>> method?
>>
>> I did not mean to remote control it, just to start it with a default
>> action, such as "diff file <xyz> to HEAD", or "diff directory  
>> <xyz> to
>> index".
>
> Oh, like we do for `git gui blame HEAD file` ?  :-)
>
> That isn't too difficult.  git-gui currently cannot show a diff of
> a directory, it can only diff a single file at a time, but yea,
> it wouldn't be hard to add a `git gui diff file` to have it open
> up and show the current difference of index<->file or HEAD<->index
> for that path.
>
> Doing a diff against a random other tree-ish, or between two random
> tree-ishes would be possible, but a lot more of a challenge.
>
> The diff viewer in git-gui isn't exactly a reusable widget.
> We'd need to refactor that so it could take patch output from any
> of the patch generating git commands.  Doing such is on my list
> of things I'd like to fix in git-gui, but I haven't had time to
> do it yet.

Hmm, I'm not sure if such a full diff viewer is the most
important thing to address.  Most users (especially Windows
users) already have a favorite graphical diff tool and they expect
a mechanism to plug it into a git workflow.

A difficulty they face is that in a git workflow they often need
to diff between two trees and this case is currently not handled
in a sensible way if you want to view the diffs graphically.
Well you could set GIT_EXTERNAL_DIFF to a graphical tool.  But
then git would pop-up a new instance of your graphical tool for
every single file and this is certainly not what you expect (I
tried it once and immediately stopped this experiment).

I think a tool that presents the list of files with differences
and can launch an external tool for one of these files would be
very helpful.  I started to think about a command line version,
git-difftool, implementing this idea, but do not yet have code.
A GUI version would be preferable for cheetah anyway.  Maybe the
patch viewer you sketched above could provide a way to launch an
external tool for any of the files touched by the patch?  If the
widget would be reusable maybe it could also be used in gitk?

	Steffen
