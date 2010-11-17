From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Difference between 'git rebase' and 'git rebase -m'
Date: Wed, 17 Nov 2010 14:36:38 +0100
Message-ID: <4CE3DA66.80808@drmicha.warpmail.net>
References: <4CE2C0ED.1030309@workspacewhiz.com> <20101116182749.GC14552@burratino> <AANLkTik7RML10gyQ19OV0KAH8Mn3=VZe92kU1qxER7wO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Bash <bash@genarts.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 14:38:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIiDp-0003RW-RP
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 14:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933390Ab0KQNin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 08:38:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35858 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932433Ab0KQNin (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 08:38:43 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5638D940;
	Wed, 17 Nov 2010 08:38:42 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 17 Nov 2010 08:38:42 -0500
X-Sasl-enc: 3O/jALbY4Vj6U8eau9S1UpTST3Cq9o6E+a/saIPIoC1q 1290001122
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0EC105EBF28;
	Wed, 17 Nov 2010 08:38:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <AANLkTik7RML10gyQ19OV0KAH8Mn3=VZe92kU1qxER7wO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161613>

Nguyen Thai Ngoc Duy venit, vidit, dixit 17.11.2010 12:43:
> On Wed, Nov 17, 2010 at 1:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Joshua Jensen wrote:
>>
>>> I'm curious as to why 'git rebase -m' isn't the default and what the
>>> real difference is between 'git rebase' and 'git rebase -m'.
>>
>> git rebase is faster. :)
> 
> Perhaps a config option to let people to default to -m. Or perhaps
> they can just make an alias.
> 
> By the way, can we make rebase even faster? Rebasing ~20 patches or
> more seems slow to me. I don't know much how patching works though.

git sequencer...

Michael
