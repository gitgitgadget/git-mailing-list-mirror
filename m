From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation: avoid dangling modifier for imap-send
Date: Mon, 4 Aug 2014 19:45:35 -0700
Message-ID: <20140805024535.GV12427@google.com>
References: <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
 <1407201189-12787-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEUky-0001Z6-88
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 04:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbaHECpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 22:45:40 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46012 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbaHECpj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 22:45:39 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so436023pdi.25
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rRpimZk/tHRKXelvEJTaMES/cW0atomquWr+Jgy6AyY=;
        b=iRzZ2CaZxtNEXmUEcLzenhEzfdqYZjeIp7P55EqIWYuTfKm5eKsNatIWVDY4wzRcoc
         Xhx9VDv6BTbtQxl3yWwg7IH2gks9eF3FON2I59xuAz3x5IfFpRGarr+VwFXqsq6Eq7TN
         UEqEFkve/JVcGIOQ9eRw9Ot9RRZdHxKaCGYESlWc/F2ltaCIkoAFQCIat8u5gqqKtQkO
         3xeKYXRBZThlLNSCb3wtT2I9mJYtivvGPkErucRZDJ72IaDIKooz+P+t8PCBaz/mwxs9
         Dap+qPJkgYQPXepIY5AYHG+5s6JWnf/efLaeyqkeiu6v1SJnE0/c9XiUJVOtU1LXqoF5
         YZwg==
X-Received: by 10.66.218.70 with SMTP id pe6mr761169pac.61.1407206739275;
        Mon, 04 Aug 2014 19:45:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:921:be1f:9e2d:3c59])
        by mx.google.com with ESMTPSA id fe8sm472850pdb.16.2014.08.04.19.45.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 19:45:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407201189-12787-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254797>

brian m. carlson wrote:

> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -43,7 +43,7 @@ imap.folder::
>  imap.tunnel::
>  	Command used to setup a tunnel to the IMAP server through which
>  	commands will be piped instead of using a direct network connection
> -	to the server. Required when imap.host is not set to use imap-send.
> +	to the server. Required when imap.host is not set.

Should the neighboring instances of '[Rr]equired to use imap-send
be changed to plain "Required", too?  (I suspect yes.)

Thanks,
Jonathan
