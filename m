From: Knittl <knittl89@googlemail.com>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 17:43:53 +0200
Message-ID: <AANLkTilOOYlrQ5hfgxFnCIG4Qp5RE_EbfzP6vkfqBAJM@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 17:44:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA3FS-0001VK-M5
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 17:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248Ab0EFPoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 11:44:16 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:37900 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab0EFPoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 11:44:14 -0400
Received: by ewy20 with SMTP id 20so30665ewy.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Bsq58V1u7k9WCxygDXSydqsWH3ffKIwVyjJ3CozMsIs=;
        b=dPUF/+JRMWEvHo5HzWwcAeQJwoEFXuT5257Dv2kVX1UhhkgIuYYTGiF4o4Qjomti2i
         uI+UI5vmfH+SA6HrTqbwXbt8ZySOR2L9m32EaYnRcRCLW1z4ER6XJf0tdNfyVjiAvrFM
         DOE6YU3m3zNraDDlejv2l035g71vfLiVv6Tzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kg4aNngPur1vPW9aJzxOYKVVrq4VbD5H3mbSQjGQtR+OsCKtUQNv6LQ0FmTRHOSlJt
         0GPhNvM0N1uOnxU9ofx/FX/6LBTD1mv08XGCLhA1oZYkSWb1jaqIVi23k3c/Ef3HZGRX
         NnZg+wMCGyBVgm95EYSQ9hAJWdAhRA3HU07OY=
Received: by 10.213.52.139 with SMTP id i11mr3514184ebg.26.1273160653117; Thu, 
	06 May 2010 08:44:13 -0700 (PDT)
Received: by 10.213.3.5 with HTTP; Thu, 6 May 2010 08:43:53 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146483>

On Thu, May 6, 2010 at 11:27 AM, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> Basically, what I think I am asking for is a way to specify the
> empty parent of the initial commit, i.e., where v1.7.1~1000000 would
> end up. I can see this being useful in at least one other case as
> well, namely when doing an interactive rebase to allow the initial
> commit to be rebased (something I have wanted to do a couple of
> times...)


wait, let me get this straight. you want to diff some tag against the
empty parent of the root commit (empty tree)?

which in turn means you will get a diff, where all lines in all files
existing in the tree that tag references are added. all files get
basically prefixed with + and have header information (filename). what
purpose has such a diff?

regards, daniel

-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
