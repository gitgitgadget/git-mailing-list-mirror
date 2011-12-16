From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 19:49:29 +0100
Message-ID: <CAN0XMOLNF5D5m-2vBw+oA2qeD0Y9D=_zR+MLpR=f8_O7F1BDtw@mail.gmail.com>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
	<7vr504ieco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbcqc-0004Nt-Oo
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760490Ab1LPStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 13:49:31 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41455 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760402Ab1LPSt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:49:29 -0500
Received: by yenm11 with SMTP id m11so2447465yen.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vvYyUWilIQyZXrC8Abg/APhtiz8GwtGJM6WqgH0hHMc=;
        b=fR9lnVe6V3U+3NlOF9wkjj/qhLON3KQT2pM6Xpn8iT94ZR92WgF8iWUVKi+Ch6c4ce
         8Z437ZAP7NY7bwBAuFeEu3uZcdgXTh0eLKhBDAA/2guvBjhSISBD8ACQiKZnWtTtgcnD
         6FQEhKyh10eSw73bXs34Mf08pOposRnQw4dRs=
Received: by 10.236.181.36 with SMTP id k24mr14811425yhm.11.1324061369215;
 Fri, 16 Dec 2011 10:49:29 -0800 (PST)
Received: by 10.147.22.19 with HTTP; Fri, 16 Dec 2011 10:49:29 -0800 (PST)
In-Reply-To: <7vr504ieco.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187300>

> Can you bisect?

e322ee38ad8d655f5a32b3482ae9ce813b73e4bc
