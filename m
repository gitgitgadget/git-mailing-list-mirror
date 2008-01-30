From: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
Subject: Re: git gui diff widget (was Re: [msysGit] Re: [cheetah]
 Questions about NOTES)
Date: Wed, 30 Jan 2008 02:13:04 -0500
Message-ID: <20080130071304.GS24004@spearce.org>
References: <ecf0120c-2bde-407d-8a4e-2f50ea7d4b54@f47g2000hsd.googlegroups.com> <alpine.LSU.1.00.0801281126350.23907@racer.site> <20080129031713.GJ24004@spearce.org> <alpine.LSU.1.00.0801291207080.23907@racer.site> <20080130040336.GN24004@spearce.org> <75E9DFB9-BE1B-4B60-921D-EE0898DFA9F3@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Kirill <kirillathome-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hetro <whee-Q1H67ocemw/0qnVlFUAYEw@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 30 08:13:48 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK78k-0003m1-Gu
	for gcvm-msysgit@m.gmane.org; Wed, 30 Jan 2008 08:13:46 +0100
Received: by wa-out-0708.google.com with SMTP id n36so3946537wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 29 Jan 2008 23:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:x-antiabuse:x-antiabuse:x-antiabuse:x-antiabuse:x-antiabuse:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=UF9SH+8ltBc4Ucbm5D7pr6f1STwSLAYJmVypUW051M8=;
        b=fNNMvGj7+tpc3TiIHh++6ouf6rh/sFPSJfdkKnPOz6b+TUULr4D9XWnBFWZcKh+LoUlw6q9VE1aE+hxRiwODeuaTGT9eba608/D9DKuf+BTxV6mi5Zs9RErdPoHk5KFs43wSmTecQkYV9rn7GbuKETyfrvH/R4LJanx91hjUO7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:x-antiabuse:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=hAmw8TSjPjkYGlVRy5Ave4bVTdIlCPh3xHl9f1HkhTxc4YxEXpf6/f1lAEmYeFgSTfId79fXQaZEyLqLvXwYvnh2fSyJsFbNHfrBjxSD398KPC0Lqd3BATpR7Vr5cn4fYGs2nQxl/Zmbs4YttjrnVfqIXPRE82Pc65Up/Q1cG0s=
Received: by 10.114.204.7 with SMTP id b7mr276868wag.16.1201677195626;
        Tue, 29 Jan 2008 23:13:15 -0800 (PST)
Received: by 10.106.159.13 with SMTP id h13gr1541pre;
	Tue, 29 Jan 2008 23:13:15 -0800 (PST)
X-Sender: spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.131.9 with SMTP id e9mr2031124wad.5.1201677195368; Tue, 29 Jan 2008 23:13:15 -0800 (PST)
Received: from corvette.plexpod.net (corvette.plexpod.net [64.38.20.226]) by mx.google.com with ESMTP id k36si10662495waf.0.2008.01.29.23.13.14; Tue, 29 Jan 2008 23:13:15 -0800 (PST)
Received-SPF: neutral (google.com: 64.38.20.226 is neither permitted nor denied by best guess record for domain of spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org) client-ip=64.38.20.226;
Authentication-Results: mx.google.com; spf=neutral (google.com: 64.38.20.226 is neither permitted nor denied by best guess record for domain of spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org) smtp.mail=spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.68) (envelope-from <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>) id 1JK788-0001oB-2b; Wed, 30 Jan 2008 02:13:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id 8F40720FBAE; Wed, 30 Jan 2008 02:13:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <75E9DFB9-BE1B-4B60-921D-EE0898DFA9F3-wjoc1KHpMeg@public.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - googlegroups.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72042>


Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> wrote:
> On Jan 30, 2008, at 5:03 AM, Shawn O. Pearce wrote:
> >
> >Doing a diff against a random other tree-ish, or between two random
> >tree-ishes would be possible, but a lot more of a challenge.
> >
> >The diff viewer in git-gui isn't exactly a reusable widget.
> >We'd need to refactor that so it could take patch output from any
> >of the patch generating git commands.  Doing such is on my list
> >of things I'd like to fix in git-gui, but I haven't had time to
> >do it yet.
> 
> Hmm, I'm not sure if such a full diff viewer is the most
> important thing to address.  Most users (especially Windows
> users) already have a favorite graphical diff tool and they expect
> a mechanism to plug it into a git workflow.

I hear this a lot from a co-worker.  He really wants a side-by-side
diff tool in git, as he doesn't like reading patches.  Me, I've
never been able to read a side-by-side diff tool, but I can grok
a unified diff quite easily.  To each his own, and git should help
users as much as it can.
 
> I think a tool that presents the list of files with differences
> and can launch an external tool for one of these files would be
> very helpful.  I started to think about a command line version,
> git-difftool, implementing this idea, but do not yet have code.
> A GUI version would be preferable for cheetah anyway.  Maybe the
> patch viewer you sketched above could provide a way to launch an
> external tool for any of the files touched by the patch?  If the
> widget would be reusable maybe it could also be used in gitk?

Yea, that makes sense.  But we may want to go the other way,
that is reuse gitk's patch viewer.  Or something.  The two tools
(git-gui and gitk) grew their diff viewers independently, though
I have to say that git-gui's was inspired by gitk's, and the work
that Paul did on gitool waaaaay back when.

Right now though I doubt there's a single line of code in common
between them.  Hmm, I think they both use the Tk "text" widget.
And a blue-ish color for hunk headers.  :)


Adding a feature to git-gui to launch an external diff of that
file against the index or HEAD shouldn't be too difficult, and I
think is what would be most natural for the current UI.  The ugly
part is pulling out the HEAD/index version into a temporary file
and passing a nice -L (or something like) option to the user's diff
viewer so they don't see the nasty temporary file name, but instead
see a string that matches what git-gui is showing them.  And that
option is going to differ for like every tool out there.  :-\

-- 
Shawn.
