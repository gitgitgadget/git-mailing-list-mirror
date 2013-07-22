From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 09:32:12 +0200
Message-ID: <51ECDFFC.8000500@web.de>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 09:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1AbW-0000cY-24
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 09:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab3GVHcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 03:32:18 -0400
Received: from mout.web.de ([212.227.17.12]:64820 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345Ab3GVHcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 03:32:17 -0400
Received: from [192.168.178.41] ([91.3.152.70]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lj2QM-1UP6IY0QD0-00dGGg for <git@vger.kernel.org>;
 Mon, 22 Jul 2013 09:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:brIDSOspudqnyQVbdCGg1Wv/7PBi2njLSIbfjCDVr+DFXQyjjFK
 GweSn3++Lw1wU6f8QLnx+oqRh558EeAMmSaXpq7hKuJ4sz+Hkd3Tf3ZA2tqe5fvoBC7r/nu
 NClngrbGkJjBrhkPGtNijzS3GIAHW1zMOC19LY9nDaB19uhC6JiGkCXXEcviLj68QyEkwrs
 ZIZ2H/VlmDj6h7LVQljPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230964>

Am 22.07.2013 08:57, schrieb Junio C Hamano:
> * jl/submodule-mv (2013-04-23) 5 commits
>  . submodule.c: duplicate real_path's return value
>  . rm: delete .gitmodules entry of submodules removed from the work tree
>  . Teach mv to update the path entry in .gitmodules for moved submodules
>  . Teach mv to move submodules using a gitfile
>  . Teach mv to move submodules together with their work trees
> 
>  "git mv A B" when moving a submodule A does "the right thing",
>  inclusing relocating its working tree and adjusting the paths in
>  the .gitmodules file.
> 
>  Ejected from 'pu', as it conflicts with nd/magic-pathspec.

So I'll base my upcoming re-roll on pu, right?
