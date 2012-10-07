From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH v2 0/2] Re: gitk: can't reload commits with new key binding
Date: Sun, 07 Oct 2012 17:18:27 -0400
Message-ID: <5071F1A3.5070502@gmail.com>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org> <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de,
	paulus@samba.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:23:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKyJV-0000PJ-8i
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 23:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab2JGVSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 17:18:32 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50124 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2JGVSb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 17:18:31 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7776999iea.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4JQejly5u/dcfFVdyn6TEB1tSt1k+m4ADIAzXrLAbZw=;
        b=YtgsRDaz+C3YnGz4KKJDNpoxrkgwSPTZbc9SQeDmEzt2Nth+DprFlBkRuaybx9MkNS
         cLXczuWwY7ZYJasNiJxeWMH/rZPnVYMp8TSxXEmDMe0aINHj8Eai3gDXnqe05DRoJHpp
         tC0RDArTpzCwkGBnXc6T9UmW62F8vKcienFWSeO/xHKnUtzFCR5FCnM+LIiFNyTqCHD2
         7SSwJnvrJo9jNgrKEuZwwAF7/gTnDXC1xHqKjKsdpmyQ5wdJGzlFPR31sQOm6HfSupvX
         omBqBuFjMDtSlU44kXHm/BZreHhjAuZu3xRZszCCvRaVtFtR6xhRTM3UupPz8PqwGezd
         bm2g==
Received: by 10.50.183.200 with SMTP id eo8mr4287702igc.54.1349644710994;
        Sun, 07 Oct 2012 14:18:30 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id uj11sm318172igb.15.2012.10.07.14.18.28
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Oct 2012 14:18:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20121007 Thunderbird/10.0.7
In-Reply-To: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207199>

Could we look into getting this patch into git/gitk?

On 10/02/12 11:04, Andrew Wong wrote:
> Refactored the code for binding modified function keys as Junio suggested.
>
> Andrew Wong (2):
>   gitk: Refactor code for binding modified function keys
>   gitk: Use bindshiftfunctionkey to bind Shift-F5
>
>  gitk | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
