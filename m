From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: Bug in EOL conversion?
Date: Wed, 23 Jan 2013 23:36:56 +0100
Message-ID: <CABPQNSaqFjvW6Kudc2uN3YWvrZuimN7MDWUeyjyG9vSZHD=C8g@mail.gmail.com>
References: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com>
 <063ABD39C46D492391698E400A7D1FA9@PhilipOakley>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Norgren <stefan.norgren@gmail.com>, git@vger.kernel.org, 
	Git MsysGit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBDR53PPJ7YHRBMWMQGEAKGQEE7TTO5A@googlegroups.com Wed Jan 23 23:38:00 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBMWMQGEAKGQEE7TTO5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f61.google.com ([209.85.219.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBMWMQGEAKGQEE7TTO5A@googlegroups.com>)
	id 1Ty8xB-0007o7-Um
	for gcvm-msysgit@m.gmane.org; Wed, 23 Jan 2013 23:37:58 +0100
Received: by mail-oa0-f61.google.com with SMTP id o6sf4992454oag.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Jan 2013 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=zngxGk9ss2IHliKRrZ6k7MWLn9ge7elRbhS0LOMH374=;
        b=mVMzqQUTVnElzk5G7ifGZvr+6zgGU9vlR6n4jVbCY8PKlKGQ6uILJ0HXD+lfaq1lME
         LYJ0j556S8piz64tk99m1CAu0IxyEiKmyf5d9Qw+SMLUq12nzF/C7Pm1H/WE4MWvWjJ5
         y8dN7X/VNjWDVnIxxKfTS1IhwZ4jMMUJ5C4J66qBoTEys2536U6UZ0ceRREg5ECPhveO
         s4PL9F9jCwhripyMlZUPuqC3QhF4jKEN65NlLe9MP+gnoMle6k5ecOugbep+Z91iTcSk
         SHsAnDU/ZS76b6SU4x1oR4ncwvrkjCYU 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=zngxGk9ss2IHliKRrZ6k7MWLn9ge7elRbhS0LOMH374=;
        b=KxZA8afdYME+9qJLg1WVPy3MvqW6UXDYp6Qh2Db1RaYhSvrhFYh3BfScTVMoeUQgHU
         LGwAjEjC535fTaH/BpGtXu89XuzOY9aEf5Q+qwKCH7aUseKr81t8gqitxvLnZdtqNXwB
         FTu2/5Fk6RPqXPJ7eZ0Kqv2Ds3Mgg22L3OawkKqJeT9F9kS636p/GIJWgOcarSjMz43k
         C6HF2ZIO8O1PHplLdg3wstjUeBuZUeY79/RD4q07rxRUMZ6KVrafgYMTGCK4YSSP10qZ
         rkquD4y0FAyXEb3pa1Sb3L3okvVNMV6gTSX5Sna 
X-Received: by 10.50.158.227 with SMTP id wx3mr24155igb.2.1358980659980;
        Wed, 23 Jan 2013 14:37:39 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.46.232 with SMTP id y8ls410623igm.41.canary; Wed, 23 Jan
 2013 14:37:38 -0800 (PST)
X-Received: by 10.50.189.169 with SMTP id gj9mr38823igc.2.1358980658095;
        Wed, 23 Jan 2013 14:37:38 -0800 (PST)
X-Received: by 10.50.189.169 with SMTP id gj9mr38822igc.2.1358980658080;
        Wed, 23 Jan 2013 14:37:38 -0800 (PST)
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com [209.85.223.170])
        by gmr-mx.google.com with ESMTPS id d5si2076218iga.1.2013.01.23.14.37.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 14:37:38 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.223.170 as permitted sender) client-ip=209.85.223.170;
Received: by mail-ie0-f170.google.com with SMTP id k10so14663387iea.15
        for <msysgit@googlegroups.com>; Wed, 23 Jan 2013 14:37:38 -0800 (PST)
X-Received: by 10.50.184.232 with SMTP id ex8mr9173igc.30.1358980658020; Wed,
 23 Jan 2013 14:37:38 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Wed, 23 Jan 2013 14:36:56 -0800 (PST)
In-Reply-To: <063ABD39C46D492391698E400A7D1FA9@PhilipOakley>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 209.85.223.170 as
 permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214374>

On Wed, Jan 23, 2013 at 10:55 PM, Philip Oakley <philipoakley@iee.org> wrote:
> The msysgit list msysgit@googlegroups.com may be a better place for this.
>
> It is likely that you have a windows specific EOL conversion set within the
> wider config's (i.e.  --system, --global). You may have core.safecrlf set
> which does a round trip test so tests the conversion both ways.

The default for core.safecrlf is "warn", so one does not need a
setting to get that warning.

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
