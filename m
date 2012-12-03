From: =?UTF-8?B?QWxmb25zbyBNdcOxb3otUG9tZXIgRnVlbnRlcw==?= 
	<alfonso.munozpomer@vti.bund.de>
Subject: =?UTF-8?B?UmU6IFVidW50dTogZ2l0d2ViIGFsd2F5cyBsb29rcyBmb3IgcHJvamU=?=
 =?UTF-8?B?Y3RzIGluIC92YXIvY2FjaGUvZ2l0ICjigJw0MDQgLSBubyBwcm9qZWN0cyBmb3U=?=
 =?UTF-8?B?bmTigJ0p?=
Date: Mon, 03 Dec 2012 18:10:56 +0100
Message-ID: <50BCDD20.1050709@vti.bund.de>
References: <loom.20121129T145320-133@post.gmane.org> <20121129182826.GB17309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Dec 03 18:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfZmD-0003uN-R3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 18:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab2LCRZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2012 12:25:37 -0500
Received: from fermat.it.vti.bund.de ([134.110.5.32]:37232 "EHLO
	fermat.it.vti.bund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab2LCRZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 12:25:36 -0500
X-Greylist: delayed 878 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2012 12:25:36 EST
Received: from localhost (localhost [127.0.0.1])
	by fermat.it.vti.bund.de (Postfix) with ESMTP id 2B1AE118809B
	for <git@vger.kernel.org>; Mon,  3 Dec 2012 18:10:54 +0100 (CET)
X-Virus-Scanned: Checked at fermat.it.vti.bund.de: No virus found.
Received: from [192.168.1.105] (unknown [134.110.105.105])
	by fermat.it.vti.bund.de (Postfix) with ESMTPSA id 02C2A23D006F
	for <git@vger.kernel.org>; Mon,  3 Dec 2012 18:10:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121129182826.GB17309@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211047>

Thank you very much for the clarification. Noticing how this wasn=E2=80=
=99t=20
documented anywhere I had the feeling that I was missing something.

On Thu 29 Nov 2012 19:28:26 CET, Jeff King wrote:
> On Thu, Nov 29, 2012 at 01:55:57PM +0000, Alfonso Mu=C3=B1oz-Pomer Fu=
entes wrote:
>
>> I=E2=80=99ve discovered this weird behaviour in gitweb and documente=
d a workaround in
>> StackOverflow:
>> http://stackoverflow.com/questions/13609475/ubuntu-gitweb-always-loo=
ks-for-projects-in-var-cache-git-404-no-projects-f
>>
>> Basically, the variable $projectroot in gitweb.cgi in the beginning =
is reset to
>> the system default value in git_get_projects_list, when it is declar=
ed again.
>>
>> Is this a known bug? Or am I missing something?
>
> I think the analysis in that stack overflow post is wrong. The use of
> "our" in git_get_projects_list is not the culprit.
>
> The problem is that one should not edit gitweb.cgi directly; its
> built-in defaults (which you are tweaking) are overridden by
> /etc/gitweb.conf, which is shipped by the Ubuntu package. You should
> be making your changes in the config file, not the CGI script.
>
> -Peff

--
Alfonso Mu=C3=B1oz-Pomer Fuentes
Johann Heinrich von Th=C3=BCnen-Institut
Bundesforschungsinstitut f=C3=BCr L=C3=A4ndliche R=C3=A4ume, Wald und F=
ischerei
Institut f=C3=BCr Forstgenetik
Sieker Landstrasse 2
22927 Grosshansdorf

Telefon: +49 (0)4102/696-145
=46ax:     +49 (0)4102/696-200
Email:   alfonso.munozpomer@vti.bund.de
Web:     http://www.vti.bund.de
