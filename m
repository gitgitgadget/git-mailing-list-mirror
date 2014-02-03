From: Andreas Ericsson <ae@op5.se>
Subject: Re: A few contributor's questions
Date: Mon, 03 Feb 2014 17:35:29 +0100
Message-ID: <52EFC551.8030203@op5.se>
References: <8738k44808.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 17:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAMUl-0007bk-Gl
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 17:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbaBCQfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 11:35:34 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33778 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaBCQfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 11:35:33 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so5604480lbd.9
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 08:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KJd0P45caYc5ARujE5Jn0fklQUDZ1L0sU0yV7Pui6qc=;
        b=YCt8GbYe3RAe9/np5G4p7NPYWgp86Sl9VOHuWYYhhi/s4eKNcdERGAsrMwvmKj6gaS
         jFr4neVpcckPsb37Buy8lzft2Cq1+3RP82j2l19VNE/XBEHoq4VfqcGOrYM58W4ITQ0y
         aduVlRqP1l5Y0QpTrbjJEA6xHVcdHNqy5Uem3iLlIXQ4uRyAM/WeInVbUnwJkRI/q7Tp
         TQAhVG87maaQy3/D9asAJ5M8X9W8jjUo+7p3aHweHCz+tqJJiuiYzrzJOtgz3kvFaAh2
         wIxCR67TFisrMXyGJnkodxNCKmi7m5kwqI4ocRoxmRuFeH2eHCGyBwzA0W+LtHr3Cseo
         92bw==
X-Gm-Message-State: ALoCoQlNT8kmewABNKhBhjjq37oUEMBRsybvZ1tBWztpxgOgKB9RCTWetOCwAnUPkeGy3FGrTGD3
X-Received: by 10.112.27.239 with SMTP id w15mr1348665lbg.60.1391445332573;
        Mon, 03 Feb 2014 08:35:32 -0800 (PST)
Received: from lenix.dev.op5.com. (host-78-64-111-238.homerun.telia.com. [78.64.111.238])
        by mx.google.com with ESMTPSA id ri4sm21985657lbb.6.2014.02.03.08.35.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 08:35:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <8738k44808.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241439>

On 2014-01-31 14:04, David Kastrup wrote:
> 
> I'm still in the process of finishing the rewrite of the builtin/blame.c
> internals.  Now there are various questions regarding the final patch
> proposals and commit messages.
> 
> Point 1) signing off implies that I'm fine with the licensing of the
> file. builtin/blame.c merely states
> 
> /*
>  * Blame
>  *
>  * Copyright (c) 2006, Junio C Hamano
>  */
> 
> which obviously will not match the authorship of my contributions.
> Since Junio has given blanket permission to reuse his Git contributions
> under other licenses (see
> <URL:https://github.com/libgit2/libgit2/blob/development/git.git-authors#L58>)
> that I am not going to license my work under, the first commit in the
> respective series would replace this header with
> 

It's a long time since I wrote that document.

Does this mean you're not willing to relicense your contributions with
the license used by libgit2? That's what the document is supposed to
mean and it's what I asked on the mailing list when requesting
permission.

The libgit2 license used as of today is still the license that people
agreed to relicense their contributions under. It can be found here:
https://github.com/libgit2/libgit2/blob/development/.HEADER

I'm mostly adding it here for the sake of clarity in case people find
this in the future and wonder what all the fuzz was about.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
