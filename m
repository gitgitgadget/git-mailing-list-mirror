From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git fetch without --recurse-submodules option
Date: Wed, 16 Jan 2013 19:24:54 +0100
Message-ID: <50F6F076.8030305@web.de>
References: <CAHtLG6RE-xGYsp-Apcu3hk8OVck+HLYZdBtWvcweaBNetwtKNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXfn-0008EO-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757014Ab3APSY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 13:24:57 -0500
Received: from mout.web.de ([212.227.17.11]:54148 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755474Ab3APSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:24:55 -0500
Received: from [192.168.178.41] ([79.193.83.188]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0McWrM-1TdsG62WaO-00Hcsx; Wed, 16 Jan 2013 19:24:54
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAHtLG6RE-xGYsp-Apcu3hk8OVck+HLYZdBtWvcweaBNetwtKNA@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:RCIke9CCR7bBujOzxuY9A2NMkVypiHc17sm1kAWZ3Wd
 bHRLV9g9O2Ag2/tj84V3rKl8TiycUCi0NSbl1MLDQiXXoIuIeO
 w5/o+ykdA2dx2ajfYcG7inOwkPuabuqALKf6OjW/VjE0zsIm9c
 bvdoVMQYPH1DsNuSFaplR5G6VVhqUAhlY7Ijs36Bv4s8bbUw5+
 xAswQssKujTglOi55ikpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213794>

Am 16.01.2013 06:45, schrieb =E4=B9=99=E9=85=B8=E9=8B=B0:
> With git pull or git fetch without specifying --recurse-submodules,
> what is the default action?

on-demand fetch (unless something else is configured).

> It seems git fetches submodules wtihout specifying --recurse-submodul=
es.
> If this is not clear, please update documentation.

You are right, the documentation for pull and fetch does not state
explicitly that "on-demand" is the default here when the option is
not used.

> In git pull document --recurse-submodules option, it tells users to
> see git-config(1) and gitmodules(5), but does not tell users to refer
> to git fetch --recurse-submodules for the meaning of the switches.
> In git fetch document --recurse-submodules option, it does not tell
> users to see git-config(1) or gitmodules(5).

Thanks for pointing that out. Unless anyone else wants to improve the
documentation I'll look into that in my next git time slot.
