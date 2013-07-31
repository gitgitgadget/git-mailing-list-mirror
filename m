From: Gabriel Jover <gjover@cells.es>
Subject: Re: Help using git subtree
Date: Wed, 31 Jul 2013 08:57:03 +0200
Message-ID: <51F8B53F.7030602@cells.es>
References: <51F78826.1040502@cells.es> <20130730095846.GA19369@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 08:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4QLR-0005hG-8f
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 08:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab3GaG5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 02:57:09 -0400
Received: from berlin.cells.es ([84.89.245.3]:44899 "EHLO berlin.cells.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab3GaG5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 02:57:07 -0400
Received: from post01.cells.es (unknown [84.89.246.164])
	by berlin.cells.es (Postfix) with ESMTP id 6CD36104CA;
	Wed, 31 Jul 2013 08:57:06 +0200 (CEST)
Received: from [84.89.248.4] (pc204.cells.es [84.89.248.4])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by post01.cells.es (Postfix) with ESMTPSA id C3015260053;
	Wed, 31 Jul 2013 08:57:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130730095846.GA19369@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231400>

Al 30/07/13 11:58, En/na Fredrik Gustafsson ha escrit:

>> Git subtree is very convenient to get all the sub-projects into the
>> main-project directory tree
>> and to send back sub-project commits to the corresponding repository=
=2E
>> But I don't understand the work flow very well.
> I haven't used subtree that much however how do you commit to upstrea=
m?
> AFAIK every commit to the subtree must be done in the subtree branch =
and
> then merged back to the "superproject"-branch with a subtree merge.
I use "git subtree pull" and "git subtree push".
AFAIK with subtree all commits are in the same repository, thus one doe=
s=20
not need
to go to the subtree branch to commit. This is one of the advantages of=
=20
subtree.

>> I can add a subtree with a given prefix and pull/push my commits to
>> the repository,
>> but how do I do to pull/push commits from the main-project to the
>> corresponding repository
>> avoiding sub-projects to be sent?
> You don't. A subtree is a subtree in your git-repo and is therefore a
> part of your repository. When you're using subtree that project will =
be
> a part of you project.
I expected that there would be a way to split the main project and push=
 it,
in the same way that one can split one subtree and push it.
If not, this could be a feature request.

>> An other question I have is when will be subtree included in git pac=
kages.
>> I had to compile git from sources in order to get this feature.
>>
> If you're asking when git-subtree will move from contrib/ to core git=
, I
> don't know. That's a decision for Junio. I would argue that it should=
n't
> because submodules can do everything that subtrees are good at and
> git.git should focus on doing one solution well instead of doing the
> same thing in two bad ways. However since git.git already uses a
> subtree-like style for gitk, git-gui, etc.  it doesn't seem like Juni=
o
> agrees with me on this point.
Right, I rephrase: When git-subtree will move from contrib/ to core git=
?

Let me also empathize that I find git-subtree much more convenient than=
=20
sub-modules.
One can work with a single repository as it were a single project, one=20
can commit changes
that affect different sub-projects with just one command, use common=20
tags and branches and so on.

>> Si heu rebut aquest correu per error, us informo que pot contenir in=
formaci=F3 confidencial i privada i que est=E0 prohibit el seu =FAs. Us=
 agrairiem que ho comuniqueu al remitent i l'elimineu. Gr=E0cies.
>> Si ha recibido este correo por error, le informo de que puede conten=
er informaci=F3n confidencial  y privada y que est=E1 prohibido su uso.=
 Le agradecer=E9 que lo comunique a su remitente y lo elimine. Gracias.
>> If you have received  this e-mail by error, please note that it may =
contain confidential and private  information, therefore, the use of th=
is information is strictly forbidden. Please inform the sender of the e=
rror and delete the information received. Thank you.
> Is this really something to have in e-mails to a public list? Some li=
sts
> won't accept this type of e-mails, or simply just ignore you.
>
Don't worry about this signature, it only applies if one receives this=20
e-mail by mistake.

Best regards,

Gabriel

--=20


Si heu rebut aquest correu per error, us informo que pot contenir infor=
maci=F3 confidencial i privada i que est=E0 prohibit el seu =FAs. Us ag=
rairiem que ho comuniqueu al remitent i l'elimineu. Gr=E0cies.
Si ha recibido este correo por error, le informo de que puede contener =
informaci=F3n confidencial  y privada y que est=E1 prohibido su uso. Le=
 agradecer=E9 que lo comunique a su remitente y lo elimine. Gracias.
If you have received  this e-mail by error, please note that it may con=
tain confidential and private  information, therefore, the use of this =
information is strictly forbidden. Please inform the sender of the erro=
r and delete the information received. Thank you.
