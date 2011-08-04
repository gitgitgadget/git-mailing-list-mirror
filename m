From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Why isn't there a hook for all operations that update the working
 tree?
Date: Wed, 03 Aug 2011 20:56:37 -0500
Message-ID: <4E39FC55.206@gmail.com>
References: <CACBZZX7dJhGT0H8JZRbQ_t9mNnJocaktYAXgMSihfLBuFmL3nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 03:56:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QonB1-0001TK-Dc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 03:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab1HDB4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 21:56:43 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46133 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1HDB4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 21:56:42 -0400
Received: by yxj19 with SMTP id 19so570767yxj.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jRv+Cu1P+58X5uAZ7gi/LokW865MjcvZdp3nb/NS69U=;
        b=WI/nbejCXsA7Ips0nJx2PYwiS+Aczxt1I/DiGNTsD0TYggLgrePcz1AkrqRei35MP+
         QJpLQJwbGLVsarh09S0nbAv30JWy56cXFIerYCAQFuNo9+wv5FZ1V6zJisUY4r013izQ
         bKne1QLhsnPzQQdiGfFPMUjGWKEeCk6KflO9U=
Received: by 10.150.63.20 with SMTP id l20mr1308535yba.336.1312423001318;
        Wed, 03 Aug 2011 18:56:41 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id j65sm1388805yhm.82.2011.08.03.18.56.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 18:56:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CACBZZX7dJhGT0H8JZRbQ_t9mNnJocaktYAXgMSihfLBuFmL3nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178651>

On 7/28/2011 6:59 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I have a repository where I'd like to run a program every time the
> working tree is updated. githooks(5) specifies that you can use
> post-{checkout,merge} hooks to hook into those two operations.
>
> However that doesn't catch e.g. "git reset --hard". Is there any
> reason beside omission that there isn't a post-reset hook? Or hooks
> for any other thing (most of which surely slip my mind) which can
> update the working tree?

You could create an alias like "git resetr" that runs the script.

v/r,
neal
