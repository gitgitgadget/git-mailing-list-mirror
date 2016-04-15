From: =?UTF-8?Q?Albin_Otterh=c3=a4ll?= <gmane@otterhall.com>
Subject: Re: 'git mv' doesn't move submodule if it's in a subdirectory
Date: Fri, 15 Apr 2016 21:39:39 +0200
Message-ID: <nerg27$t94$1@ger.gmane.org>
References: <5710A2D3.8090003@otterhall.com>
 <CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:45:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9g5-0005Bq-VF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbcDOTpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 15:45:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:46385 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbcDOTpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:45:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ar9fu-00055M-Bu
	for git@vger.kernel.org; Fri, 15 Apr 2016 21:45:06 +0200
Received: from h34n19-sus-a12.ias.bredband.telia.com ([217.212.210.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 21:45:06 +0200
Received: from gmane by h34n19-sus-a12.ias.bredband.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 21:45:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: h34n19-sus-a12.ias.bredband.telia.com
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291647>

On 2016-04-15 19:18, Stefan Beller wrote:
> On Fri, Apr 15, 2016 at 1:14 AM, Albin Otterh=C3=A4ll <gmane@otterhal=
l.com> wrote:
>> I've a submodule located in a subdirectory
>> ({git_rep}/home/{directory}/{submodule}), and I wanted to move the w=
hole
>> directory up a level ({git_rep}/{directory}/{submodule}). But when I
>> used 'git mv {directory} ../' the '.gitmodule' file didn't get modif=
ied.
>>
>> Best regards,
>> Albin Otterh=C3=A4ll
>=20
> Thanks for the bug report!
> Which version of Git do you use? (Did you try different versions?)
>=20

I'm using 2.8.0 (on an Arch system). Haven't tested on any other versio=
n.
