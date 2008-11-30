From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] gitweb: make gitweb_check_feature a boolean wrapper
Date: Sat, 29 Nov 2008 16:23:51 -0800
Message-ID: <7vej0uysbs.fsf@gitster.siamese.dyndns.org>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
 <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
 <7vmyfiz0zf.fsf_-_@gitster.siamese.dyndns.org>
 <cb7bb73a0811291427n7922ab1fq50caedafe7163f9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>, "Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 01:25:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6a8F-0007JZ-TT
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 01:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYK3AYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYK3AYg
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 19:24:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYK3AYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 19:24:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B0BE807CF;
	Sat, 29 Nov 2008 19:24:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6E608807BB; Sat,
 29 Nov 2008 19:23:53 -0500 (EST)
In-Reply-To: <cb7bb73a0811291427n7922ab1fq50caedafe7163f9e@mail.gmail.com>
 (Giuseppe Bilotta's message of "Sat, 29 Nov 2008 23:27:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43539F70-BE75-11DD-82EA-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101938>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> On Sat, Nov 29, 2008 at 10:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * Again, this is to demonstrate how I would have liked to see your
>>   patches as a reviewable series.  Notice how this naturally justifies
>>   the dropping of parentheses in many lines that begin with "my", and
>>   makes it easier to review?  You can review the patch easily by knowing
>>   that callers that have s/get/check/ are now safe to use scalar context.
>
> Yes, I get the point: do less things under the hood. I also still
> think that three patches with code going ping-pong are way too much,
> though 8-P
>
> For what it's worth, you get my Ack: to your patchset 8-)

Well, I am not interested in taking credits for this series.  I am very
much interested in reducing my future workload by showing people how an
easily reviewable series should look like.

So if you still think it is "way too much", I did not succeed what I tried
to do X-<.
