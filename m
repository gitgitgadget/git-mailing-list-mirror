From: Junio C Hamano <gitster@pobox.com>
Subject: Re: File path not escaped in warning message
Date: Sun, 05 Aug 2012 12:48:45 -0700
Message-ID: <7v1ujl3ysi.fsf@alter.siamese.dyndns.org>
References: <501D1BB5.6020200@o2.pl>
 <7v39429u58.fsf@alter.siamese.dyndns.org> <501E616E.6000907@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com,  git@vger.kernel.org
To: Janusz =?utf-8?Q?Bia=C5=82obrzewski?= <jbialobr@o2.pl>
X-From: msysgit+bncCI3_0YzZExCgnPuABRoE_fRoqw@googlegroups.com Sun Aug 05 21:48:53 2012
Return-path: <msysgit+bncCI3_0YzZExCgnPuABRoE_fRoqw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCI3_0YzZExCgnPuABRoE_fRoqw@googlegroups.com>)
	id 1Sy6oj-0003T7-TV
	for gcvm-msysgit@m.gmane.org; Sun, 05 Aug 2012 21:48:50 +0200
Received: by ghbf18 with SMTP id f18sf2886215ghb.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Aug 2012 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=+05YGVnKWfo77DrlYzIt0aEjMhT11rl7txPoRGCh2KU=;
        b=ZUi14aENe4sh06relUq+eiHXMsXAyv78K/aU1eNYfg4lAjyJ/O2D2yXOglJ44KJ2T3
         PxC3+HB3vc6sQkBm7MxmWEEwChuVHt01uoZdGgDJj6jKn1dmwIjjWkLXQF0BcwYllW/y
         8/Q/ZR9YGsNxNgSVTJtGgXnbm82EYGyMVS+YY=
Received: by 10.52.90.129 with SMTP id bw1mr5819vdb.13.1344196128573;
        Sun, 05 Aug 2012 12:48:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.119.137 with SMTP id z9ls4203622vcq.2.gmail; Sun, 05 Aug
 2012 12:48:47 -0700 (PDT)
Received: by 10.52.33.1 with SMTP id n1mr2232139vdi.4.1344196127714;
        Sun, 05 Aug 2012 12:48:47 -0700 (PDT)
Received: by 10.52.33.1 with SMTP id n1mr2232138vdi.4.1344196127706;
        Sun, 05 Aug 2012 12:48:47 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id t4si1728666vds.3.2012.08.05.12.48.47;
        Sun, 05 Aug 2012 12:48:47 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6062496DE;
	Sun,  5 Aug 2012 15:48:47 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E38796DD;
	Sun,  5 Aug 2012 15:48:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8F3E96DC; Sun,  5 Aug 2012
 15:48:46 -0400 (EDT)
In-Reply-To: <501E616E.6000907@o2.pl> ("Janusz =?utf-8?Q?Bia=C5=82obrzewsk?=
 =?utf-8?Q?i=22's?= message of "Sun, 05 Aug 2012 14:05:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91E8AE24-DF36-11E1-B6B5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202919>

Janusz Bia=B3obrzewski <jbialobr@o2.pl> writes:

> Here is output from linux:
>
> [janusz@mikrus JavaCommon]$ git config --add core.quotepath false
> [janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=B1.txt"
> warning: LF will be replaced by CRLF in 1<B1>.txt.
> The file will have its original line endings in your working directory.

I do not know offhand if the literal <B1> is the byte value you want
or not, but core.quotepath should not affect it.

The configuration is primarily about quoting paths that appear in
the header part in the diff output for machine readability.  In this
output,

> diff --git a/1<B1>.txt b/1<B1>.txt
> index 281ad6f..9444a66 100644
> --- a/1<B1>.txt
> +++ b/1<B1>.txt

the paths are not quoted because quotepath is set to false, but in
the next example, it

> ...
> [janusz@mikrus JavaCommon]$ git config --unset core.quotepath
> [janusz@mikrus JavaCommon]$ git config --add core.quotepath true
> [janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=B1.txt"
> warning: LF will be replaced by CRLF in 1<B1>.txt.
> The file will have its original line endings in your working directory.
> diff --git "a/1\261.txt" "b/1\261.txt"
> index 281ad6f..9444a66 100644
> --- "a/1\261.txt"
> +++ "b/1\261.txt"

is quoted due to the configuration setting.

Again, <B1> in the warning message is not affected, as the quotepath
configuration is not meant to affect messages that are meant for
human consumption.

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
