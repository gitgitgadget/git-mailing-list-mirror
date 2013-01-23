From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git-svn does not like format=4
Date: Wed, 23 Jan 2013 12:00:48 +0100
Message-ID: <CABPQNSY6PuifndPf2w1N3+gKDTNNgeRovKrX4dRyL3eFVCwnFw@mail.gmail.com>
References: <CAK3CF+5uD92pdEaoq4e1fwi_YxkM3ddzAUqYKO1rW5BY9rPdCA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Hans-Juergen Euler <waas.nett@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBCEG76DQKGQEHICXNGQ@googlegroups.com Wed Jan 23 12:01:48 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBCEG76DQKGQEHICXNGQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f57.google.com ([209.85.212.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBCEG76DQKGQEHICXNGQ@googlegroups.com>)
	id 1Txy5T-00011v-PJ
	for gcvm-msysgit@m.gmane.org; Wed, 23 Jan 2013 12:01:48 +0100
Received: by mail-vb0-f57.google.com with SMTP id ez10sf3051645vbb.12
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Jan 2013 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=bospfHABYSkInM2kLIb2qyDHDzGdFsPzsEkGXxvTvIw=;
        b=pWQ13wRwgXlTSEehgaosybEDQQSki/+DLTwOTOrHy5hmt4wl5qn7gisjZkwZZXgf1z
         penvAfBa0E3m+N6tid4jE5fGIBQrcOe/fNG3OSosp0Dp0pLzjWaZ2ZGd7vEgZszBY7wF
         Tzhxd4mrfi3jLl47v0TzRKYo34UmGw6rJ4CKwcNnqxP5jW5jb9//U68XmMvpj5C+aAkW
         cEaLHKAro0DtvSWc3m/lRoXdrQpz26JGsjE0WCotuo272IkmGwV+iBk81fv1G2XWSEJJ
         16uVyH94qojrl0gh3XFhRiPGqlbu0lPb 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=bospfHABYSkInM2kLIb2qyDHDzGdFsPzsEkGXxvTvIw=;
        b=Wq3l8VxoW3CCjUCcBrwsFMvRoGMdlHcLMzeanyIMxllI4y61aIkJUYlvT+3jyTeZVg
         8QvAmPAqaKG+/yOsdAdQcWC+IjkHhPzSOZAM5uqBr3E6KwD0Y3CB2HMkR2meqTl6tGFY
         swb3ju/DIg8b8C3ALvz083Vh49ZnL0fP/0qZybWaWQF0AwQc5K0KBXhplNNTdbyoRz89
         c3qJnk8hSv7UCkN9VU0lp2le2pzugTmNGr/8j8hsQo+vZlEhnfwA7ZJWzrYykOWDeA2N
         r/mVNCg51Uy4waZ3QmsB9HZYxZfGDS2KRTVRJQq 
X-Received: by 10.50.13.130 with SMTP id h2mr203561igc.16.1358938889652;
        Wed, 23 Jan 2013 03:01:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.53.173 with SMTP id c13ls3991502igp.38.gmail; Wed, 23 Jan
 2013 03:01:28 -0800 (PST)
X-Received: by 10.43.91.5 with SMTP id bk5mr812410icc.12.1358938888734;
        Wed, 23 Jan 2013 03:01:28 -0800 (PST)
X-Received: by 10.43.91.5 with SMTP id bk5mr812409icc.12.1358938888725;
        Wed, 23 Jan 2013 03:01:28 -0800 (PST)
Received: from mail-ia0-x234.google.com (mail-ia0-x234.google.com [2607:f8b0:4001:c02::234])
        by gmr-mx.google.com with ESMTPS id c8si1852092igp.0.2013.01.23.03.01.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 03:01:28 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c02::234 as permitted sender) client-ip=2607:f8b0:4001:c02::234;
Received: by mail-ia0-f180.google.com with SMTP id f27so3873776iae.25
        for <msysgit@googlegroups.com>; Wed, 23 Jan 2013 03:01:28 -0800 (PST)
X-Received: by 10.50.197.135 with SMTP id iu7mr677343igc.85.1358938888601;
 Wed, 23 Jan 2013 03:01:28 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Wed, 23 Jan 2013 03:00:48 -0800 (PST)
In-Reply-To: <CAK3CF+5uD92pdEaoq4e1fwi_YxkM3ddzAUqYKO1rW5BY9rPdCA@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c02::234
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214310>

On Wed, Jan 23, 2013 at 11:43 AM, Hans-Juergen Euler
<waas.nett@gmail.com> wrote:
> it's part of a sequence of problems you can find on
> groups.google.com/d/topic/git-users/kfMFZ3uEFsM/discussion
>
> windows 7 64 bit
> Git version 1.8.0
> git bash and git gui installed and using
>
> using subversion
> TortoiseSVN 1.7.11
> Subversion 1.7.8
> Was typically always up-to-date (within 2 months or so) with previous versions
>
> using an external subversion provider for storing the information
> externally. guess the version there is older but do not know
>
> I have dumped the content of an external subversion repos and created
> a local repos with aforementioned version.
> when cloning the subversion repos with "git-svn clone" I received this
> error message:
>  Expected FS format '2'; found format '4' at
> /usr/lib/perl5/site_perl/Git/SVN.pm line 148

This isn't a problem with Git itself, but with Git for Windows not
having an up-to-date build of libsvn.

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
