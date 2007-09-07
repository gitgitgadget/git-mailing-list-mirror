From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 12:13:23 +0200
Message-ID: <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com>
References: <20070906075104.GA10192@hand.yhbt.net>
	 <1189096669534-git-send-email-hjemli@gmail.com>
	 <20070906210155.GA20938@soma> <20070906213556.GA21234@soma>
	 <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
	 <20070906235516.GC4538@xp.machine.xx>
	 <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com>
	 <20070907084352.GD4538@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITaqA-0004yw-A0
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbXIGKNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbXIGKNZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:13:25 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:36838 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965057AbXIGKNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:13:24 -0400
Received: by rv-out-0910.google.com with SMTP id k20so396081rvb
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ty9jhyCwvp6+u7d7OEn4Q+F6vAio39cU9z6Z+mGQqHs=;
        b=fsADEpElYkydSLg6tdd5Ky/DvNZNZlPxK9QiIBFiDCUWcEEUailjjBfeVi3ipB5FgJJr6RTiiWT1+5u2xw8fTTCDHFOCZYdrWNlBOQ9k2xeXthqVWbsoB52x9PHtA2A73aUIZYGZ7VT26rPWiJymjsot/xAGYMAz6rhNbOkC0/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iyhgeuZq2vdV+vcB4byl6m8i34FWTSvViLj14eNL6l2FxQXHlYRStz482W6ieK7Jl1+iiOTA8bHQQFsDYqgI3O+WF+B2YZSiZa8I9yJTZQWui0YQXpEpV8X0hfxZe3omjyDu7QrOZIQ7aJZhHKG4arXnFtEKeoAxqH3wnfyGqfo=
Received: by 10.140.186.18 with SMTP id j18mr665508rvf.1189160003996;
        Fri, 07 Sep 2007 03:13:23 -0700 (PDT)
Received: by 10.140.187.2 with HTTP; Fri, 7 Sep 2007 03:13:23 -0700 (PDT)
In-Reply-To: <20070907084352.GD4538@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58015>

On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
>    lets reset 'trunk' to its state before the merge and
>    'branch1' to the merge commit, before fixing the bug in 'branch1'.
>
>        a-b-c-d-e    trunk
>           \      \
>            \ -x-y m branch1

Yeah, this would certainly not be handled correctly by dcommit using
--first-parent (but it could be handled by (a correct implementation
of) --upstream).

Thanks for the example, I had a feeling something like this could
occur. So I guess I'll have another go at --upstream this weekend.

[btw: could you please stop messing with 'Mail-Followup-To:'? When
replying to your mail, I don't want everyone _except_ you in the 'To:'
header...]

--
larsh
