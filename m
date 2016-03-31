From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Date: Thu, 31 Mar 2016 09:41:37 -0700
Message-ID: <20160331164137.GA11150@gmail.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Harish K <harish2704@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:41:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alffH-00077s-OV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbcCaQlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:41:42 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34794 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbcCaQlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:41:42 -0400
Received: by mail-pf0-f175.google.com with SMTP id x3so73100029pfb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eytL76IM4Lp4OIN2IBPGqe339tvGuPuH7tjexes8snk=;
        b=pzL6VfXuqberV3eun7b94XyQB607fDOsEVE/A56BNhcYgBK8Tz36XMyAlfFElEJsaj
         rvpOe6GIbqpJB2fJJRuyUxF4sgMoXX8Bq+T6ASqCFszGApLhOAADiwUMCQ8F+Z6rL1yE
         S8eeVVKokECYjdy4fs5g35e35UAPIK5Vx+zvqPvrmkY+ahnQjqw5UqaEejh/M79mtkBW
         ALESP8uq5Jaxyu1wmBfht7lOY03wDvfqvagYUTxKgjyWHRD6KV8x0dPMGs3snOEApIWN
         XL1DMBlzQVjVJvapYYAmaZWqB0703yfR2deF97FBOteIRMByxk0KQLmlVo47JAHt0tBb
         s1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eytL76IM4Lp4OIN2IBPGqe339tvGuPuH7tjexes8snk=;
        b=I5Vnb60GyuwHrdAn687Ba2lZez0165a7M7NiXwYVhXdKm4w9p0CDo6s5TXm9abwcOk
         FGlN4hWxEVOUzQaA1VVq8olhXrAK426Y5bGytgB52Vb9mCvRmb/b4zih992k7TFNmEFG
         EjB2U1K8dAqjD/X40fO+ivSW6sXil1t8+HFzNXhRYiKqw/CZhvDwhHKjL00Cnt6ecDXe
         IWVonO6lucy43Q8G3X3jj7PkAdR7lgGwQxJbud+HGT/a5Z2j+5p4/tWrh5E5gEZ8NeEw
         JSXu3Z40GQSOhel7j4KYV6z6Jl4HBtrGaZNsXTIV7Hj9Yy5wrloJcluRC0FKNu1BgjC4
         kDbg==
X-Gm-Message-State: AD7BkJIuvw3gisiYLXXPY2dTAIrwP2I6sN3qTDYm6Qjs3XdXQflje6GE60NaXbhZ1MVwXw==
X-Received: by 10.98.33.203 with SMTP id o72mr23554596pfj.96.1459442501317;
        Thu, 31 Mar 2016 09:41:41 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id se8sm14634407pac.44.2016.03.31.09.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2016 09:41:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290415>

Hello,

On Tue, Mar 29, 2016 at 11:38:10AM +0000, Harish K wrote:
> ---
>  git-gui/lib/tools.tcl | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl
> index 6ec9411..749bc67 100644
> --- a/git-gui/lib/tools.tcl
> +++ b/git-gui/lib/tools.tcl
> @@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
>  }
>  
>  proc tools_populate_one {fullname} {
> -	global tools_menubar tools_menutbl tools_id
> +	global tools_menubar tools_menutbl tools_id repo_config
>  
>  	if {![info exists tools_id]} {
>  		set tools_id 0
> @@ -61,9 +61,19 @@ proc tools_populate_one {fullname} {
>  		}
>  	}
>  
> -	tools_create_item $parent command \
> +	if {[info exists repo_config(guitool.$fullname.accelerator)] && [info exists repo_config(guitool.$fullname.accelerator-label)]} {
> +		set accele_key $repo_config(guitool.$fullname.accelerator)
> +		set accel_label $repo_config(guitool.$fullname.accelerator-label)
> +		tools_create_item $parent command \
>  		-label [lindex $names end] \
> -		-command [list tools_exec $fullname]
> +		-command [list tools_exec $fullname] \
> +		-accelerator $accel_label
> +		bind . $accele_key [list tools_exec $fullname]
> +	} else {
> +		tools_create_item $parent command \
> +			-label [lindex $names end] \
> +			-command [list tools_exec $fullname]
> +	}
>  }
>  
>  proc tools_exec {fullname} {
> 
> --
> https://github.com/git/git/pull/220

We also support "custom guitools" in git-cola using this same
mechanism.  If this gets accepted then we'll want to make
similar change there.

There's always a small risk that user-defined tools can conflict
with builtin shortcuts, but otherwise this seems like a pretty
nice feature.  Curious, what is the behavior in the event of a
conflict?  Do the builtins win?  IIRC, Qt handles this by
disabling the shortcut and warning that it's ambiguous.

Please documentation guitool.<name>.accellerator[-label] in
Documentation/config.txt otherwise users will not know that it
exists.

It would also be good for the docs to clarify what the
accelerators look like in case we need to munge them when making
it work in cola via Qt, which has its own mechanism for
associating actions with shortcuts.  Documented examples with
one and two modifier keys would be helpful.


cheers,
-- 
David
