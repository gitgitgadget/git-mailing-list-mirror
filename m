From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed, 06 May 2009 18:15:35 +0200
Message-ID: <4A01B7A7.9020308@drmicha.warpmail.net>
References: <1241620621-12188-1-git-send-email-julien@danjou.info> 	<200905061649.25351.fge@one2team.com> <20090506153212.GF10701@abydos.adm.naquadah.org> <8c9a060905060846o1a7b26b0m78ff0cbe48648873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Julien Danjou <julien@danjou.info>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 18:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1jnC-0002nG-32
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 18:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759942AbZEFQPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 12:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbZEFQPq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 12:15:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57134 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759334AbZEFQPp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 12:15:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D170633AFF4;
	Wed,  6 May 2009 12:15:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 06 May 2009 12:15:44 -0400
X-Sasl-enc: oSdtq+fqIOt24rUoiU94KuwF5UsEMPJWP/LLEQplHBx5 1241626544
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DCA721E626;
	Wed,  6 May 2009 12:15:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090504 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <8c9a060905060846o1a7b26b0m78ff0cbe48648873@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118353>

Jacob Helwig venit, vidit, dixit 06.05.2009 17:46:
> On Wed, May 6, 2009 at 08:32, Julien Danjou <julien@danjou.info> wrote:
>> At 1241621365 time_t, Francis Galiegue wrote:
>>> Didn't you forget a little something in your patch?
>>
>> If so, I really can't see what.
>>
>> Cheers,
>> --
>> Julien Danjou
> 
> I'm guessing, but perhaps Francis means a test for this behavior?

Documentation (besides changing <> to []), test.
Also, it looks as if a get_one_entry() declaration is added without a
definition. But the definition is there already.

Michael
