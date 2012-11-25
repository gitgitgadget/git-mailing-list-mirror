From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Re: Python extension commands in git - request for
 policy change
Date: Sun, 25 Nov 2012 05:33:17 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125103316.GA24514@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
 <CABNJ2G+CevGU=-DjC073yGv0gupd9QK6eyjhrrQTNNmTkq_fxg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBCKNNHOUZUERBQ7IY6CQKGQEUOMIAQI@googlegroups.com Sun Nov 25 11:35:02 2012
Return-path: <msysgit+bncBCKNNHOUZUERBQ7IY6CQKGQEUOMIAQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCKNNHOUZUERBQ7IY6CQKGQEUOMIAQI@googlegroups.com>)
	id 1TcZY7-0006aj-UI
	for gcvm-msysgit@m.gmane.org; Sun, 25 Nov 2012 11:34:56 +0100
Received: by mail-qa0-f58.google.com with SMTP id a17sf2082608qae.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 25 Nov 2012 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:in-reply-to:organization
         :x-eric-conspiracy:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=L5NT9gIHaInXkj85FEjlQJiUI2/UXE2/lqqzGWMOH9c=;
        b=UDjLbfhXrME1xl2XYr5vVHgJpNgafhqUKYPpguKUpmYeuehyDLPOET4km614RIO3Fq
         +OkRaZw/BESm7uo1F1zO3KjWVdVm2VifOGSwF3Wzev7yW+aLQ4iiWqNRjyR7oKRFYPUg
         i3LIXBWMZkgj/b0Wqcq+snh9FDusz5ALtbtjqnbbnE+ykEL6wKMTrKkU1nYS0LooHdBg
         ErhRfoRQBxV2Bpv7eFFJgiF2dSzYLSnvYcOl4Lmqg5DfNalDghAY6g77KA/eC86rvAK5
         GqQJe0VDOZf/7K 
Received: by 10.49.24.13 with SMTP id q13mr1637713qef.33.1353839684300;
        Sun, 25 Nov 2012 02:34:44 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.94.82 with SMTP id da18ls1292095qeb.26.gmail; Sun, 25 Nov
 2012 02:34:43 -0800 (PST)
Received: by 10.224.173.202 with SMTP id q10mr5844950qaz.3.1353839683630;
        Sun, 25 Nov 2012 02:34:43 -0800 (PST)
Received: by 10.224.174.76 with SMTP id s12msqaz;
        Sun, 25 Nov 2012 02:34:08 -0800 (PST)
Received: by 10.59.0.194 with SMTP id ba2mr2683905ved.19.1353839648446;
        Sun, 25 Nov 2012 02:34:08 -0800 (PST)
Received: by 10.59.0.194 with SMTP id ba2mr2683904ved.19.1353839648436;
        Sun, 25 Nov 2012 02:34:08 -0800 (PST)
Received: from snark.thyrsus.com ([2002:47a2:f305:1:2877:c35b:11a0:30fa])
        by gmr-mx.google.com with ESMTP id bn19si834020vdb.0.2012.11.25.02.34.08;
        Sun, 25 Nov 2012 02:34:08 -0800 (PST)
Received-SPF: pass (google.com: domain of esr@thyrsus.com designates 2002:47a2:f305:1:2877:c35b:11a0:30fa as permitted sender) client-ip=2002:47a2:f305:1:2877:c35b:11a0:30fa;
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 1969740661; Sun, 25 Nov 2012 05:33:17 -0500 (EST)
In-Reply-To: <CABNJ2G+CevGU=-DjC073yGv0gupd9QK6eyjhrrQTNNmTkq_fxg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: esr@thyrsus.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of esr@thyrsus.com designates 2002:47a2:f305:1:2877:c35b:11a0:30fa as
 permitted sender) smtp.mail=esr@thyrsus.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210348>

Pat Thoyts <patthoyts@gmail.com>:
> Git for Windows simply ships everything we need to run git - so if a
> desirable module requires a version of python, we will add that
> version plus any required modules into the installer. We already have
> a patch to provide python in the msysgit tree - it would just require
> polishing up a little. I'm certain this is no problem for the other
> windows port (cygwin) either.

Thank you - I think this completely disposes of the "Windows is a blocker
for scripting language X" argument, with the case X = Python in point. 
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
