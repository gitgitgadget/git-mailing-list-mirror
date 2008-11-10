From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -v does not removes the patch
Date: Mon, 10 Nov 2008 15:27:18 -0800
Message-ID: <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
 <20081110181023.GA22753@coredump.intra.peff.net>
 <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgBj-0000yS-38
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYKJX1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 18:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYKJX1k
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:27:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbYKJX1k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 18:27:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C68D7BF18;
	Mon, 10 Nov 2008 18:27:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4D417BF14; Mon,
 10 Nov 2008 18:27:25 -0500 (EST)
In-Reply-To: <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 10 Nov 2008 23:34:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A0F9E74-AF7F-11DD-8794-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100588>

"Santi B=C3=A9jar" <santi@agolina.net> writes:

> On Mon, Nov 10, 2008 at 7:10 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Nov 10, 2008 at 04:20:51PM +0100, Santi B=C3=A9jar wrote:
>>
>>> Hi *,
>>>
>>>   $subject since:
>>>
>>> 4f672ad (wt-status: load diff ui config, 2008-10-26)
>>>
>>> I tried to make a test case, but failed. I think because it is a bi=
t
>>> tricky the fake_editor/stdin/stdout stuff, so at the end I bisected=
 it
>>> by hand
>>
>> Sorry, I don't quite understand what the problem is. From reading yo=
ur
>> subject line, I expected that "git commit -v" would show the diff in
>> your editor, but then accidentally also include it in the final comm=
it
>> message. But I can't seem to reproduce that.
>>
>> Can you describe the problem in more detail?
>
> It is exactly as you described. I'll try in other systems.

Guess in the dark... by any chance are you enabling color unconditional=
ly?
