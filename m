From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re: [PATCH/RFC] test-lib: add support for colors
 without tput
Date: Fri, 14 Sep 2012 19:28:35 +0200
Message-ID: <50536943.4030300@kdbg.org>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com> <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com> <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCJYV6HBKQIMPUWNQICRUBAQRU3NY@googlegroups.com Fri Sep 14 19:28:44 2012
Return-path: <msysgit+bncBCJYV6HBKQIMPUWNQICRUBAQRU3NY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIMPUWNQICRUBAQRU3NY@googlegroups.com>)
	id 1TCZh5-0006S6-D4
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 19:28:43 +0200
Received: by eeke50 with SMTP id e50sf1527730eek.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=rnzMAbvZENOKe08QfnPvdwyymECYw73xeZ8aQ6Ib/PQ=;
        b=xa+9xsQ9NESsXRVfV1HvEe6XW2n2AUVFbySLKyuADipZOs8VmEjXazxpZoLr7BMfWf
         rlXgetJaiCkZG2N8SpK7S+NNjq+K/TV3BW6tKmUDY7h7XFZx+WWLFQRWF3vp1foE5vSj
         LgSJ685LmvmSZf0eyiBNmtfQ5usbnvQfeLO8ivaDqAp/5Haa75pT/59QjoIiUeDyaky9
         mM71810+Mdm7ks0y97vy8ebK/mcn5wqkZ7yyQ3sWgGsOfqOjiH+voYMpmSKn/smgD2i+
         KvCFU8KiQwKXwqah27Icaq9hx/DzVK3GBg0P+cGUDBAtwtYhEZhTTP4xMpSdlGrmeiBF
         CYvg== 
Received: by 10.180.106.99 with SMTP id gt3mr4157504wib.3.1347643719604;
        Fri, 14 Sep 2012 10:28:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.90.134 with SMTP id bw6ls137518wib.1.canary; Fri, 14 Sep
 2012 10:28:38 -0700 (PDT)
Received: by 10.180.95.2 with SMTP id dg2mr820369wib.2.1347643718528;
        Fri, 14 Sep 2012 10:28:38 -0700 (PDT)
Received: by 10.180.95.2 with SMTP id dg2mr820368wib.2.1347643718515;
        Fri, 14 Sep 2012 10:28:38 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp4.bon.at. [195.3.86.186])
        by gmr-mx.google.com with ESMTP id cd1si500727wib.1.2012.09.14.10.28.38;
        Fri, 14 Sep 2012 10:28:38 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DD81D130047;
	Fri, 14 Sep 2012 19:28:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4A34A19F377;
	Fri, 14 Sep 2012 19:28:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 195.3.86.186 is neither permitted nor denied by best guess record for domain
 of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205512>

Am 14.09.2012 18:58, schrieb Erik Faye-Lund:
>  	tput () {
>  		case "$1" in
>  		bold)
> -			echo -ne "\033[1m" ;;
> +			printf "\033[1m" ;;
>  		setaf)
> -			echo -ne "\033[0;3$2m" ;;
> +			printf "\033[0;3$2m" ;;

This should be
			printf '\033[0;3%sm' "$2" ;;

>  		sgr0)
> -			echo -ne "\033(\033[m" ;;
> +			printf "\033(\033[m" ;;
>  		esac
>  	}
>  fi

Did you test this only in rxvt or in CMD as well? (I hadn't time to
test, yet, so I'm asking :-)

-- Hannes

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
