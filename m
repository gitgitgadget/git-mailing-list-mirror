From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Enabling scissors by default?
Date: Tue, 08 Jan 2013 18:25:22 -0500
Message-ID: <50ECAAE2.2020507@ubuntu.com>
References: <50EC92C6.7090509@ubuntu.com> <7vvcb7b8lc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 00:25:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsiYE-0003Hi-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 00:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab3AHXZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 18:25:25 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39588 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab3AHXZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 18:25:24 -0500
X-Authority-Analysis: v=2.0 cv=VZd1zSV9 c=1 sm=0 a=C56BoFkcj+OI1kjAe8jE5A==:17 a=MtVMNMWb1ewA:10 a=uBsBa1gr-CYA:10 a=mJ8kdMDUam4A:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=ehUGrGVIPMEA:10 a=QfKxxUxMAAAA:8 a=F38jllyfqJlT2L5tvJoA:9 a=wPNLvfGTeEIA:10 a=C56BoFkcj+OI1kjAe8jE5A==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 142.196.87.46
Received: from [142.196.87.46] ([142.196.87.46:51017] helo=[192.168.1.10])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id CC/6C-05345-2EAACE05; Tue, 08 Jan 2013 23:25:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vvcb7b8lc.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213014>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/08/2013 05:42 PM, Junio C Hamano wrote:
> It is very easy to miss misidentification of scissors line; as a 
> dangerous, potentially information losing option, I do not think
> it should be on by default.

I suppose if it only requires one instance of >8 or <8 and one -, it
might be *slightly* dangerous, but if it required a slightly longer
minimum line length, it would be pretty darn unlikely to get triggered
by accident, and of course, is easily disabled.

> Another reason (and this is the original one) why it is not
> enabled is to discourage the contributors from overusing scissors
> -- >8 -- line.  If you always have to write too much stuff before
> the proper explanation of your patch, so that the integrator has to
> use -c option all the time, you are explaining your patches wrong.

I often see patches being tweaked in response to feedback and
resubmitted, usually with a description of what has changed since the
previous version.  Such descriptions don't need to be in the change
log when it is finally applied and seem a perfect use of scissors.

Usually such version to version descriptions are put in a cover
letter, but if you are only submitting a single patch instead of an
entire series, using a cover letter seems silly when you could just
put the comments in one email and clearly mark them as not needing to
go into the final changelog.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQ7KriAAoJEJrBOlT6nu755UkIALIT3T5yHH5i+0HOrXLlXzQR
+S2jJfFZ8Kcc+kleiEJ3uLFVGTLMpRyjJFKceOuB4/TdJFUivrYJHWJxcKmW8WzK
BJKZOjt/jv9r8Qt/AB7KA45S7awfQnOWkg6KQlJa1IM0nUPbo4upgMlWar9l7vjz
Hkr7geuHY4fsVUJ7R0rYPcT3pue8ywsT4a9o/ocstfXmC05IrLKQtzO4TuvfiaTb
yBG+rAPKz36zfxCN5NyKExZO6v/LnCKym/PH4a6wYIeTUz1EvuaPy5lQOo6ORQ4h
xbSyBRDPN4yiVgNXfSQmGKwd9XPqs6h8Z0q3X5mGZyOXurw0JFRJlJ3v8hHIvqg=
=Rn7z
-----END PGP SIGNATURE-----
