From: "Christian Couder" <christian.couder@gmail.com>
Subject: Re: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Tue, 28 Oct 2008 18:15:42 +0100
Message-ID: <c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com>
References: <83wsfs1y6v.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Hannu Koivisto" <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Oct 28 18:17:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KusBg-0006YO-OR
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 18:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYJ1RPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYJ1RPo
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 13:15:44 -0400
Received: from mail-gx0-f18.google.com ([209.85.217.18]:34250 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYJ1RPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 13:15:43 -0400
Received: by gxk11 with SMTP id 11so1868320gxk.13
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mg28+2RwmHTB+3hUYCla4qvbNpL9FeAS8XEp7oMAbVc=;
        b=wqG7rD40IjVpKX9ldjr9QrfgPGS9XTorKh5imVHZ2j6Hhdjac/1OKLnYINt/rofIfB
         BnFcHvWZLYQKHYYbnA2AM38/uBw6rdyJvhLQBppCWYnxdRElKqpk2R+DrGt+WOL+p4JD
         2t+cHNdz795EotuSC40kPSuBp83hlfQpNkyXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rOiqvtkuFSfcWFewx8vwS/a8N7RTu67lqmaJAO2yji17IbrLQQePuKAaQPx9cIVm5v
         pea6o8sH2TcXUTafOkW1PoSAtl4Agztbbza0JQKBKxq/3Ce7JkfQ+QDbCCnTO3Kp8+EU
         LGO/70j+LkmrmZkBq07Uf4JJAZyMm0nWIGOxY=
Received: by 10.150.197.8 with SMTP id u8mr8338374ybf.81.1225214142144;
        Tue, 28 Oct 2008 10:15:42 -0700 (PDT)
Received: by 10.150.200.11 with HTTP; Tue, 28 Oct 2008 10:15:42 -0700 (PDT)
In-Reply-To: <83wsfs1y6v.fsf@kalahari.s2.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99305>

Hi,

On Tue, Oct 28, 2008 at 5:28 PM, Hannu Koivisto <azure@iki.fi> wrote:
> Greetings,
>
> git bisect view uses gitk if DISPLAY environment variable is set
> and git log otherwise.  Since gitk doesn't require X server in
> Cygwin, that seems like a bit questionable condition in that
> environment.

Do you know any environment variable that we could use to detect we
can use gitk in Cygwin?
In this case a patch seems trivial.

> I'd prefer it to use gitk unless an option given.  I think an
> option would be preferable (to DISPLAY= git bisect view) in Unix as
> well if you have DISPLAY set but you want it to use git log.

You can use "git bisect view log" to use "git log" even if DISPLAY is set.

Regards,
Christian.
