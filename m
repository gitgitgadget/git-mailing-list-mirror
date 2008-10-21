From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Tue, 21 Oct 2008 09:24:12 +0200
Message-ID: <48FD839C.1070604@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu> <48FC55F9.3060509@op5.se> <48FC9927.5030903@jaeger.mine.nu> <48FC9D87.3010303@op5.se> <48FCA1BC.3060300@jaeger.mine.nu> <48FCADA0.4020008@op5.se> <48FCB87B.1080207@jaeger.mine.nu> <7viqrm3n53.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 09:25:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsBcR-0001TV-M5
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 09:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbYJUHYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 03:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYJUHYQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 03:24:16 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:60204 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751660AbYJUHYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 03:24:15 -0400
Received: (qmail 26067 invoked from network); 21 Oct 2008 07:24:12 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 21 Oct 2008 07:24:12 -0000
Received: (qmail 11012 invoked from network); 21 Oct 2008 07:24:12 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 21 Oct 2008 07:24:12 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7viqrm3n53.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98763>

Junio C Hamano wrote:
> Christian Jaeger <christian@jaeger.mine.nu> writes:
>
>  =20
>>> That's partially implemented, I think (google for Nguy (or somethin=
g, I'm
>>> not very god with asian names),
>>>      =20
>> That's not enough information for me to find what you've had in
>> mind. "stump Nguy site:marc.info" doesn't yield a result with Google=
=2E
>>    =20
>
> I think Andreas is referring to nd/narrow topic currently parked in '=
pu'.
>
> $ git log next..36aa66d^2

Thanks. This looks nice.

(It is implementing the partial, or "sparse" as Nguy=E1=BB=85n calls it=
,=20
checkouts. So it seems the more useful of the two ideas is basically=20
already done, at least in the sense of saving space for the checkout. I=
t=20
won't 'move'/'mount' the subdirectory to the top of the working=20
directory if only a subdirectory is wanted, but as I've already realize=
d=20
and written, Git may require a full working directory anyway for=20
interaction with the user during merging, and a symlink can be used=20
instead to 'mount' the subdirectory where the user wants it (if the OS=20
supports that). Straightforward solution.)

Christian.
