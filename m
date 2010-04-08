From: Ori Avtalion <ori@avtalion.name>
Subject: Re: [PATCH] Docs: Describe omitted <repository> behavior in a prominent
 place
Date: Thu, 08 Apr 2010 21:07:53 +0300
Message-ID: <4BBE1B79.2090902@avtalion.name>
References: <4bbb8fa3.0f1abc0a.2383.7991@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 08 20:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzw9C-0002GB-Ps
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 20:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977Ab0DHSIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 14:08:06 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:34468 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932896Ab0DHSIC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 14:08:02 -0400
Received: by fxm23 with SMTP id 23so2283157fxm.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=wVj+5ZNKGksPO6qWDaTsbSfCOhMq5mGLDeqeNMVv4L4=;
        b=kPOgitTsAxNLkDKzgGUPu0mUXdiwX4LqSUsH2Rm+nHdc1I6vS0wtrk9qFzTDE4KdXL
         +GogyObxjWeuRJBnJcdf+N3CTLx1MuqoFkLnAXVDVOoUGXpoEX5UXTQRVXimdF+wzfxM
         hXoI8fQGqkkCbVBcwuJYFi2IE57TG2K7rCTTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YPV64wHlvG8pjYp234VVsio83D8XdGN1lqGDDO1xS3o1L9rSs7UjHNXjFLDUrIF5nw
         Dppl0HDKkyZtFznvXP1WbrV1FY5VxBuFd1i+k23Gm5RIXiKgEfgdWhpu1QerrJxF2J1c
         hHNu7ufJAZ/ZmqJxJpZ8xJUaIUwu3dr+hCl/U=
Received: by 10.223.143.12 with SMTP id s12mr529546fau.9.1270750079696;
        Thu, 08 Apr 2010 11:07:59 -0700 (PDT)
Received: from [192.168.1.55] (bzq-79-176-18-170.red.bezeqint.net [79.176.18.170])
        by mx.google.com with ESMTPS id 19sm819115fkr.9.2010.04.08.11.07.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 11:07:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100404 Thunderbird/3.0.4
In-Reply-To: <4bbb8fa3.0f1abc0a.2383.7991@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144369>

On 04/06/2010 10:32 PM, Ori Avtalion wrote:
> The documentation of which repository is pushed to when the repository
> flag is omitted was only mentioned under the --repo flag.
>
> It is now described under the <repository>  argument.

Does anyone want to comment on this patch? It seems to get lost in the 
flood.
