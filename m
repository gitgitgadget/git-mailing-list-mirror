From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 05/12] Windows(msysgit): Per default, display
 help as HTML in default browser
Date: Wed, 2 Jul 2008 20:57:47 +0200
Message-ID: <200807022057.47588.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de>
Reply-To: johannes.sixt@telecom.at
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 20:58:55 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7XX-0003as-DI
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 20:58:51 +0200
Received: by yx-out-2122.google.com with SMTP id 22so151987yxm.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=XYgEL6cDRMdC8twduW7wE57xdZYHlAytQXWRV6bXYoU=;
        b=MHJYJFbR05xyaQzXD8gGTKACjeD2eC99T0EAdVWoHkmHeELRHON62rl/e5e6EhBs/a
         foTCnjdhVxwTVCl/BcPqbhpvSWXuYsnN3sNRE82Ipb92o/mLM9RqW3dsHLjw9XP/XsEM
         Z/9ow3vZunPDIMURzFvewI8PX2E8AMAMXGnJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        b=LIJNB/JqNqz2M/4FJRKJeXAfrC5JYbxjOe70A497FBirB1WrZcxPAfTHsBWAzsD9Al
         DRdWF7vzMmIfNHb+rllarfqk6TZ6Z+d61qRR99Mtusp7+B/kJzZ3VhXaM/njdy/mF4Ol
         ejMTZLyGxzFx8iYpIRp8MTi7L35RU0hVAXrHU=
Received: by 10.150.49.11 with SMTP id w11mr168906ybw.19.1215025070149;
        Wed, 02 Jul 2008 11:57:50 -0700 (PDT)
Received: by 10.106.79.1 with SMTP id c1gr2579prb.0;
	Wed, 02 Jul 2008 11:57:50 -0700 (PDT)
X-Sender: johannes.sixt@telecom.at
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.88.1 with SMTP id l1mr4844312wab.10.1215025069266; Wed, 02 Jul 2008 11:57:49 -0700 (PDT)
Received: from smtp5.srv.eunet.at (smtp5.srv.eunet.at [193.154.160.227]) by mx.google.com with ESMTP id 39si8599517yxd.0.2008.07.02.11.57.48; Wed, 02 Jul 2008 11:57:49 -0700 (PDT)
Received-SPF: neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) client-ip=193.154.160.227;
Authentication-Results: mx.google.com; spf=neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) smtp.mail=johannes.sixt@telecom.at
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19]) by smtp5.srv.eunet.at (Postfix) with ESMTP id D8BA313A37E; Wed,  2 Jul 2008 20:57:47 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id AA8A31CA45; Wed,  2 Jul 2008 20:57:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214987532-23640-5-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87179>


On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> The implementation directly calls the Win32 API to launch the browser.
> Note that the specific directory layout of msysgit is required.

> +#ifdef __MINGW32__
> +	const char* exec_path = git_exec_path();
> +	char *htmlpath = make_native_separator(
> +			   mkpath("%s/../doc/git/html/%s.html"
> +				  , exec_path
> +				  , git_cmd)
> +			 );
> +	if (!file_exists(htmlpath)) {
> +		htmlpath = make_native_separator(
> +			      mkpath("%s/../doc/git/html/git-%s.html"
> +				     , exec_path
> +				     , git_cmd)
> +			   );
> +		if (!file_exists(htmlpath)) {
> +			fprintf(stderr, "Can't find HTML help for '%s'.\n"
> +				, git_cmd);
> +			exit(1);
> +		}
> +	}
> +	printf("Launching default browser to display HTML help ...\n");
> +	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
> +#else

Can't we move this part into git-web--browse.sh? It should be a matter of 
calling

	start $htmlpath

(and msys-1.0.dll would convert slashes to backslashes for us).

-- Hannes
