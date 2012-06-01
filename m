From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: git-smart-http reject push
Date: Fri, 01 Jun 2012 08:52:58 +0200
Message-ID: <4FC866CA.1080203@intland.com>
References: <4FC7D6CE.30802@intland.com> <CAMK1S_iAxdTg04ctZMUKAyoBRGT=w8rp2dTMDFvmpW_McPP-hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jun 01 08:53:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaLja-0000kW-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 08:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab2FAGxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 02:53:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52246 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab2FAGxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 02:53:10 -0400
Received: from [192.168.1.101] (92-249-245-147.pool.digikabel.hu [92.249.245.147])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MGoVt-1Sno8K0bdh-00DWzg; Fri, 01 Jun 2012 08:53:09 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <CAMK1S_iAxdTg04ctZMUKAyoBRGT=w8rp2dTMDFvmpW_McPP-hQ@mail.gmail.com>
X-Provags-ID: V02:K0:LqMhlAgeYXdIc0w3HdmHNmq4iLFQG3kjUVzNWU6vfTm
 PEhfjpSHy/QuSptOuZWx8UTUFSm0wAUTYxiekMJRoHP/tv1+i6
 Me3VkrESrGhRDVu44oFRIHZnfpJWZbKMqRYahzFwAL8RsvVq1T
 MnnZd6K4e17kTfVoJXKHJR8U6sp//7xr0V7PIIoycI8XFWAVMj
 1InR805xszaEdjSSPolJXQaQXe8S3o7HwnFAg5W14i/iOof58q
 yZ5D4VbtAu7sjCAe2lzY0jyknvshZRiNH+PvpboAProyGKb4Xl
 /gY/5XOWLKsG+4sRWMHP2mFlZWhomf3PAk84ZjOdujcJk2jgSM
 Z2D+VsO/d152Ona2J3fE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198956>

Thanks for the answers!

=C3=81kos

2012.06.01. 5:53 keltez=C3=A9ssel, Sitaram Chamarty =C3=ADrta:
> On Fri, Jun 1, 2012 at 2:08 AM, Tajti =C3=81kos<akos.tajti@intland.co=
m>  wrote:
>> Dear List,
>>
>> we wrote a servlet that is basically a proxy for git-http-backend. W=
e want
>> to control who can create a new branch. Is there a way to reject a p=
ush that
>> would create a new branch (without using hooks)?
> Not sure what else your servlet does or how it affects things but
> gitolite has controls to prevent branches being created (among many
> many other things, limited mostly by ones imagination!).
>
> Gitolite is normally used with ssh but it has been tested with smart
> http also.  It itself acts as a proxy for git-http-backend, inspectin=
g
> the URI and QUERY_STRING and such animals to decode some things, whil=
e
> the rest happens via a special update hook that is installed in each
> repo that it controls.
>
> (Specifically, the branch create check is done there, not in the part
> that is proxying the git-http-backend process.  You probably know tha=
t
> the update hook is invoked by git itself).
>
> Sitaram
