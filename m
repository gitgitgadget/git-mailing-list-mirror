From: Junio C Hamano <gitster@pobox.com>
Subject: Re: File path not escaped in warning message
Date: Sat, 04 Aug 2012 15:20:19 -0700
Message-ID: <7v39429u58.fsf@alter.siamese.dyndns.org>
References: <501D1BB5.6020200@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, Janusz =?utf-8?Q?Bia=C5=82obrzewski?=
 <jbialobr@o2.pl>
To: msysgit@googlegroups.com
X-From: msysgit+bncCI3_0YzZExCnwPaABRoE-InYAw@googlegroups.com Sun Aug 05 00:20:25 2012
Return-path: <msysgit+bncCI3_0YzZExCnwPaABRoE-InYAw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCI3_0YzZExCnwPaABRoE-InYAw@googlegroups.com>)
	id 1Sxmhs-00054k-KE
	for gcvm-msysgit@m.gmane.org; Sun, 05 Aug 2012 00:20:24 +0200
Received: by yenq6 with SMTP id q6sf2190348yen.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 04 Aug 2012 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=7tB3t/i19YXoR1PThoDPa3Mb8Fd1o1tiUzJ63E7irTE=;
        b=KKIdVaaePpIM46fG/cv5/4WcFXILKvbh6u+QkFRV00HU5hja/8au6m38sK2mPIhENa
         Mg6BnVYlqLXgPV/LJAxZ5erSDC4whT0XV4GLZzXoPVg1pfH9N87+NuOZuucLseZXGc5m
         A3BlYiQAwVOFmc1Jk1FqwheWvbuoRDgSbls+k=
Received: by 10.52.94.111 with SMTP id db15mr641832vdb.11.1344118823381;
        Sat, 04 Aug 2012 15:20:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.36.147 with SMTP id q19ls2110625vdj.4.gmail; Sat, 04 Aug
 2012 15:20:21 -0700 (PDT)
Received: by 10.58.202.2 with SMTP id ke2mr1934457vec.34.1344118821775;
        Sat, 04 Aug 2012 15:20:21 -0700 (PDT)
Received: by 10.58.202.2 with SMTP id ke2mr1934456vec.34.1344118821767;
        Sat, 04 Aug 2012 15:20:21 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id c10si1086163vdu.1.2012.08.04.15.20.21;
        Sat, 04 Aug 2012 15:20:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5487D8B31;
	Sat,  4 Aug 2012 18:20:21 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 412818B2F;
	Sat,  4 Aug 2012 18:20:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEB328B2E; Sat,  4 Aug 2012
 18:20:20 -0400 (EDT)
In-Reply-To: <501D1BB5.6020200@o2.pl> ("Janusz =?utf-8?Q?Bia=C5=82obrzewsk?=
 =?utf-8?Q?i=22's?= message of "Sat, 04 Aug 2012 14:55:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93F4E390-DE82-11E1-B0C5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202895>

Janusz Bia=C5=82obrzewski <jbialobr@o2.pl> writes:

> I have enabled core.quotepath, but file path in warning isn't escaped:
> File name is 1=C4=85.txt its content is encoded in windows-1250
> Output of git diff after reencoding to windows1250 is:
>
> warning: LF will be replaced by CRLF in 1=C3=84=E2=80=A6.txt.
> The file will have its original line endings in your working directory.
>
> But I expected it to be:
>
> warning: LF will be replaced by CRLF in 1\304\205.txt.
> The file will have its original line endings in your working directory.

Do msysgit folks want to look into this, perhaps?

Thanks.

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
