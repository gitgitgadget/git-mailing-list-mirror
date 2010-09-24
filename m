From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 05/16] t4002 (diff-basic): use test_might_fail for
 commands that might fail
Date: Fri, 24 Sep 2010 22:52:27 +0000
Message-ID: <AANLkTinR1G2dP+Z7n5F_cyoCLMO-0k9eO8eZ=eLJJJXb@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:52:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzH84-0001js-KM
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab0IXWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:52:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37165 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab0IXWw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:52:27 -0400
Received: by iwn5 with SMTP id 5so2740262iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Zuj5nD0beqQBAgWy56Kh7Cw/sEgcsVkpt8nbhWH2Rng=;
        b=nz0kO0AfPXBaFwOtL2r0ppxDa0smbJDBll9En2LIUy4AMrEQImrcdwktR3OqLxneAp
         ypwa04aX30+h8x7zQsHb+8LICgsq5lPtU2JG68KpMpB+7VoDwDwaEc71KCgdCQgx1dLs
         a223GIWHm460+/e0ZS3A+OadN3KVMzyY6GUqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cO1FLbWBzwYpOSy/wKkEvwkfSnhwzAO2PQMbEmAP5Yd0RkUss9ltWtqaRZP1frfqfa
         6qwInJZJ3ruyBqtQJeqZlrjaVsK5UMSAa9U6TF6iPXR82qq/49iWbupWnXEX/CGU4tLg
         /XTiDeKVXvRehk490w9kIQtE0whl9Ps4QCeBk=
Received: by 10.231.30.76 with SMTP id t12mr4411829ibc.161.1285368747196; Fri,
 24 Sep 2010 15:52:27 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:52:27 -0700 (PDT)
In-Reply-To: <1285366976-22216-6-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157095>

Looks good.
