From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Check for top == head at the start of every transaction
Date: Sat, 30 Aug 2008 23:12:06 +0100
Message-ID: <b0943d9e0808301512g6d0a37f7o59e6392687cbafcf@mail.gmail.com>
References: <20080827220606.3607.17134.stgit@yoghurt>
	 <20080827220657.3607.88972.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Erik Sandberg" <mandolaerik@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZYh9-0004I9-51
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 00:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbYH3WMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 18:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbYH3WMI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 18:12:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:3050 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYH3WMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 18:12:07 -0400
Received: by wa-out-1112.google.com with SMTP id j37so856175waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zatmhhAimjjvOoTwv6C1ZeohDdvMMDG4zl5/RG2/k2Y=;
        b=XQkFpWo0dJ5x5lHR0Hw99IVTjbMeuTtUcigWjPgDsIhXGdOhNqTfhPZXQ4O0v+ohv5
         +/Rlmw4RAnzPDTALGzgjeGEueU2rBESctkGGre+AJaVCnrjzAlxyEiKt8x7UBKEM0Ydp
         nm9F1vbfNBF6AlG5LNR0SBJ2fN3a6UceY/ScM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uKLu3VDwtkAWUnFtiUQJYpLT20cCXbjANLPikFWSi7BIg3+wcCE+fHqdHVYpCMi7uh
         xA9kemnqPEbJDzF4NY3RMkraXci+aMZjeJy0sv7tcp0Y1rPFN9eYFwbkWHSki5QIC/wT
         2HTYTCHWr8DuRYEKW0dvEBwbryHBcELzs/41o=
Received: by 10.114.168.15 with SMTP id q15mr3984661wae.167.1220134326394;
        Sat, 30 Aug 2008 15:12:06 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sat, 30 Aug 2008 15:12:06 -0700 (PDT)
In-Reply-To: <20080827220657.3607.88972.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94438>

2008/8/27 Karl Hasselstr=F6m <kha@treskal.com>:
> We used to check it in the run() method, but that's sometimes too
> late: for example, it causes stg coalesce to ask for a commit message
> _before_ the check, resulting in a lost commit message if the check
> fails.
>
> As before, the check can be disabled for the few commands that need
> it.

Looks fine. Thanks.

--=20
Catalin
