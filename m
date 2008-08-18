From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: SeLinux integration
Date: Mon, 18 Aug 2008 15:04:54 +0200
Message-ID: <20080818130454.GA908@atjola.homenet>
References: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de> <48A93696.6010500@jaeger.mine.nu> <1219060960.13808.20.camel@desktop.local.neuhalfen.name> <48A96F51.6090404@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Neuhalfen <JensNeuhalfen@gmx.de>, git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Aug 18 15:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV4Qs-0003ic-Ns
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 15:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYHRNE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbYHRNE6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 09:04:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:53388 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752031AbYHRNE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 09:04:58 -0400
Received: (qmail invoked by alias); 18 Aug 2008 13:04:56 -0000
Received: from i577BA258.versanet.de (EHLO atjola.local) [87.123.162.88]
  by mail.gmx.net (mp003) with SMTP; 18 Aug 2008 15:04:56 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX182CUsCt+s22Tg4xNczWq0tFHIz221C1n4DvllaZU
	DhHesGJh7aIBDZ
Content-Disposition: inline
In-Reply-To: <48A96F51.6090404@jaeger.mine.nu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92704>

On 2008.08.18 14:47:13 +0200, Christian Jaeger wrote:
> Jens Neuhalfen wrote:
>> The repository is my current development repository which, naturally
>> (?), is based on the 'blessed' repository. My understanding of git
>> was, that anyone with a copy of the blessed git repository can 'pull=
'
>> from my repository and gets my branches with git transmitting just m=
y
>> changes over the net. Then he/she/it can switch to 'my' branch and
>> test the policy/init-script.
>>
>> Did I get something wrong there? I thought that this is a/the normal=
=20
>> way of using git.  =20
>
> Well I'm sure you could use it this way; but check for yourself, if y=
ou =20
> start gitk on your repository, one has to first figure out where to f=
ind =20
> you work, i.e. one has to follow the right parent in your commits to =
see =20
> all of them; it's certainly possible but I guess not very inviting fo=
r =20
> people who just want to *look* at your work (as opposed to simply try=
 it =20
> out). I'll readily admit that I just wanted to look, not try it out. =
But =20
> maybe I'm not the only one with this as his/her primary aim.

Well, instead of using --reference, I would just add a "selinux" remote
to my existing git.git repo, fetch the stuff and then:

gitk origin/master..selinux/master

It's still not "pretty", but quite usable. And as far as I'm concerned,
it's kinda obvious that the git-selinux repo is based on the git.git
repo, so I wouldn't say that you're required to mention that explicitly=
=2E

Bj=F6rn
