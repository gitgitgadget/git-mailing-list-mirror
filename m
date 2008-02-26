From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] help: respect aliases
Date: Tue, 26 Feb 2008 09:56:13 -0500
Message-ID: <76718490802260656s459e9241ie2a2d6b255c77fa4@mail.gmail.com>
References: <cover.1203890846.git.peff@peff.net>
	 <20080224221737.GD31309@coredump.intra.peff.net>
	 <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>
	 <alpine.LSU.1.00.0802261222570.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 15:57:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU1En-0000L4-Qu
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 15:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYBZO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 09:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYBZO4T
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 09:56:19 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:36958 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbYBZO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 09:56:18 -0500
Received: by el-out-1112.google.com with SMTP id v27so1873940ele.23
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V6UT9NtfASaJQ29B14pdQGPZib6j71xHQu4cXJk+qI8=;
        b=jvBppi591nXfDMfOMy0FZf2Epl8Q5VtH99hAMxwHpuIpAqecH/J/NyJAXRu2eDSWInALDhn8JDPcbcJUXSCjrxFyLou/S7Rue+USRyZeev/cz17hom9toHL0xYF3KthgoIknlRMeLw71vA+G782GuHGjtBFa9nM+fm32402Y+pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=boGeIJnhAJzla+DxVep+ZoBN4BhyCCrwlE+hov0p8MVZP1BObsOU1Ffn1viyKdnvLVQMAuJsPO1z88+fmWNXzDDM2f7qHUqR22Lpb9m4HQriWAbUH+o81BuImJW7DHlWBgfPpp8gwAj1VgQ8Ra0wKm1GOSq3DnAXZyyxOye5hUA=
Received: by 10.114.110.12 with SMTP id i12mr5552446wac.73.1204037773026;
        Tue, 26 Feb 2008 06:56:13 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Tue, 26 Feb 2008 06:56:13 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802261222570.17164@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75142>

On Tue, Feb 26, 2008 at 7:43 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>  On Sun, 24 Feb 2008, Jay Soffian wrote:
>
>  > This too would be less ugly as a built-in:
>  >
>  >  [elided so as not to burn anyone's eyes out again :-) -- jay]
>
>  Wow.  This would look less ugly as an alias like this, too:
>
>  alias = "!sh -c 'case $# in \
>         0) git config --get-regexp \"^alias\\.\" | sed \"s/^alias\\.//\";; \
>         *) git config \"alias.$0\" ;; \
>         esac'"
>
>  which incidentally fixes a bug in your alias: you ignore $0 which is the
>  first parameter when using the sh -c '' idiom.

Test mine. Test yours. See which works. :-)

At least on my system, I had to use:

  sh -c '...' -

And then refer to $1.

>  Of course, you can change the sed call to your liking...

Most of the ugliness in mine is that I crammed the whitespace down and
that I'm using a quite involved pipeline to reformat all my aliases so
they fit into my terminal window.

But the --get-regexp is a good tip.

j.
