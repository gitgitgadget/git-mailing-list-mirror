From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 08:59:23 +0200
Message-ID: <vpqa9b9rj1w.fsf@anie.imag.fr>
References: <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
	<53588713347b7_59ed83d308cf@nysa.notmuch>
	<CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
	<53588f448d817_59ed83d3084e@nysa.notmuch>
	<CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
	<5358bae8ab550_1f7b143d31037@nysa.notmuch>
	<877g6fb2h6.fsf@fencepost.gnu.org>
	<5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
	<20140424134106.GA27035@thunk.org>
	<CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
	<20140424154717.GB7531@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 25 08:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wda6n-0003h6-8O
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 08:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbaDYG7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 02:59:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33851 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbaDYG7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 02:59:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3P6xNmq014281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Apr 2014 08:59:23 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3P6xN51024266;
	Fri, 25 Apr 2014 08:59:23 +0200
In-Reply-To: <20140424154717.GB7531@thunk.org> (tytso@mit.edu's message of
	"Thu, 24 Apr 2014 15:47:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Apr 2014 08:59:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3P6xNmq014281
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399013963.87881@B0lSAMMeFG6WfEpfNKVdjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247034>

tytso@mit.edu writes:

> On Thu, Apr 24, 2014 at 05:00:13PM +0200, Stefan Beller wrote:
>> > I don't even think we need to query the user to fill out all of the
>> > fields.  We can prepopulate a lot of the fields (name, e-mail address,
>> > etc.) from OS specific defaults that are available on most systems ---
>> > specifically, the default values we would use the name and e-mail
>> > address are not specified in a config file.
>> 
>> Please don't. Or you end up again with Commiters like sb@localhost,
>> sbeller@(None) or alike. I mean it's just one question once you setup
>> a new computer, so I'd really like to see that question and then
>> answer myself (at university/employer I might put in another email
>> address than at home anyway, and I'm sure my boxes have no sane
>> defaults)
>
> But that's no worse than what we have today.

It is. Currently, Git displays a very big and scary warning when you use
commit and Git had to guess your identity.

If you explicitly fill-in the config file with guessed values, then Git
will have no way to know if the config values are real or guessed.

OTOH, a prompt with a default value (i.e "type 'return' to get the
default") would make sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
