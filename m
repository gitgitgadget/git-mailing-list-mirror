From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: About the "git merge" tee-shirt
Date: Tue, 14 Apr 2015 18:27:19 +0200
Message-ID: <vpqd236d6ag.fsf@anie.imag.fr>
References: <vpqr3rnoiq8.fsf@anie.imag.fr> <20150414010505.GE3684@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:27:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi3go-0002vH-V9
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 18:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbbDNQ1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 12:27:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42890 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755594AbbDNQ13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 12:27:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3EGRHb5020967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 18:27:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EGRJpN020172;
	Tue, 14 Apr 2015 18:27:19 +0200
In-Reply-To: <20150414010505.GE3684@peff.net> (Jeff King's message of "Mon, 13
	Apr 2015 21:05:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 14 Apr 2015 18:27:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3EGRHb5020967
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1429633641.39416@60Mzx6azr0O15vvTRbjfeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267145>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 13, 2015 at 10:50:55PM +0200, Matthieu Moy wrote:
>
>> My second guess is that they represent directories.
>> But even then, I can't find which of the tee-shirt's circles represents
>> which directory, and the count doesn't match.
>> 
>> Does anybody have a better explanation? Or is it just a random drawing
>> to say "Git is bigger than it used to be"?
>
> I believe it is "gource"[1] output from 2005 and 2015, tweaked by a
> graphic designer to make it look nicer.

That would match my second guess. I guess the tweaks are what make it
hard to do the actual correspondance (there are 53 circles on the
drawing if I counted correctly, and 156 directory in today's Git for
example). The biggest dirs in number of files today are:

./builtin 99
./t/t5515 128
./t/t4013 144
./Documentation 221
./Documentation/RelNotes 242
. 378
./t 774

The directories at 4e7a2eccc21c902918 (Thu Dec 29 01:31:26 2005 -0800)
were:

./Documentation/technical 2
./mozilla-sha1 2
./arm 3
./ppc 3
./compat 4
./Documentation/howto 8
./templates 12
./debian 14
./t/t4100 14
./t 62
./Documentation 126
. 191

So, t/ would be a nice candidate for the big circle on the left hand
side (small in 2005, but biggest as of now), and ./ would be the one on
its right (used to be biggest, but no longer). Documentation/ is the one
at the top (with subdirs howto/ and technical/ in 2005, and the new
RelNotes/ today). I'm not sure where builtin/ is, it was probably
tweaked too much (it's supposed to be rather big in 2015 and inexistant
in 2005, without subdirs).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
