From: Aaron Digulla <digulla@hepe.com>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 13:09:24 +0200
Message-ID: <49DF28E4.3070609@hepe.com>
References: <loom.20090410T084314-918@post.gmane.org> <200904101114.07385.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 13:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsFFe-0000PU-F2
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 13:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935926AbZDJLsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935907AbZDJLso
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 07:48:44 -0400
Received: from sebigbos.hepe.com ([78.47.144.89]:43590 "EHLO www.hepe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934846AbZDJLsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 07:48:43 -0400
X-Greylist: delayed 2350 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2009 07:48:42 EDT
Received: from [194.230.154.168] (helo=[192.168.66.2])
	by www.hepe.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <digulla@hepe.com>)
	id 1LsEbw-0003Fk-Gz; Fri, 10 Apr 2009 13:09:29 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200904101114.07385.fge@one2team.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116253>

=46rancis Galiegue wrote:
> Le vendredi 10 avril 2009, vous avez =E9crit :
>> Hello,
>>
>> I need a way to safely synchronize data between several places using=
 an=20
> unsafe
>> storage (USB stick, Internet drive). So my question is: How much wor=
k would=20
> it
>> be to patch GIT to encrypt all files in the repository using AES-256=
?
>>
>> I'm aware that this leaves an issue unresolved (where should I store=
 the
>> password so that GIT doesn't have to ask for it all the time?) but o=
ne step=20
> at a
>> time, please :)
>>
>> Regards,
>>
>=20
> Why don't you just create an archive and encrypt that archive, instea=
d of=20
> encrypting every file?

Because I don't want to loose the change history.

> Also, what are the target systems?

Linux and Windows.

Regards,

--=20
Aaron "Optimizer" Digulla a.k.a. Philmann Dark
"It's not the universe that's limited, it's our imagination.
=46ollow me and I'll show you something beyond the limits."
http://www.pdark.de/                 http://blog.pdark.de/
