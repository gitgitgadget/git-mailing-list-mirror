From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 22:47:38 +0200
Message-ID: <51ED9A6A.8050502@web.de>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org> <51ECDFFC.8000500@web.de> <CACsJy8BsiXL9P5Rd9QZzG5Rtyd=0ewBbFRLwbAyumgTWwjJd5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 22:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1N1J-0002wz-Is
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab3GVUrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 16:47:41 -0400
Received: from mout.web.de ([212.227.17.12]:55560 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab3GVUrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 16:47:40 -0400
Received: from [192.168.178.41] ([91.3.166.142]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MOzrj-1V4vnB2lMN-006Nhl for <git@vger.kernel.org>;
 Mon, 22 Jul 2013 22:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CACsJy8BsiXL9P5Rd9QZzG5Rtyd=0ewBbFRLwbAyumgTWwjJd5A@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:cAYeHHZQlee8oHQQOtTPwhnOqBWkmULm0+HCszPFtq2lQcGdKEA
 /qB4vGasgPT2DhUj+qypRfXtFVa/tVMsUckD/zlrY2Qw1iCeC1AlBM1NyGEA4pKTFb2HCxr
 0b7W0JxsslAbF/7n7QU5odj6MOkTEatKhemh9lvzrW77DkUSjbvjuDWliI3PcOb4FjIC4if
 MxHQviapZlOw1/A7olR1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230990>

Am 22.07.2013 09:48, schrieb Duy Nguyen:
> On Mon, Jul 22, 2013 at 2:32 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 22.07.2013 08:57, schrieb Junio C Hamano:
>>> * jl/submodule-mv (2013-04-23) 5 commits
>>>  . submodule.c: duplicate real_path's return value
>>>  . rm: delete .gitmodules entry of submodules removed from the work tree
>>>  . Teach mv to update the path entry in .gitmodules for moved submodules
>>>  . Teach mv to move submodules using a gitfile
>>>  . Teach mv to move submodules together with their work trees
>>>
>>>  "git mv A B" when moving a submodule A does "the right thing",
>>>  inclusing relocating its working tree and adjusting the paths in
>>>  the .gitmodules file.
>>>
>>>  Ejected from 'pu', as it conflicts with nd/magic-pathspec.
>>
>> So I'll base my upcoming re-roll on pu, right?
> 
> The conflicted part is the use of common_prefix. I think you might be
> able to avoid the conflict by using quote.c:path_relative() instead of
> common_prefix() and prepending "../" manually. Or not, I did not read
> path_relative() carefully, nor your connect_work_tree_and_git_dir().

Thanks for the pointers, I'll look into that.
