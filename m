From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 16:24:01 +0100
Message-ID: <4D594911.40409@drmicha.warpmail.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>	<20110213193738.GA26868@elie>	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>	<87k4h34bhj.fsf@catnip.gol.com>	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>	<4D58D2DF.1050205@viscovery.net>	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>	<4D5906FD.7030502@drmicha.warpmail.net>	<AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>	<4D59316E.5090203@drmicha.warpmail.net> <AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 16:27:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp0Kz-00047R-JB
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab1BNP1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:27:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46395 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755566Ab1BNP1G (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:27:06 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 68AEB201D1;
	Mon, 14 Feb 2011 10:27:06 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 14 Feb 2011 10:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vbn5JYFrcmrUh47qQcRkfbqdV6A=; b=r+DfjyXr6/pzFbtq3Kbv4dfdxayt3pexBjcSUQ+PVNalUUk/1Jph8XVEA23P4e1MePttGicK9/gHS36p9KAuNT1yokH9W0r8sIsoh2WNIKMLUVJohJEHx4NlU0Nf1noIesZFaKD5i+txbng6n2wtB+Aoyli3WafzvE8qp01kSBc=
X-Sasl-enc: NN8Zpe/mKLgH31RCRu/aR6mD4XEdZmMQSwAZ7TjX5zs9 1297697226
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1607D443D02;
	Mon, 14 Feb 2011 10:27:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166728>

Felipe Contreras venit, vidit, dixit 14.02.2011 15:17:
> On Mon, Feb 14, 2011 at 3:43 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>>
>>> Be careful with your fingers. There's a command named "git stage".
>>
>> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.
> 
> I have proposed before to extend 'git stage', so you can do 'git stage
> diff', or if you alias 'git stage' to 'git s', just 'git s diff'. This
> would not conflict with the old behavior of 'git stage $file'.
> 
> case "$1" in
> add)
>         shift
>         git add $@
>         ;;
> rm)
>         shift
>         git rm --cached $@
>         ;;
> diff)
>         shift
>         git diff --cached $@
>         ;;
> import)
>         shift
>         git ls-files --modified --others --exclude-standard -z $@ | \
>         git update-index --add --remove -z --stdin
>         ;;
> ls)
>         shift
>         git ls-files --stage $@
>         ;;
> *)
>         git add $@
>         ;;
> esac
> 
> Cheers.
> 

In principle I like this a lot: a set of commands operating on/with the
stage/index/cache consistently. It think it's similar in (good) spirit
to our earlier attempts at INDEX and WORKTREE pseudo-revs, trying to
give that somewhat nebulous (for noobs) index a more concrete
"appearance", not hidden away in options (--index, --cached) and
defaults (diff against index by default).

In our case, however, I think the design principle deviates from our
common form:

git foo bar

usually means "do foo" to "bar", as most of our common commands are
verbs (being applied to the object "bar"). When it comes to subcommands
we do have inconsistencies already (double-dashed vs. undashed, e.g.),
but I'd prefer fewer ;)

Michael
