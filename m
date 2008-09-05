From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid warning when bisecting a merge
Date: Fri, 05 Sep 2008 01:31:02 -0700
Message-ID: <7v3akfvvsp.fsf@gitster.siamese.dyndns.org>
References: <1220562150-19962-1-git-send-email-hendeby@isy.liu.se>
 <200809050814.36937.chriscool@tuxfamily.org>
 <7vhc8vxg04.fsf@gitster.siamese.dyndns.org> <48C0DD32.5010008@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 05 10:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbWjt-0005iT-A3
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 10:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYIEIbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 04:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbYIEIbN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 04:31:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbYIEIbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 04:31:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9DF785D11B;
	Fri,  5 Sep 2008 04:31:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0166D5D11A; Fri,  5 Sep 2008 04:31:06 -0400 (EDT)
In-Reply-To: <48C0DD32.5010008@isy.liu.se> (Gustaf Hendeby's message of "Fri,
 05 Sep 2008 09:18:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE4AFA74-7B24-11DD-A89B-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95002>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> On 09/05/2008 08:29 AM, Junio C Hamano wrote:
> ...
>> Yup, that might make more sense. In the meantime, I suspect this makes
>> more sense than introducing a new state "0".
>
> I can't argue with that.  Junio, your suggestion makes more sense.  I
> should have paid more attention to what I was doing.  Sorry about the noise.

That's Ok.  Spotting mistakes is an important part of the review process;
there is no need to be afraid of or apologetic about it.
