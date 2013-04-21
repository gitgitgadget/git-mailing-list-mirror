From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/1] git-multimail: a replacement for post-receive-email
Date: Sun, 21 Apr 2013 15:28:35 -0700
Message-ID: <7v61zfselo.fsf@alter.siamese.dyndns.org>
References: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
	<20130421105612.GA28959@elie.Belkin>
	<7vhaizu3j5.fsf@alter.siamese.dyndns.org>
	<517445E5.3080304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 22 00:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2kc-0003fb-EL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 00:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3DUW2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 18:28:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab3DUW2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 18:28:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39345184E4;
	Sun, 21 Apr 2013 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=puf4bFxq5gR7XyGovHS2v4JWRdg=; b=FYvJdC
	FblW2Ust0xK8HSlaR/TMwPI0anReffb7Fu6ejmAw2XrHxmXBBAbZqpBbcaIaBGFr
	yQt9sgcSwWSvEXuVrwnR/GRxVILTxQYT1t6mChkr+LI9d/GoehhC6uDfZWin27AW
	TLObalppif3R2TI7vBA927JaHfkSQ/9yAWST4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbs4qO35o9dIA9vJa2FAIVylKq6hEQk+
	3nufxozz5S7FJUpZp7OMZvK1vifxh1aH6KIDKWhxx4ezw6o5tDNurrPEOM37DMhq
	Z0MqN1V1Tz1CJNh8nGiNTvaN/CejLPp2Lums8uyB/NRS3EDgrpX7MQYjwmiLXIZ2
	EuIoqURGIlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C889184E3;
	Sun, 21 Apr 2013 22:28:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7860E184DF;
	Sun, 21 Apr 2013 22:28:39 +0000 (UTC)
In-Reply-To: <517445E5.3080304@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 21 Apr 2013 22:02:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0B7244C-AAD2-11E2-905E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221980>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * When I think a batch of patches is ready, I merge them to my master
> and publish my master somewhere.  (Or is it better I publish the feature
> branch and leave it to you to merge directly to your master?)

I think I missed this part, but in the case of git-svn, what we do
is the former.  The branch Eric makes me pull may be called 'master'
in his repository, but it does not contain anything unrelated to
git-svn, so from _my_ viewpoint, it is a single "topic to improve
git-svn".

But from Eric's point of view, it is an aggregation of different
topics from many people on top of my tree, and each topic may tackle
its own theme. I think most of the pulls from him so far were single
strand of pearls without merges, but if two or more long topics were
cooking in his tree, it would have been perfectly reasonable for him
to resolve such inter-topic conflicts before telling me to pull the
result.

After all, that is what the sub-maintainer of an area is.  One who
knows the area the best coordinates possibly conflicting changes
brought in different topics to the area.

Ths same can go for multimail, or any contrib/ material for that
matter.
