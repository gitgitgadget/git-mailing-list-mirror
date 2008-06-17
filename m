From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v2] gitweb: quote commands properly when calling the shell
Date: Tue, 17 Jun 2008 23:51:53 +0200
Message-ID: <485831F9.2090408@gmail.com>
References: <7vd4mg9824.fsf@gitster.siamese.dyndns.org> <1213739195-29284-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8j6l-00081v-P3
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809AbYFQVv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758714AbYFQVv6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:51:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:33901 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758548AbYFQVv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:51:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3676801fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=TgamNATVmy423ubErOh5IGAeyhrNZEBH1uPPgJXcqIw=;
        b=LwUIOLtDAtyc0WHgW3sgyKJ/Ot4A2v3VQ5OEy0Ckp1JX6aIbchW4pfAesC8CmwDKOX
         tap86j1n9+/GyI+YrtVwDmQmwc0pUoxmIyIr3HbwsOTISWcG+eAWqhU3UW0uCAbk85bb
         k7xcYfR7ZgoHJpQ4/IqRGU6rYdoTDrLIc1sgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=NX5yivUPDQw298D4HQPKnDHAzgJUxeYzXUjwo2k3Tjf6Oj7jFDQ8srsjxRwLcDO8Ia
         jPNBD2y64TMWBcEFn7CykRTcPHTB8St/uqDUIzfFY9mRM2dJLhCYDZ5axP+oGOEIfDru
         LPSM7hzfrYlEEWF2riejnrQW6UTSl3OkpI9F4=
Received: by 10.86.80.17 with SMTP id d17mr9523750fgb.24.1213739515626;
        Tue, 17 Jun 2008 14:51:55 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id l12sm12315787fgb.6.2008.06.17.14.51.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 14:51:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <1213739195-29284-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85328>

Lea Wiemann wrote:
> Subject: Re: [PATCH v2] gitweb: quote commands properly when calling the shell

Junio, can you please drop me a line if/when you accept this, since I'll 
need to resend the HTTP status code patch; it conflicts as-is.

-- Lea
