From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: merge ignores --no-commit in fast-forward case
Date: Sun, 20 Sep 2009 16:04:40 +0200
Message-ID: <4AB63678.6010500@gnu.org>
References: <20090918194717.GA18999@dr-wily.mit.edu> <7viqff97l4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg Price <price@ksplice.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 16:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpN27-0005L5-II
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 16:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbZITOEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 10:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbZITOEj
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 10:04:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:40628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbZITOEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 10:04:38 -0400
Received: by fg-out-1718.google.com with SMTP id 22so657407fge.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=68I6/FL2zBjXO65vx/i5xb2BKJ5k2N/sTBq1zkvRyf8=;
        b=tSTxkRuFLNTP6zVVWE8zwt/yeM6Krku8XCFaC1vwG9UiCHOdVR2Y/kn+JGsgncJzFD
         qDmvk56m23xStv03jorTrcNE8+GUrNoa/OndTVprpDKO+TwBmVHZ6pr8YQkr8BNo/6rG
         7VkntxRwY25/rDnD5JY3BBjNLJIJ/UCPFAWSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WPb9/x/bWK3yM9yBmCTErnjgoKA+QejrRdByEpHoNVsgjSMImWzc6DsSXR30URqXhG
         NldKgT0Mxi9WX3Uhtqx8QQbRePgr6uGR8nDhLZH/HEaFyWCAQ3Wi5nFPvj3x4RO46XbL
         49qgY4J/nzhEmgBNN81E75x1jiwqrGlquhcn8=
Received: by 10.86.18.34 with SMTP id 34mr3652447fgr.2.1253455481718;
        Sun, 20 Sep 2009 07:04:41 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 3sm5079649fge.5.2009.09.20.07.04.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 07:04:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <7viqff97l4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128846>

On 09/19/2009 01:05 AM, Junio C Hamano wrote:
> If "surprising" is the problem (and it certainly is), perhaps it would be
> better to rewrite it not to be so surprising, like:
>
>          --no-commit::
>                  Do not create a new commit.

Do not create a new _merge_ commit, and it's perfect.

Paolo
