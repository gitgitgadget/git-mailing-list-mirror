From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 07:15:12 +0100
Message-ID: <492B97F0.5000409@morey-chaisemartin.com>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Tue Nov 25 07:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4rH9-0007qo-Fb
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 07:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbYKYGSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2008 01:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYKYGSk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 01:18:40 -0500
Received: from 30.mail-out.ovh.net ([213.186.62.213]:56596 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750828AbYKYGSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 01:18:39 -0500
Received: (qmail 8754 invoked by uid 503); 25 Nov 2008 06:18:21 -0000
Received: from unknown (HELO mail423.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 25 Nov 2008 06:18:21 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 25 Nov 2008 06:18:36 -0000
Received: from agrenoble-152-1-46-35.w82-122.abo.wanadoo.fr (HELO ?192.168.10.203?) (devel@morey-chaisemartin.com@82.122.134.35)
  by ns0.ovh.net with SMTP; 25 Nov 2008 06:18:35 -0000
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <900638.56188.qm@web37904.mail.mud.yahoo.com>
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 11005390115062074950
X-Ovh-Remote: 82.122.134.35 (agrenoble-152-1-46-35.w82-122.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101647>

I guess you could export the public one through git daemon and/or your
web server, and access your private tree through SSH.
This way you ensure only authentificated people will be able to clone
your private tree.

---
Nicolas Morey-Chaisemartin



Gary Yang a =E9crit :
> Do I have to create two git servers? One is for public to download th=
e released code. For example: gitpub.mycompany.com:/pub/linux/kernel. g=
itpub.mycompany.com is accessible to public. Another is for internal de=
velopment. For example: gitdev.mycompany.com:/dev/linux/kernel. gitdev.=
mycompany.com is only accessible to our development team. I push code f=
rom gitdev.mycompany.com:/dev/linux/kernel to gitpub.mycompany.com:/pub=
linux/kernel once we completed our development. Is this the only way to=
 do it?=20
>
>
> --- On Mon, 11/24/08, Gary Yang <garyyang6@yahoo.com> wrote:
>
>  =20
>> From: Gary Yang <garyyang6@yahoo.com>
>> Subject: How to hide a git repository?
>> To: git@vger.kernel.org
>> Date: Monday, November 24, 2008, 4:32 PM
>> We have two repositories, one is /pub/git/dev/linux/kernel,
>> another is /pub/git/pub/linux/kernel. The
>> /pub/git/pub/linux/kernel is open to public for people to
>> download released code. /pub/git/dev/linux/kernel is used
>> for our development. We would like to hide
>> /pub/git/dev/linux/kernel from public. How to do it?
>>
>> Why we want to hide /pub/git/dev/linux/kernel from public?
>> We work on our development at /pub/git/dev/linux/kernel. We
>> push our released code to /pub/git/pub/linux/kernel from
>> /pub/git/dev/linux/kernel once we completed our development.
>>  We do not want people to download code from
>> /pub/git/dev/linux/kernel since it is not stable. =20
>>
>>
>>
>>
>>
>>
>>      =20
>> --
>> To unsubscribe from this list: send the line
>> "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at=20
>> http://vger.kernel.org/majordomo-info.html
>>    =20
>
>
>      =20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>  =20
