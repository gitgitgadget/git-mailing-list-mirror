From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 16:23:59 +0200
Message-ID: <87bpdamem8.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<20100423093943.GB30346@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Bjoern Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 16:24:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Jnz-00052u-99
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 16:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab0DWOYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 10:24:06 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39908 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0DWOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 10:24:02 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C1AC614E1D27C;
	Fri, 23 Apr 2010 16:24:00 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5JnU-0004gS-00; Fri, 23 Apr 2010 16:24:00 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5JnU-0004Ec-0z; Fri, 23 Apr 2010 16:24:00 +0200
In-Reply-To: <20100423093943.GB30346@atjola.homenet> ("Bjoern Steinbrink"'s
	message of "Fri, 23 Apr 2010 11:39:43 +0200")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX19nWKfSG4yXfx4YGOYUp8atAwi0e1D5YLUyVDC0
	4dL8XE1WAAdHHEacilGEoztcW5ljKQVKwGV7pqjWTaDvYO/xFn
	uCcoU1UIU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145617>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2010.04.22 22:37:05 +0200, Goswin von Brederlow wrote:
>> Is there a risk? You do get an editor with all the files affected li=
sted
>> giving you a big fat warning what you are about to commit.
>
> And if I happen to have two unrelated changes in a single file that's
> worth nothing at all. For example, I might have changed the condition
> that causes some message to be shown, and discovered a typo in the
> message itself and fixed it along the way. That needs two commits, bu=
t
> the list of modified files doesn't tell that.
>
> Only "commit -v" would help there, showing the diff in the editor. Bu=
t
> reviewing the diff in the editor is a PITA and I lose the whole revie=
w
> progress if I find something I don't want to commit and have to abort=
=2E
> Using "git add [-i|-p|-e]", git helps me to keep track of the changes=
 I
> already reviewed and decided to commit.
>
> Bj=F6rn

Then you would keep doing that or use git commit --interactive. The
suggested change would not affect you at all either way.

MfG
        Goswin
