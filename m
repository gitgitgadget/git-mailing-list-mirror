From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: Git for Windows and line endings
Date: Fri, 19 Oct 2012 10:22:08 -0700
Message-ID: <7vlif2js1r.fsf@alter.siamese.dyndns.org>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
 <CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
 <alpine.DEB.1.00.1210190801490.2695@bonsai2>
 <CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Erik Faye-Lund
 <kusmabite@gmail.com>,  git@vger.kernel.org,  msysgit@googlegroups.com
To: Chris B <chris.blaszczynski@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBQ4YQ2CAKGQEM6PSS4A@googlegroups.com Fri Oct 19 19:22:22 2012
Return-path: <msysgit+bncBCG77UMM3EJRBQ4YQ2CAKGQEM6PSS4A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBQ4YQ2CAKGQEM6PSS4A@googlegroups.com>)
	id 1TPGH6-0001u4-4O
	for gcvm-msysgit@m.gmane.org; Fri, 19 Oct 2012 19:22:20 +0200
Received: by mail-oa0-f58.google.com with SMTP id l10sf511660oag.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 19 Oct 2012 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=uzHgJGZXhkNM9J5O0tBKeP9smBt3F8D9OEImKwftFU4=;
        b=niH9Ev/vFWluupM5MCscyR1/Pn/EkzkbIrFOK/csiSRmQiifv0erh2LDoVKl01Qjyb
         VCPpV+J+pJ6OG+T+CiO+WrB99u0jGWoXk+vKkQ5VoyWZKUIWIEBDClGculMHqRcYmU19
         eifpyMHCiTmUCszaejCorL3oIY9pKxaBqyzZz0K0ApKQvMbx60stOzm3suTBU+VDiDPa
         tCpSPsVJfWL/Qtd2emfPse86FjsNj16rx2vNXFTEmLHYNdpGXJ9mC6m9kIZ7Gv17jylC
         FWmkgUEtD1NWWlqB/QXLdxAiJTMH8/66OW8ZL+4wmsmvO9152rBAlGAnoGHlA+zuf6R 
Received: by 10.52.72.197 with SMTP id f5mr409543vdv.17.1350667332138;
        Fri, 19 Oct 2012 10:22:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.21.40 with SMTP id s8ls2332899vde.8.gmail; Fri, 19 Oct 2012
 10:22:11 -0700 (PDT)
Received: by 10.58.189.35 with SMTP id gf3mr529513vec.11.1350667331462;
        Fri, 19 Oct 2012 10:22:11 -0700 (PDT)
Received: by 10.58.189.35 with SMTP id gf3mr529512vec.11.1350667331451;
        Fri, 19 Oct 2012 10:22:11 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id dj17si584137vdb.1.2012.10.19.10.22.11;
        Fri, 19 Oct 2012 10:22:11 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F048996D1;
	Fri, 19 Oct 2012 13:22:10 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD02396D0;
	Fri, 19 Oct 2012 13:22:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 533FF96CF; Fri, 19 Oct 2012
 13:22:10 -0400 (EDT)
In-Reply-To: <CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com> (Chris
 B.'s message of "Fri, 19 Oct 2012 10:39:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83DB6D56-1A11-11E2-816B-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208054>

Chris B <chris.blaszczynski@gmail.com> writes:

> - If there was SO MUCH thought into this, then it was too much...

I do not have much to add to what area experts already said on bits
specific to Git for Windows, but on just this part:

> - Our builds were not breaking, it was production due to deployment
> model utilizing Git. What if there was a process to extract from Git
> and then distribute?

Do you mean something like "git archive"?  Or do you have something
else in mind?

> - Developers are not expecting revision control system to make changes
> to files they commit.

But isn't there a distinction between the logical content and its
physical representation?  In source code (that is what developers
use a source code management system for), especially those of
cross-platform projects, the logical lines end with LF and physical
lines end with whatever is convenient on the platform of each
participant of the project.  There needs a way to convert between
the two.

It does not sound fair to call it a crime if the port to a platform,
whose users (at least the majority of them) expect the latter to be
CRLF, chose to default to that to help the majority, as long as
there are ways for the minority power users to choose to use LF in
the physical representation on their working trees.

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
