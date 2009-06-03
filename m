From: Alberto Leal <albertonb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git-rebase -i not escaping # at the beginning of the 
 line
Date: Wed, 3 Jun 2009 08:18:36 -0300
Message-ID: <88ca9e240906030418x628ab5cap56ddf3fcc4ede78c@mail.gmail.com>
References: <ce2236de-8670-4213-8474-52365f0397bc@z14g2000yqa.googlegroups.com> <20090603104718.GA10035@machine.or.cz>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0021cc0225c210403d046b6fd293"
Cc: donnoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jun 03 13:18:50 2009
Return-path: <grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-px0-f162.google.com ([209.85.216.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBoUc-00041j-CS
	for gcggu-git-users@m.gmane.org; Wed, 03 Jun 2009 13:18:50 +0200
Received: by pxi34 with SMTP id 34so11894117pxi.3
        for <gcggu-git-users@m.gmane.org>; Wed, 03 Jun 2009 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:content-type
         :received:in-reply-to:references:date:message-id:subject:from:to:cc
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=vs9tWfWIOTxiv3D9dtYWu39tAR0Telp03DCW9z6DHcA=;
        b=UxTAHJfruhClYcxI18WYfmWWeh5nUPqsed/wrv/rqzKpA8UiW3bGBIw/45xDw7iAwu
         VUsZCdTXcufDraRKz/H/m7FSlVSKb6Nda1R77qxO1na6q/7XD6c/xAsNQ1wSHYldTDVh
         LdvNwTuE/UJx7a1s5T1zfF8aBOHu1bLlppEnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:content-type
         :in-reply-to:references:date:message-id:subject:from:to:cc:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Nd8Bjiqs+fheqmWyBOeROXZpE/VgyeA+vH+VDzyjBm5drciuZBmFGVh9oYtOi2F14E
         cRlWQ2KUeyL0mdnOD72lGWmAXiXFiFWNj+Sq8uYZTRM+LqpZcI7LoXZYHtw0F6vyeubf
         kwiZJ3FHqPaLrdkv0BTrPaVWelUxkzyfssOys=
Received: by 10.220.94.9 with SMTP id x9mr254582vcm.20.1244027919113;
        Wed, 03 Jun 2009 04:18:39 -0700 (PDT)
Received: by 10.230.18.136 with SMTP id w8gr288vba.0;
	Wed, 03 Jun 2009 04:18:39 -0700 (PDT)
X-Sender: albertonb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.90.29.13 with SMTP id c13mr787435agc.2.1244027917900; Wed, 03 Jun 2009 04:18:37 -0700 (PDT)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28]) by gmr-mx.google.com with ESMTP id 14si999590gxk.7.2009.06.03.04.18.36; Wed, 03 Jun 2009 04:18:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of albertonb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.46.28 as permitted sender) client-ip=74.125.46.28;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of albertonb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.46.28 as permitted sender) smtp.mail=albertonb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by yw-out-2324.google.com with SMTP id 9so3966183ywe.65 for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 03 Jun 2009 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=VuvXfeXy14lbo1hy30UJpSFtCOK5YhEUEi7FfUsGcs8=; b=SlfLEC1ftK+SwxgkmBONz7qhyN4BWrOgcEdyQMly/Wzxj5QsjEG5aJoxmLb+M3TB7S k/IoE/vL0QTVn5tIbWOvZ99OnO5ImHW2ebxq5Fohv7vv8iTbnaqGp9SyouraEQyq/Cac Tho3lq/zgQXt8k+eD7lNZlEoAzxqSNVekK4C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=mSAsoqvgfCM60GA4JtsrTKQCQhz3B1Ngj7pBPSUlL6rBiunhk9khjmFQH2KU9LjBEc a/GRscPdAPMz9ePr31rGNeZd98Xf8mAWMpj6ZI+EAm/lRaIg418Wo3AAF+bfyE598fbh C5Iix4CrFVzvagr7sTIPNmlAkSPbhJt85adL0=
Received: by 10.231.38.197 with SMTP id c5mr217865ibe.3.1244027916664; Wed, 03  Jun 2009 04:18:36 -0700 (PDT)
In-Reply-To: <20090603104718.GA10035-DDGJ70k9y3lX+M3pkMnKjw@public.gmane.org>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact git-users+owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <git-users.googlegroups.com>
List-Post: <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/git-users/subscribe>,
	<mailto:git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-BeenThere-Env: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120603>


--0021cc0225c210403d046b6fd293
Content-Type: text/plain; charset=ISO-8859-1

I`ve been using this and never had any problem.


On Wed, Jun 3, 2009 at 7:47 AM, Petr Baudis <pasky-+ZI9xUNit7I@public.gmane.org> wrote:

>
> On Tue, Jun 02, 2009 at 12:28:41PM -0700, donnoman wrote:
> > Redmine automatically links those log messages to the ticket when we
> > use this method.  It works well for git commit -m "#1234 story xyz"
> >
> > However, when we use git rebase -i, all of the lines that include the
> > # character get stripped out of the commit messages.
> >
> > How can we escape these?
>
> This definitely sounds like a bug, what git version are you using?
>
> --
>                                Petr "Pasky" Baudis
> The lyf so short, the craft so long to lerne. -- Chaucer
>
> >
>

--~--~---------~--~----~------------~-------~--~----~
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en
-~----------~----~----~----~------~----~------~--~---


--0021cc0225c210403d046b6fd293
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I`ve been using this and never had any problem. <br><br><br><div class=3D"g=
mail_quote">On Wed, Jun 3, 2009 at 7:47 AM, Petr Baudis <span dir=3D"ltr">&=
lt;<a href=3D"mailto:pasky-+ZI9xUNit7I@public.gmane.org">pasky-+ZI9xUNit7I@public.gmane.org</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
On Tue, Jun 02, 2009 at 12:28:41PM -0700, donnoman wrote:<br>
&gt; Redmine automatically links those log messages to the ticket when we<b=
r>
&gt; use this method. =A0It works well for git commit -m &quot;#1234 story =
xyz&quot;<br>
&gt;<br>
&gt; However, when we use git rebase -i, all of the lines that include the<=
br>
&gt; # character get stripped out of the commit messages.<br>
&gt;<br>
&gt; How can we escape these?<br>
<br>
This definitely sounds like a bug, what git version are you using?<br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Petr &quot;=
Pasky&quot; Baudis<br>
The lyf so short, the craft so long to lerne. -- Chaucer<br>
<br>
<br>
</blockquote></div><br>
<br>
--~--~---------~--~----~------------~-------~--~----~<br>
You received this message because you are subscribed to the Google Groups &=
quot;Git for human beings&quot; group. <br> To post to this group, send ema=
il to git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org <br> To unsubscribe from this group, send =
email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org <br> For more options, visi=
t this group at http://groups.google.com/group/git-users?hl=3Den<br>
-~----------~----~----~----~------~----~------~--~---<br>
<br>

--0021cc0225c210403d046b6fd293--
