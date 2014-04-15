From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 12:32:59 +0200
Message-ID: <534D0ADB.7070702@viscovery.net>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, 
 johannes.schindelin@gmx.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIN5FNUTICRUBG5E4IQ4@googlegroups.com Tue Apr 15 12:33:04 2014
Return-path: <msysgit+bncBCJYV6HBKQIN5FNUTICRUBG5E4IQ4@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f57.google.com ([74.125.83.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIN5FNUTICRUBG5E4IQ4@googlegroups.com>)
	id 1Wa0fm-0008HJ-Rq
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 12:33:02 +0200
Received: by mail-ee0-f57.google.com with SMTP id e49sf709418eek.22
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=z7pVr2vVInhE0Yh7eoRHUfzRatQA3tj4tjDMUhuKzvA=;
        b=ATn0gguUowFGczsJ7l5NulDdxIYfMWar63wSfW6VMoJLHrSg038nwdzxTUHNbGxtlh
         5g1ialNttQuXibvYm+7GQECitmLAj9mfdl0k4/6BZ1ZU8NSrR8WJz+W9lgmXvr86swFk
         hlNYY/er/5YIp8QGm5/b7+c544ANeQOohHaYIBOop+mwl+sTmByn0kLiJo6B+/1h+zdg
         Mp38wqpPRTHPg9405WdUtgTKqB66Nwl4QXQYDm+ut25bX62dHmagcQNIc9/VIpd8TF+g
         7syUmwwbpVlUtKPDe11oGNCCqXS/gTCiWYMEirBatBudq9nU4QjRM1u/xXEvJ/Sv790e
         4bAA==
X-Received: by 10.180.98.135 with SMTP id ei7mr94529wib.15.1397557982515;
        Tue, 15 Apr 2014 03:33:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.201 with SMTP id go9ls77515wib.14.gmail; Tue, 15 Apr
 2014 03:33:01 -0700 (PDT)
X-Received: by 10.180.10.129 with SMTP id i1mr239348wib.5.1397557981653;
        Tue, 15 Apr 2014 03:33:01 -0700 (PDT)
Received: from so.liwest.at (so.liwest.at. [212.33.55.14])
        by gmr-mx.google.com with ESMTPS id u49si56780eeo.1.2014.04.15.03.33.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 03:33:01 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.14 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.14;
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Wa0fk-00086R-3P; Tue, 15 Apr 2014 12:33:00 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CC85E16613;
	Tue, 15 Apr 2014 12:32:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
X-Spam-Score: -1.0 (-)
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 212.33.55.14 is neither permitted nor denied by best guess
 record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246281>

Am 4/15/2014 10:44, schrieb Erik Faye-Lund:
> From: Erik Faye-Lund <kusmabite@googlemail.com>
> 
> On Windows, absolute paths might start with a DOS drive prefix,
> which this check fails to recognize.
> 
> Unfortunately, we cannot simply use the file_name_is_absolute
> helper in File::Spec::Functions, because Git for Windows has an
> MSYS-based Perl, where this helper doesn't grok DOS
> drive-prefixes.
> 
> So let's manually check for these in that case, and fall back to
> the File::Spec-helper on other platforms (e.g Win32 with native
> Perl)
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> 
> Here's a patch that we've been running with a variation of in
> Git for Windows for a while. That version wasn't quite palatable,
> as it recognized DOS drive-prefixes on all platforms.

Did you consider patching msysgit's lib/perl5/5.8.8/File/Spec.pm by
inserting a line "msys => 'Win32'," near the top of the file; it is the
hash table that decides which path "style" is selected depending on $^O.
Then File::Spec->file_name_is_absolute($path) could be used without a wrapper.

> 
>  git-send-email.perl | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index fdb0029..c4d85a7 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1113,6 +1113,18 @@ sub ssl_verify_params {
>  	}
>  }
>  
> +sub file_name_is_absolute {
> +	my ($path) = @_;
> +
> +	# msys does not grok DOS drive-prefixes
> +	if ($^O eq 'msys') {
> +		return ($path =~ m#^/# || $path =~ m#[a-zA-Z]\:#)
> +	}
> +
> +	require File::Spec::Functions;
> +	return File::Spec::Functions::file_name_is_absolute($path);
> +}
> +
>  # Returns 1 if the message was sent, and 0 otherwise.
>  # In actuality, the whole program dies when there
>  # is an error sending a message.
> @@ -1197,7 +1209,7 @@ X-Mailer: git-send-email $gitversion
>  
>  	if ($dry_run) {
>  		# We don't want to send the email.
> -	} elsif ($smtp_server =~ m#^/#) {
> +	} elsif (file_name_is_absolute($smtp_server)) {
>  		my $pid = open my $sm, '|-';
>  		defined $pid or die $!;
>  		if (!$pid) {
> 

There's another instance in the non-$quiet code path around line 1275 that
needs the same treatment.

-- Hannes

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
