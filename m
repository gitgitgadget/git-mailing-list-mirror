From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: ks/precompute-completion
Date: Thu, 12 Nov 2009 22:40:16 -0800
Message-ID: <4AFCFF50.5080401@gmail.com>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com> <20091111220832.GA31620@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 07:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ppc-0003Mp-82
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 07:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbZKMGkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 01:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbZKMGkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 01:40:16 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56190 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbZKMGkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 01:40:15 -0500
Received: by yxe17 with SMTP id 17so2685251yxe.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 22:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=reEjs02u78gicckgDUiL0lzxpfCAuJq8Rg1Ys5VtzQg=;
        b=XsKZoVvzph5QkUiW0t3HuqjHKBb0wsHJb00rxIHo6pGZ7vyUak0KpEE6lkL9x+mXum
         IvPsKDuLC2YgV+pusFImXq5yNtS0naxBkhZjrHXS8IEnGnTKnzgk63LVXPXfUwlmSv/i
         S5AcdYuFfML47a40yyuf26LdjrhoJ2CuZVa5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hFMyk3QX2bNLuqo1NHlWJneGtTAlEO5Uo9lwgvMn7iwbNHKABOW4z1XE6ym70JD1Wc
         nClSimBCw4sfd+X0PlsP27wCuj0ht+A6D3HkeRzEQC+s3V/Nqwjfc5fcSzL/fehgH25N
         GQqQhSnW7LT4E/StTciUVTfvpB4EhVM/aR6Zk=
Received: by 10.150.237.9 with SMTP id k9mr7100296ybh.108.1258094420696;
        Thu, 12 Nov 2009 22:40:20 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 22sm1331537ywh.15.2009.11.12.22.40.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 22:40:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <20091111220832.GA31620@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132816>

Jonathan Nieder wrote:
>
> As a distro user, I don't think I would be able to use it until there
> is a command to update the installed completion, to call after adding
> a new git command to my $PATH.  This could mean:
>
>  - git-completion.bash.generate learns to read the .in file and
>    write the completion script to arbitrary paths (or just always
>    uses stdin and stdout?)
>
>  - distros install git-completion.bash.{generate,in} to /usr/share/git-core
>
>  - distros install a simple completion script to /etc/bash_completion.d
>    that passes the buck, e.g.
>
> <snip scripts>
>
> Thoughts?

I'm confused. Shouldn't your distro take care of updating the completion 
for you? And wouldn't update-git-completion be more suited as part of a 
makefile if it was needed at all?
