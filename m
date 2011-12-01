From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: log: option "--follow" not the default for a single file?
Date: Thu, 1 Dec 2011 21:28:31 +0100
Message-ID: <CAN0XMOKrCovkmmdqu2GjsDof0wehfbf5a0EQuPo0q7GQaJ=GRQ@mail.gmail.com>
References: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
	<20111130063743.GB5317@sigill.intra.peff.net>
	<CAN0XMOJGm1frOi7FEke7LfHCSBt2DRn_npkdKe0m3qZ=hQPNHw@mail.gmail.com>
	<20111201185230.GB2873@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 21:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWDFF-0003KU-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 21:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab1LAU2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 15:28:32 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62044 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab1LAU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 15:28:32 -0500
Received: by ywa9 with SMTP id 9so2199925ywa.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 12:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=stTXqisugwH/VaXrxRhfFxIoIyESvGglBygQbqgj6t8=;
        b=rkKDnGDcG/XC6b9hYv6otMeqaaIKE67aZuwWAZHuv4JKl3uqcVtTuutrPRCg+SLOeR
         4P1S5JChEUaOgbjnEtG2+G1zSxKEq1wkwaJ8lQ9Tl+GmubyqYW/jPuqILuNwjg6BTA6y
         YgH44HBNoUJtlQXUa+0Vl3zwi7DI5JilOhOZ4=
Received: by 10.236.185.9 with SMTP id t9mr14737642yhm.50.1322771311484; Thu,
 01 Dec 2011 12:28:31 -0800 (PST)
Received: by 10.146.249.18 with HTTP; Thu, 1 Dec 2011 12:28:31 -0800 (PST)
In-Reply-To: <20111201185230.GB2873@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186189>

> It's possible, but it is changing the meaning of "git log foo". With
> the current code, even if "foo" is currently a file, it will match
> "foo/bar" in a prior revision. Switching this to "--follow" will not.

Why does it actually match both things? I think that's
maybe wrong.
The folder was moved or delete so it doesn't exist in my
working directory. Also I can't use "git log" with another
file/folder doesn't exists but in another revision. What actually
exists is the file and that's imho the only thing that should match.
