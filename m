From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when
 they do a merge and see "file.txt: needs update". "file.txt: has changes" is
 much clearer.
Date: Sat, 03 May 2008 18:24:29 -0700
Message-ID: <7vtzhesvxu.fsf@gitster.siamese.dyndns.org>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
 <alpine.DEB.1.00.0805031509170.30431@racer>
 <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
 <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com>
 <7v63tvszgo.fsf@gitster.siamese.dyndns.org>
 <32541b130805031721n29cf470cx391fe0e8b4943706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Tim Harper" <timcharper@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 03:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsSyy-00029Y-NB
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 03:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbYEDBYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 21:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbYEDBYs
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 21:24:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbYEDBYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 21:24:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7762F4D3A;
	Sat,  3 May 2008 21:24:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AA7984D36; Sat,  3 May 2008 21:24:38 -0400 (EDT)
In-Reply-To: <32541b130805031721n29cf470cx391fe0e8b4943706@mail.gmail.com>
 (Avery Pennarun's message of "Sat, 3 May 2008 20:21:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0880BA2-1978-11DD-97F7-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81124>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 5/3/08, Junio C Hamano <gitster@pobox.com> wrote:
>> > I ran all of the tests with the patch apply, and they all pass.  Is
>>  > that enough indication?
>>
>> Of course not.  Where does end-user scripts come into play when you are
>>  running the testsuite?
>
> I thought user scripts weren't supposed to rely on the porcelain
> output?  It seems to change rather frequently anyway.

Wasn't the patch about changing output from "update-index --refresh",
which is as low as you can get?
