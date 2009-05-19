From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 12:37:25 +0200
Message-ID: <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519102742.GA28702@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 12:37:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6MhT-0004HO-OI
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 12:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbZESKh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 06:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZESKh0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 06:37:26 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:41898 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbZESKhZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 06:37:25 -0400
Received: by fxm2 with SMTP id 2so3775060fxm.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1tGf/hDVgbFmJev/EoyX6ITc9CTw3nkm22beq8NqcIE=;
        b=mrhYCg4OWt9jL3W3n/rjPKBWUuM7oqrQOxPPieUwnMhQ1Bq9VOGxdaFpuqQu1kQqo9
         XC6RnD22QEZwZ2jxVLKsqGJQESTwgRi0DXBKEOCKFxGqyvsYGgaTgJdfId6dRCyMjks6
         ZOg8BoiQ48RdauzxY7mqZPknI19E0ObVf6VjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D/ICpyJfhOTvO1AH1vkgxrH9E9NZ8D5UtiaweicapIDd03aGIaiAgU+1Xa7RJ4lxl3
         f0RSN9Pxxw6Ths1mGQZVtn7b2IUYMCc0Nd/fMVKtM9iQFgQVvvKMOLzAOA5gNudYiIA9
         9SQyBXhH64skuV+WYnE4Ab3wUpGeJjcG9UeK4=
Received: by 10.223.103.133 with SMTP id k5mr4984331fao.23.1242729445912; Tue, 
	19 May 2009 03:37:25 -0700 (PDT)
In-Reply-To: <20090519102742.GA28702@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119513>

On Tue, May 19, 2009 at 12:27, Michael Radziej <mir@noris.de> wrote:
> Hi,
>
> I'm really looking forward for a tool like this and tried your patch
> instantly, but I keep getting:
>
> gvpr: "/usr/local/share/topgit/graph.gvpr", line 936: gg_nl_ret +=3D
> graph_output_commit_line();<<<
> =C2=A0-- cannot convert node_t to string
> Error: <stdin>:16: syntax error near line 16
> context: =C2=A0>>> \ <<< t"t/conflicts" -> "master";
>
> I have no idea what graph.gvpr is trying. My repo is available at:
>
> git://github.com/mradziej/topgit.git
>
> Your patch is on t/tg-graph. I tried "tg graph" on this repo.
>
> Any idea?
No, it works here. Which version of graphviz do you have?

Thanks,
Bert
>
> Cheers
>
> Michael
