From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building Documentation in Cygwin
Date: Tue, 27 Jan 2009 10:32:22 -0800
Message-ID: <7vskn4y4zt.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
 <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
 <c115fd3c0901270944p7a4b6cc5n5dfe9b2f268f038c@mail.gmail.com>
 <c115fd3c0901271027s61a33273lfe9dd702a66aac6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsl1-0001wq-J8
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbZA0Scb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbZA0Scb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:32:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZA0Sca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:32:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 363379422E;
	Tue, 27 Jan 2009 13:32:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8BDC9422A; Tue,
 27 Jan 2009 13:32:24 -0500 (EST)
In-Reply-To: <c115fd3c0901271027s61a33273lfe9dd702a66aac6@mail.gmail.com>
 (Tim Visher's message of "Tue, 27 Jan 2009 13:27:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA486146-ECA0-11DD-B572-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107382>

Tim Visher <tim.visher@gmail.com> writes:

> On Tue, Jan 27, 2009 at 12:44 PM, Tim Visher <tim.visher@gmail.com> wrote:
>
>>> you might also want to try getting the cygwin package docbook-xml42.
>>
>> Sure enough, I didn't have that installed.  Turns out I should've done
>> that part first too, as it appears to have fixed my problem.  Thanks
>> so much!
>
> Well, I take that back.  I built the docs successfully on the machine
> that is connected to the net.  I couldn't build them on the offline
> box.  Currently my solution is to build them on this box and then
> manually move them over to the offline box.  It'd be nice to not have
> to do this though... :\
>
> Anyway, further help is appreciated! :)

The xml toolchain has a tendency to download dtds from the original source
with a way for you (typically your distribution) to tell it to use a
locally installed version.  "Can build online, fail when offline" is a
sign that it is not using the local copy.
