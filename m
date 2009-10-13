From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/8] imap-send: build imap-send on Windows
Date: Tue, 13 Oct 2009 21:57:41 +0200
Message-ID: <200910132157.41279.j6t@kdbg.org>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com> <1255461925-2244-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:57:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnVE-0007Rj-C2
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:57:48 +0200
Received: by qyk7 with SMTP id 7so10688794qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:from:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Spbo2AMmCiqOhfON/Ctn8G+jY4dPX5+7HWQ6dLkryz8=;
        b=pSdmPslTNWSc0Nhgw0vTVai6cPSpXM9d3LFPqjj0fTb+S/ExnRK5WjYOU9+QF34c0J
         KnSF9kyzMoHs28pHKSo5zHiUlZmNAyqkzABl6oi4i8k9OqYnz7Pl0D0mBLde2nwXV9UR
         TQz30NKW6Hsp5JzJM2dQBBwS0OVqA2dLOhJOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=piW0lqJJH7EHA8ZNtcCHQ8ITlI1svF0aqiTjFCIOj++YpGefVdQOaXx4V4XS2aRuam
         EMSNppE//uOWCUT3ichYgUN2fSIU6apzo8P839VYWwFgOScJ4wolvizbIlkf5wc7T48I
         T4z3Cb8wI04HgoPnGNfBZfo+7tSSIDe7+xc80=
Received: by 10.229.78.141 with SMTP id l13mr364387qck.41.1255463860156;
        Tue, 13 Oct 2009 12:57:40 -0700 (PDT)
Received: by 10.176.181.37 with SMTP id d37gr7404yqf.0;
	Tue, 13 Oct 2009 12:57:37 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.101.1 with SMTP id y1mr391637ebb.13.1255463856070; Tue, 13 Oct 2009 12:57:36 -0700 (PDT)
Received: by 10.210.101.1 with SMTP id y1mr391636ebb.13.1255463855897; Tue, 13 Oct 2009 12:57:35 -0700 (PDT)
Received: from dx.sixt.local ([93.83.142.38]) by gmr-mx.google.com with ESMTP id 13si338692ewy.6.2009.10.13.12.57.35; Tue, 13 Oct 2009 12:57:35 -0700 (PDT)
Received-SPF: neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=93.83.142.38;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from localhost (localhost [127.0.0.1]) by dx.sixt.local (Postfix) with ESMTP id 5FDB419F586; Tue, 13 Oct 2009 21:57:41 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1255461925-2244-6-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130195>


On Dienstag, 13. Oktober 2009, Erik Faye-Lund wrote:
>  PROGRAMS += git-unpack-file$X
>  PROGRAMS += git-upload-pack$X
>  PROGRAMS += git-var$X
> +PROGRAMS += git-imap-send$X

This list is sorted. Please keep it so.

-- Hannes
