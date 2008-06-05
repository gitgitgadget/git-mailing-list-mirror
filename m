From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 21:15:53 +0200
Message-ID: <bd6139dc0806051215i3e1f1aecg26a4baa358504849@mail.gmail.com>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
	 <20080605081911.GA5946@mithlond.arda.local>
	 <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
	 <F9BB4443-EDCA-4941-9852-B84535DAD097@wincent.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Kx7-00046L-5f
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 21:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbYFETPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 15:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbYFETPz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 15:15:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:43246 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYFETPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 15:15:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so622814wfd.4
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XNHyLWEoQC4x9WvC/STnwA4EJ/GUcjQMwOv6FyWT6tM=;
        b=JcLous2M6UgBRlOQJAVmtSCFkVLkEfo+7UC4h11ke0LqX2KqAY8pWXurn9YQi1Yh93
         UzyLdcEcPzh/w2NY2iDHdwt3L925JIoWUKGR8vt06dO14yvvBDss93aNC/6/AyZSUPNl
         0wfKOpMzo0a1DAd5tBPyPACYCPanerrUeqlcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=PcyUlyDlo28UESjqoGxpr3ZToLqks8Ckk3Macho1ggoCkoFVlIJ9L5oTXwjUXbblbl
         5ntiYRuK4GhqRP985GIoAtJJVSUywImIOi3QGAI/FDZzJU6m2vF9pu03+USo5Nxly6qs
         ypmXN0YeKXi+dWKSycAqc6n2j9NIDrsuio/Oo=
Received: by 10.142.231.7 with SMTP id d7mr688458wfh.264.1212693354016;
        Thu, 05 Jun 2008 12:15:54 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Thu, 5 Jun 2008 12:15:53 -0700 (PDT)
In-Reply-To: <F9BB4443-EDCA-4941-9852-B84535DAD097@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83960>

On Thu, Jun 5, 2008 at 8:42 PM, Wincent Colaiuta <win@wincent.com> wrote:

> But if the user types "git help" they'll be presented with the exact same
> list of common commands again, at which point they'll probably wonder why
> Git suggested that.

This is exactly what I meant with my earlier comment.

> Funnily enough, if they type "git help help" then they'll get the "git-help"
> man page. So, there is no command called "git-help" on the system, but from
> the user's perspective it walks, talks and quacks like all the "real"
> commands, and so they probably consider it to be one. Whether or not the
> "help" subcommand corresponds to a real executable or script is really just
> an implementation detail, I think.

I fully agree here, it doesn't matter if there is a 'git-help.sh' or
'git-help' executable, as long as from the users POV there is a 'git
help' command should we advertise it.

> Having said that, I think your suggestion is sound if it were reworded as:
>
>  See 'man git' and 'git help [command]' for more information.

That would be good, since it does not advertise a git help command,
instead it advertises 'git help command', which clearly -is- a command
(since typing 'git help command' brings up a man page).

-- 
Cheers,

Sverre Rabbelier
