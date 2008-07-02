From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 01/12] Fake reencoding success under NO_ICONV
 instead of returning NULL.
Date: Wed, 2 Jul 2008 20:43:43 +0200
Message-ID: <200807022043.43260.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de>
Reply-To: johannes.sixt@telecom.at
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 20:44:47 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7Jv-0007WI-6Z
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 20:44:47 +0200
Received: by yw-out-2122.google.com with SMTP id 8so229194yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=hCUwgmS0JpCWn/xd3eBfmdy78XKchBnI4jw41lhML4U=;
        b=5lbCsrwTJIh7ztV8H2nrTx4JXJVFq8VcuqHhl5ka8E92KuMDhpE5Z+sjPO3M6S1ia6
         cQi8Th35rKX+XggFf/yh+9GZ2vT9mrzym2oHtP7HjYP1kAXYFSIOUkA6Xpj3dxmvyN6S
         Vwl38lIqliUi5WfsF+pVxbfsRDrpD17V2cDnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        b=1gaXQTENqzW0+Rf4tmpbePRflqbPnUrUS4m1xsdpjwVhsMlPHIywx+6aJGDT79rGPo
         P0CrHATguRljbJJQOV0ga6moQRmHhzajiJOnhS89D2GLLg/o+O/Iv8cAJvBi0CMP1K6S
         kGxUpKz2DM96jLdOQzSyVwCD/Yb1YSJtG74ic=
Received: by 10.143.15.11 with SMTP id s11mr305163wfi.16.1215024225208;
        Wed, 02 Jul 2008 11:43:45 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2577pri.0;
	Wed, 02 Jul 2008 11:43:45 -0700 (PDT)
X-Sender: johannes.sixt@telecom.at
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.185.8 with SMTP id i8mr4834383waf.11.1215024224990; Wed, 02 Jul 2008 11:43:44 -0700 (PDT)
Received: from smtp1.srv.eunet.at (smtp1.srv.eunet.at [193.154.160.119]) by mx.google.com with ESMTP id 39si8582065yxd.0.2008.07.02.11.43.44; Wed, 02 Jul 2008 11:43:44 -0700 (PDT)
Received-SPF: neutral (google.com: 193.154.160.119 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) client-ip=193.154.160.119;
Authentication-Results: mx.google.com; spf=neutral (google.com: 193.154.160.119 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) smtp.mail=johannes.sixt@telecom.at
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19]) by smtp1.srv.eunet.at (Postfix) with ESMTP id 8CFEB33BBA; Wed,  2 Jul 2008 20:43:43 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id 5A8B31CA45; Wed,  2 Jul 2008 20:43:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214987532-23640-1-git-send-email-prohaska@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87177>


On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> From: Johannes Sixt <johannes.sixt@telecom.at>
>
> git-am when invoked from git-rebase seems to rely on successful conversion.

> diff --git a/utf8.h b/utf8.h
> index 98cce1b..f22ef31 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -10,10 +10,6 @@ int is_encoding_utf8(const char *name);
>
>  int print_wrapped_text(const char *text, int indent, int indent2, int
> len);
>
> -#ifndef NO_ICONV
>  char *reencode_string(const char *in, const char *out_encoding, const char
> *in_encoding); -#else
> -#define reencode_string(a,b,c) NULL
> -#endif
>
>  #endif

I don't think that this is still needed. It dates back to the origins of 
mingw.git, at which time I did not have a working libiconv.

-- Hannes
