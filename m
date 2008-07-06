From: Junio C Hamano <gitster@pobox.com>
Subject: Re: finding deleted file names
Date: Sat, 05 Jul 2008 22:17:55 -0700
Message-ID: <7v63rjpp4s.fsf@gitster.siamese.dyndns.org>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
 <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
 <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
 <20080703104233.GA26162@sigill.intra.peff.net>
 <93c3eada0807032345r2ff59d69kca42bc9ea7782f31@mail.gmail.com>
 <7v1w2aw2lt.fsf@gitster.siamese.dyndns.org>
 <93c3eada0807052154j9de9074s8c5625fb7507b96e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Mikael Magnusson" <mikachu@gmail.com>, git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Sun Jul 06 07:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFMeP-0002Ky-4Q
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 07:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYGFFSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 01:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbYGFFSG
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 01:18:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYGFFSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 01:18:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A99E21AFCD;
	Sun,  6 Jul 2008 01:18:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C8C6E1AFC9; Sun,  6 Jul 2008 01:17:58 -0400 (EDT)
In-Reply-To: <93c3eada0807052154j9de9074s8c5625fb7507b96e@mail.gmail.com>
 (Geoff Russell's message of "Sun, 6 Jul 2008 14:24:48 +0930")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9540E42-4B1A-11DD-8C2E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87498>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> On 7/4/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
>>
>>  > ... I've made a bunch of changes to a repository, a few weeks later I
>>
>> > figure I've deleted a file I need but am not really sure of its name. So
>>  > I want to list the files that I've deleted during the past few weeks.
>>
>>
>> $ git log --pretty=oneline --diff-filter=D --name-only -M --since=90.days
>
> This is good, but on my version 1.5.5.1, is giving the commit-ids +
> comments as well
> as the names.

Oh, I very much intended to give them, as --since=90.days is very broad
that you would want to know which exact commit to learn when the found
change was made anyway.
