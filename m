From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Fix a typo
Date: Sat, 9 Oct 2010 10:27:58 -0500
Message-ID: <20101009152758.GA17799@burratino>
References: <1286623119-13766-1-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: stepnem@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 09 17:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4bOH-0006xx-O0
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 17:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab0JIPbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 11:31:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34917 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab0JIPbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 11:31:09 -0400
Received: by iwn6 with SMTP id 6so1520895iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0RcTt9ZjtAmX1KS2w3IYYnZy4uhK5yfIMhD9P4QQUFI=;
        b=hHsg7X2Yu6P4g8E8nbhRfmxXXDgFgsTiy7GNVcvgrybUi97KGHApoZyC1c5z7fohac
         nidoExSKhW9+xEU2vK3YV+obrWchNG0b737bMmhXn/div8WqtLHZmzcNC3qePgAFpkeg
         C1oIiDOp3JQm+8X62HaaaKHBm+KtBbITtrAmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ceFRtW5tsa98LjqcT7ukWalVfDtnrZy8Bp3EPEmDV9CilytiBLZ2JN1TZCYfgQEhS7
         VUtDle/U19jdsYQR9Gy2DsSAs+b5ooqR6QOWTXC1IthGOikmxboD8eLwOQSwX61NWJ2X
         X+kHpO/ucYswPgi/IGTjfI1c2fmk8WWSZxENU=
Received: by 10.42.1.3 with SMTP id 3mr788388ice.70.1286638269259;
        Sat, 09 Oct 2010 08:31:09 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm2306510ibi.2.2010.10.09.08.31.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 08:31:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286623119-13766-1-git-send-email-stepnem@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158592>

stepnem@gmail.com wrote:

> `${parameter/pattern/string}' shell expansion uses glob patterns, so
> talking about `regexp' is confusing.

Okay.

> - - No regexp ${parameter/pattern/string}.
> + - No substitution ${parameter/pattern/string}.

A bit confusing, since ${parameter%word} and $parameter are
substitutions, too.

Maybe

 - No pattern substitution ${parameter/pattern/string}.

to match the bash manual, would be clearer?
