From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git submodule summary: add --files option
Date: Sat, 15 Aug 2009 13:40:55 +0200
Message-ID: <4A869EC7.7080701@web.de>
References: <4A846A62.7010306@web.de> <7v8whmjhqh.fsf@alter.siamese.dyndns.org> <8c5c35580908150140q1d209664ic5e3816609365e24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 13:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McHfr-0001VR-FM
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 13:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZHOLnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 07:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbZHOLnk
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 07:43:40 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46252 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbZHOLnj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 07:43:39 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 67406112EA04D;
	Sat, 15 Aug 2009 13:41:08 +0200 (CEST)
Received: from [80.128.100.54] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1McHdE-0002gW-00; Sat, 15 Aug 2009 13:41:08 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
In-Reply-To: <8c5c35580908150140q1d209664ic5e3816609365e24@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+ah5kTesj74Mgjq2vV6HjJXAKim1UJQZXy3z60
	LdlNrRbco3wSwGxO0A7VFrIZ7yQShPlTc/5mpO/5R/oOdqWIp8
	fm6Hz+/QVfb+P0Nal1nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125998>

Lars Hjemli schrieb:
> On Fri, Aug 14, 2009 at 21:52, Junio C Hamano<gitster@pobox.com> wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> git submodule summary is providing similar functionality for submodules as
>>> git diff-index does for a git project (including the meaning of --cached).
>>> But the analogon to git diff-files is missing, so add a --files option to
>>> summarize the differences between the index of the super project and the
>>> last commit checked out in the working tree of the submodule.
>>>
>>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> Makes sense to me.  Comments?
> 
> Acked-by: Lars Hjemli <hjemli@gmail.com> with a tiny fixup:
> 
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -129,7 +129,7 @@ summary::
>         in the submodule between the given super project commit and the
>         index or working tree (switched by --cached) are shown. If the option
>         --files is given, show the series of commits in the submodule between
> -       the index of super project the and the working tree of the submodule
> +       the index of the super project and the working tree of the submodule
>         (this option doesn't allow to use the --cached option or to provide an
>         explicit commit).

Yup, sentence this makes much more sense now ... :-)

Shall i send an updated patch?


Jens
