From: Dave Abrahams <dave@boostpro.com>
Subject: Re: git-svn dying unceremoniously
Date: Wed, 13 Apr 2011 10:27:55 -0400
Message-ID: <BANLkTincypeToMmKWYZmp26Y-3wP6bt5Yw@mail.gmail.com>
References: <m2fwpov47e.wl%dave@boostpro.com> <20110412021202.GA17114@elie>
 <201104120850.47331.andres@anarazel.de> <BANLkTikeCagEiN_xU4B+TE=-9esQjWh0pw@mail.gmail.com>
 <BANLkTinnRwas8VSn4p+NRvrwxnVSwBRc1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andres Freund <andres@anarazel.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 16:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA13O-00066e-AF
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 16:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab1DMO2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 10:28:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58319 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab1DMO2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 10:28:15 -0400
Received: by vws1 with SMTP id 1so473529vws.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 07:28:15 -0700 (PDT)
Received: by 10.52.108.70 with SMTP id hi6mr1264556vdb.1.1302704895101; Wed,
 13 Apr 2011 07:28:15 -0700 (PDT)
Received: by 10.52.163.8 with HTTP; Wed, 13 Apr 2011 07:27:55 -0700 (PDT)
X-Originating-IP: [207.172.223.249]
In-Reply-To: <BANLkTinnRwas8VSn4p+NRvrwxnVSwBRc1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171459>

On Wed, Apr 13, 2011 at 8:46 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> On Tue, Apr 12, 2011 at 6:02 PM, Dave Abrahams <dave@boostpro.com> wr=
ote:
>> I managed to get a lot farther with
>>
>> =A0 while ! git svn fetch ; do sleep 1 ; done
>>
>> But eventually I exceeded my disk quota:
>>
>> error: bad index file sha1 signature
>> fatal: index file corrupt
>> write-tree: command returned error: 128
>>
>
> I've run into this in my git-svn clones as well. It happened once las=
t
> year. I tried this trick I found googling around:
>
> rm -f .git/index
> git read-tree --reset HEAD
> git status
>
> .. but it didn't help. I ended up re-doing the git svn clone. Since
> then it has worked fine.

Yeah, I'm redoing mine as well.  It'll probably "only" take another 24
hours to finish, but at least it doesn't seem to be getting stuck!

Thanks, all

--=20
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
