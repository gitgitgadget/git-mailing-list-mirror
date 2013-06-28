From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Fri, 28 Jun 2013 22:54:49 +0200
Message-ID: <51CDF819.9030308@web.de>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com> <20130624224925.GC32270@paksenarrion.iveqy.com> <20130625221132.GB4161@sandbox-ub> <20130626160219.GC9141@paksenarrion.iveqy.com> <7vli5wvb3n.fsf@alter.siamese.dyndns.org> <51CC5235.6030908@web.de> <20130628065001.GA2783@sandbox-ub> <7vk3lenkhh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 22:55:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usfh8-0000Kw-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 22:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057Ab3F1Uy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 16:54:59 -0400
Received: from mout.web.de ([212.227.17.12]:62882 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab3F1Uy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 16:54:58 -0400
Received: from [192.168.178.41] ([79.193.94.84]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Martm-1UZLcZ3ALa-00KPwC; Fri, 28 Jun 2013 22:54:50
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vk3lenkhh.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:LVlaCPe9zeljYhHUg8rOMgIFGfmLcLLiD5tveUjh2Wu0+GSoDvc
 xbj6pK3SgY6ZVUaSbSRS0LBdc0BPzMvpkeiFRxHWsiawZvt8ResB8ccArAR6nLGe4PBi9tg
 0ypCI/TuEx3QNNesEvuzzLWfdwQBYh/UobV5WiulRELS+/zsNMdPxLf9+7bH+KhB0V2LshJ
 T36hFhhrgXhiBG/RWYGUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229239>

Am 28.06.2013 20:44, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> On Thu, Jun 27, 2013 at 04:54:45PM +0200, Jens Lehmann wrote:
>> ...
>>> Me too thinks adding "--depth" to "update" makes sense (and I don't
>>> think that this pretty generic name will become a problem later in
>>> case someone wants to add a maximum recursion depth, as grep already
>>> uses "--max-depth" for the same purpose).
>>
>> Hmm, but does it have a --depth option for revisions? Maybe we should
>> call it --clone-depth or --rev-depth to make it clear? --depth and
>> --max-depth would be completely orthogonal but the name does not allow
>> to distinguish them properly.
> 
> I do not have a strong opinion either way, but as you suggest, it
> might be a good idea to call this new option --clone-depth to be
> more specific.

No strong opinion here either, but I'm leaning towards "--depth"
because on one hand we already have the "--reference" option which
is passed on to the clone command (and not "--clone-reference") and
on the other hand I cannot see the need for yet another depth option
(even my "--max-depth" example doesn't seem to be terribly useful).
But I might be wrong on the last one ;-)
