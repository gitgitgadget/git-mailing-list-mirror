From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Feb 2011, #04; Wed, 16)
Date: Mon, 21 Feb 2011 10:33:52 +0100
Message-ID: <4D623180.4030407@drmicha.warpmail.net>
References: <7vk4gzh8cd.fsf@alter.siamese.dyndns.org> <m3aahu987n.fsf@localhost.localdomain> <4D5D128C.1080808@drmicha.warpmail.net> <AANLkTinC0zB0bTRtaERBMNHnuU2kQVxz0oF+Rw3KFDvY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 10:37:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSCg-0007tL-Ix
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 10:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab1BUJhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 04:37:07 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52712 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752334Ab1BUJhG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 04:37:06 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 185732024A;
	Mon, 21 Feb 2011 04:37:05 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 21 Feb 2011 04:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YqYVKSC9i0ck9IQxG8G2sQfd754=; b=T500zF5fxAnW4mE5i+XeAISfu80zstkOa2/TcY4DlsOJlVwle5xenQlTB/Oe62VluUJrS3HlF48SGI/bd+Idr7LBOHXiQ9t8ODcGOTkcEpg5tWozx3PEIr7oUZH9sHWDDu2JDDQFCEAzfjt2e+Gr3AunQAYvX4nPmi4rotTPjK4=
X-Sasl-enc: WQW64RA/vgmZ5PQ4ZV+k3wyZjfxtC2g2OgJfaSagai1Q 1298281024
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1A9644056AD;
	Mon, 21 Feb 2011 04:37:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTinC0zB0bTRtaERBMNHnuU2kQVxz0oF+Rw3KFDvY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167451>

Sverre Rabbelier venit, vidit, dixit 20.02.2011 12:54:
> Heya,
> 
> On Thu, Feb 17, 2011 at 13:20, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> How would you even know they are different, since you neither read the
>> commit messages nor looked up the thread? Thomas Rast's work makes the
>> latter even simpler these days.
> 
> What work is that? I think I'm missing something useful here :P
> 

Well, first of all, some people's mail or news clients are so feature
bloated that you can even search/grep/filter for post titles such as the
ones listed readily in Junio's "What's cooking" posts.

For commits in git.git (with pu!), Thomas provides a notes based mapping
from commits to message ids. With

[remote "trast"]
        url = git://repo.or.cz/git/trast.git
        fetch = +refs/heads/notes/*:refs/notes/remotes/trast/*

git log --show-notes=remotes/trast/full

will give something like below. Neat, eh? (Even neater when not broken
by a MUA).

Kudos, Thomas!

Michael

commit 3b0d24053b50d8da76de28ea5f0d3947fa3d2194
Author: Michael J Gruber <git@drmicha.warpmail.net>
Date:   Thu Feb 17 08:48:06 2011 +0100

    Make <identifier> lowercase in Documentation

    Leaving uppercase abbreviations (e.g. URL) and an identifier named after
    an upercase env variable (CVSROOT) in place, this adjusts the few
    remaining cases and fixes an unidentified identifier along the way.

    Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Notes (remotes/trast/full):
    From: Michael J Gruber <git@drmicha.warpmail.net>
    Subject: [PATCH] Make <identifier> lowercase in Documentation
    Message-Id:
<d8246b3c2afe48505db13da63e01c0084346ade9.1297928789.git.git@drmicha.warpmail.net>
    Date: Thu Feb 17 08:48:06 2011
    In-Reply-To: <7vbp2birzi.fsf@alter.siamese.dyndns.org>
    Archived-At:
<http://permalink.gmane.org/gmane.comp.version-control.git/167053>
