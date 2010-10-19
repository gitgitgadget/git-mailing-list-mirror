From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 13:34:56 -0500
Message-ID: <AANLkTi=DXH1WwGJ-h6s3dFfWZZ3tpu_jQgV1Y9O7c6Xf@mail.gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes> <20101019182845.GE25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 20:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8H1y-0001bV-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0JSSfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 14:35:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41724 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab0JSSfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 14:35:17 -0400
Received: by gwb10 with SMTP id 10so76079gwb.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=outS5sc/Q+N8qu7NpNLA4nY/8PwqvNNh53Hr7OG+2js=;
        b=Ms7d3TGgV61O0CS1tq/kGpmnHxrf8rUpa/KAZYsUzhURaN9JPIudhSDixVxE3Js8hq
         7vWuGLhqdyWsGoomNgkkIZjboUEwE6m7TatmWrqgFHzRMnwpOnKvINrupP3W4rQn7iTz
         QpHWBgdgtyiemWDG1X2z1ChfOHtB+McWhBofQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qseivNMopqJYN21/sTcH8oHSVhhA9UZllNkCDxCzsVN2An+CEBGCkTLIVMvWiAxWGM
         8G3Ikr7+gfYGBzVyhHFXKC2ZeJf85bi/lczbN3F6RQ/0SySIAH1zsELMsVfsVGF4uMiR
         5qdZDlemRQ2fP9rLAXWDgw5o6ZZ5f3ZT550bQ=
Received: by 10.151.92.9 with SMTP id u9mr9324306ybl.319.1287513316594; Tue,
 19 Oct 2010 11:35:16 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Tue, 19 Oct 2010 11:34:56 -0700 (PDT)
In-Reply-To: <20101019182845.GE25139@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159349>

Heya,

On Tue, Oct 19, 2010 at 13:28, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Wouldn't it make sense to make "git reset" basically a synonym for
> "git rm --cached" when in the 'branch yet to be born' case?

Yes, definitely!

-- 
Cheers,

Sverre Rabbelier
