From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Tue, 8 Jul 2008 10:08:48 +0200
Message-ID: <20080708080848.GC3628@joyeux>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org> <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com> <20080707063424.GB5506@jhaampe.org> <4872CF86.5050702@gmail.com> <7v7ibxxfje.fsf@gitster.siamese.dyndns.org> <4872DE54.5010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 10:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG8Gt-0003or-Lc
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 10:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYGHIIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 04:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbYGHIIx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 04:08:53 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:35886 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYGHIIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 04:08:52 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay10.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KG8Fm-0007td-AH; Tue, 08 Jul 2008 10:08:50 +0200
Content-Disposition: inline
In-Reply-To: <4872DE54.5010804@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]195161
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87731>

On Mon, Jul 07, 2008 at 11:26:12PM -0400, Mark Levedahl wrote:
> Junio C Hamano wrote:
>> I'd like to hear clarifications on two counts, please?
>>  (1) If Sylvain wanted to have that appear at dir0/dir1/init not init,
>>      would it have been sufficient to give that path twice (once for
>>      <repository> and another for <path> parameter) to make things work as
>>      expected?
>>   
> git-submodule really requires two arguments:

Then it should raise an error when the following is given

  git submodule add ./relative-path-in-repo

which, for now, is accepted as

  git submodule add ./relative-path-in-repo ./relative-path-in-repo

(and confused me into thinking it was a normal behaviour)

Sylvain
