From: Nico Williams <nico@cryptonector.com>
Subject: Re: Amending merge commits?
Date: Mon, 28 Jul 2014 16:47:41 -0500
Message-ID: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sergei Organov <osv@javad.com>,
	"Besen, David" <david.besen@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 23:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBslp-00073k-32
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 23:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbaG1Vrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 17:47:45 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:49684 "EHLO
	homiemail-a24.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751650AbaG1Vro (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 17:47:44 -0400
Received: from homiemail-a24.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a24.g.dreamhost.com (Postfix) with ESMTP id 05BF12C806C
	for <git@vger.kernel.org>; Mon, 28 Jul 2014 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:date:message-id:subject:from:to:cc:content-type; s=
	cryptonector.com; bh=CWZ271EUku5fbfpFPo+sKWVIzvA=; b=NnBp1gZwPZv
	+TuCkBW9Y2E3Tocb1DuskcmmBNAB/dTGbp318BdVlPGQRTdVOHlYHRmkXcFtjDl2
	picnaeyJU36RQumUCfST4s2DBAIgMsVR8trIdclHyVWZAVt8BT8kSsCUV5nu/ncQ
	t7kqcnz0nsRCwgo1GLoTSgaCPtpjTX2Q=
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com [74.125.82.169])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a24.g.dreamhost.com (Postfix) with ESMTPSA id AE8C02C806B
	for <git@vger.kernel.org>; Mon, 28 Jul 2014 14:47:43 -0700 (PDT)
Received: by mail-we0-f169.google.com with SMTP id u56so8165119wes.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 14:47:41 -0700 (PDT)
X-Received: by 10.180.39.73 with SMTP id n9mr3300wik.70.1406584061299; Mon, 28
 Jul 2014 14:47:41 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Mon, 28 Jul 2014 14:47:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254357>

On Mon, Jul 28, 2014 at 3:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Sergei Organov wrote:
>
>> Is there any scenario at all where pull --rebase=true wins over
>> preserve?
>
> Basically always in my book. ;-)
>
> When people turn on 'pull --rebase', they are asking for a clean,
> simplified history where their changes are small discrete patches in a
> clump on top of upstream.

+1.  Words to develop by.

There are exceptions.  E.g., when you pull commits from multiple
[forked] upstreams, then you can't keep your local commits on top.

That exception aside, keeping all local commits "on top" by always
rebasing them onto the upstream is extremely useful: a) in simplifying
conflict resolution, b) making it easy to identify as-yet-unintegrated
local commits, c) making it easy to contribute local commits.

Nico
--
