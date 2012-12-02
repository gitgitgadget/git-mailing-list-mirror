From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sun, 02 Dec 2012 21:29:29 +0100
Message-ID: <50BBBA29.2000106@web.de>
References: <20121202190929.GG9401@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Dec 02 21:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfGAk-0003Jg-6s
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 21:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab2LBU3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 15:29:38 -0500
Received: from mout.web.de ([212.227.17.12]:62549 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab2LBU3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 15:29:37 -0500
Received: from [192.168.178.41] ([91.3.153.247]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LtnvF-1TFabH2WUn-01173M; Sun, 02 Dec 2012 21:29:30
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121202190929.GG9401@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:Fdtxwhc7aKkmfBq/urgXQuxYV/ylFWH9c8HiENUq57v
 fgtdrVjyz3tSl1azcHY60iyDaoE0dcY6yBXqxZgsILfSIXXugG
 ayV7u/z0xsaaLM/Zq0xW9hXWTygvq3/3x0wh8ac3M37l51rMGb
 662jg0ev0RB8GDregLLFOfF9iKfHGyCCEUPkFMis6Qf7YrMtjA
 QmpYAMzM4/QgHSCm5ThKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211017>

Am 02.12.2012 20:09, schrieb W. Trevor King:
> Before I get into the details, I'd like to point out that I actually
> understand the purpose of `submodule init` now ;).  To avoid further
> confusion, my current one-line command summaries would be:
> 
>   init:   mark a submodule as active for future submodule operation
>   deinit: mark a submodule as inactive for future submodule operation
>   sync:   update remote.<name>.origin in submodules to reflect changes
>           in .gitmodules or the superproject's remote URL.
> 
> I don't think we disagree on that, we just don't agree on how to
> implement it.

Nope, it is already implemented and you are arguing to change the
current implementation. To quote from another mail:

Am 01.12.2012 18:49, schrieb W. Trevor King:
> On Sat, Dec 01, 2012 at 06:25:17PM +0100, Jens Lehmann wrote:
>> What real world problems do we have with the current init/sync that
>> this approach would solve?
>
> I don't have any, ...

We don't want to change working code and cause compatibility issues
just because we /could/ do things differently, no?
