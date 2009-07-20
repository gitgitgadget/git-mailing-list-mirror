From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH RFC 2/8] push: add push.default = mirror
Date: Mon, 20 Jul 2009 23:36:02 +0200
Message-ID: <4A64E342.6010307@gmail.com>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org> <1248112195-3761-3-git-send-email-bonzini@gnu.org> <7vocrfulpu.fsf@alter.siamese.dyndns.org> <4A64DE38.5090805@gmail.com> <7vhbx7ujhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:36:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT0XD-0001XP-Lq
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 23:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZGTVgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 17:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZGTVgH
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 17:36:07 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33684 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZGTVgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 17:36:06 -0400
Received: by fxm18 with SMTP id 18so2251101fxm.37
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=p9iZe9JHM+8iptWEYaNKqZNQ0xwj8nMp/084p85zaps=;
        b=JavKYV8LFG22vK6RRbBEiAV6aA8lmzDYZsvLiUbx/KDnXX5fucAbVk6N+l8oManNjD
         IuJJHchunbdnm5t1nTDwJdP9ydX3yQ1LZR+SMf/LWKPbEytIwzFuU/bcxhgsniDc2OUG
         qYKENpH77ah7hoLNeWvwucIsP+9j9GD1Df3T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YQFKu0c9qioHGFCj2Kicca215TeBy8zdgRe+WEErD/ffivPl4BqzkLUHXWP2xRenJw
         FHrsRoL011werJPXFyO6HO2ythNHfSQV1H3XDEYe4bRLu/h+gvCpXNzmJNUK7WnGDmdB
         x/XcHspw10ipY2mhLKge3QBS8x5G/6DQlmbu4=
Received: by 10.204.62.133 with SMTP id x5mr4826023bkh.60.1248125764437;
        Mon, 20 Jul 2009 14:36:04 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id e17sm8613523fke.48.2009.07.20.14.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 14:36:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <7vhbx7ujhq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123638>


>> If we agree on the semantics, would you harvest it separately or
>> should I resubmit?
>
> I do not expect the rest of the series to be near 'next' before 1.6.4, and
> it is likely that I'll forget about this patch by the time 1.6.4 finally
> ships.

Okay, let's keep it out of the way for now.  It doesn't add much.

Paolo
