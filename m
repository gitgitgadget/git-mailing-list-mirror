From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 15:24:12 +0200
Message-ID: <CABPQNSY22+gJKEguT1dwTrnp-f0y05TKSVi41JR5GNAap4Qu1g@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com> <alpine.DEB.1.00.1404281519060.14982@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marat Radchenko <marat@slonopotamus.org>, msysGit <msysgit@googlegroups.com>, 
	Pat Thoyts <patthoyts@gmail.com>, GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBJVN7GNAKGQELGOVSBI@googlegroups.com Mon Apr 28 15:24:56 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBJVN7GNAKGQELGOVSBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBJVN7GNAKGQELGOVSBI@googlegroups.com>)
	id 1WelYG-0003hV-2I
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 15:24:56 +0200
Received: by mail-vc0-f190.google.com with SMTP id lc6sf1528102vcb.17
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=AyMMfv4cLtWovHwGPmK4CueJDFuFGYur/HjHUv7v+XU=;
        b=eagwX2Gdd0jTLRO3yU5hobTxn48GnaYYQ4h8DiQRX1uhWJBHTUl+61Sro3qvqpqwcE
         3Hvg0AkbddjEPfy20yMY7UwVrGIxuvF19RG/Mv2+pVA9ZxZYibeYkKiqJ8O80IVqF2Wn
         io8vZg4gD64MzDEqslHIIJ1XpoFPst/wRfEdfCardP/jMRcpxZeltEZRZh8UZzG7Aw78
         7U8zWz5EnmOkfq2cHPImLBOceHbgii8x6oWaE/6qNH7CAfZwK05szb0f6aHGwkobeckI
         xJa0KR7+sCE06IAeejPKPI2/fRGBxJUjnMwiHxX6WA6l06Qm6Sslv6MvLXjdwOxhZCtU
         4Aig==
X-Received: by 10.50.80.10 with SMTP id n10mr584150igx.2.1398691495295;
        Mon, 28 Apr 2014 06:24:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.178.145 with SMTP id cy17ls1592012igc.22.canary; Mon, 28
 Apr 2014 06:24:54 -0700 (PDT)
X-Received: by 10.50.222.3 with SMTP id qi3mr11135402igc.7.1398691494354;
        Mon, 28 Apr 2014 06:24:54 -0700 (PDT)
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com [2607:f8b0:4001:c05::22b])
        by gmr-mx.google.com with ESMTPS id s1si1987156ign.1.2014.04.28.06.24.54
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 06:24:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22b as permitted sender) client-ip=2607:f8b0:4001:c05::22b;
Received: by mail-ig0-f171.google.com with SMTP id c1so4716255igq.16
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 06:24:54 -0700 (PDT)
X-Received: by 10.42.162.68 with SMTP id w4mr17147532icx.50.1398691494238;
 Mon, 28 Apr 2014 06:24:54 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 06:24:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1404281519060.14982@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22b
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247325>

On Mon, Apr 28, 2014 at 3:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Mon, 28 Apr 2014, Erik Faye-Lund wrote:
>
>> On Mon, Apr 28, 2014 at 10:48 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> > So it seems that 08900987 ("Decide whether to build http-push in the
>> > Makefile") makes a bad assumption about the availability of
>> > curl-config on new libcurl installations; it's not present on "stock"
>> > Windows builds.
>>
>> I wonder, though. That check is over 8 years old. Are that old systems
>> (that haven't been upgraded) still able to build Git? Even my old
>> RedHat 5 setup has curl 7.15.5...
>
> The easiest way in my humble opinion would be to install a script like
> this into /mingw/bin/:
>
> -- snip --
> #!/bin/sh
>
> case "$1" in
> --vernum)
>         version="$(curl -V)" || exit
>         version="$(echo "${version%% (*)*}" | tr . \ )"
>         eval printf "%02d%02d%02d" ${version#curl }
>         ;;
> --cflags)
>         ;;
> --libs)
>         echo -lcurl
>         ;;
> esac
> -- snap --
>
> That way, upstream Git does not have anything to change (and we avoid
> discussing five versions of essentially the same patch :-P).

Huh? I think I only really proposed one patch...?

-- 
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

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
