From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Fri, 21 Dec 2007 17:40:48 +0900
Message-ID: <200712210845.lBL8jjME026405@mi0.bluebottle.com>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	<20071218154211.GB12549@alea.gnuu.de>
	<7vabo7y762.fsf@gitster.siamese.dyndns.org>
	<200712202145.lBKLj7Fu015050@mi0.bluebottle.com>
	<7v4pedov6c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 09:42:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5dSJ-0005Af-Is
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 09:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXLUIlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 03:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbXLUIlo
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 03:41:44 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:46074 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbXLUIln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 03:41:43 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBL8jjME026405
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 00:45:45 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=JB6R6tVAsJiiCBLIjxIOZrhB0lOnznxajBPQYI510G4hGED5GVoq5sNwDLqV/eBEd
	kcy+3j5VpdPT4z/WstH3H5jFL8QGBSdxn3gHQxh5qmF/cHejafcPrf3wu0bKppU
Received: from nanako3.mail.bluebottle.com ([211.140.192.186])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBL8fQTi022709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Dec 2007 00:41:38 -0800
In-Reply-To: <7v4pedov6c.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <4cca41b969e50193b7859277b9cd9b5a>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69046>

Quoting Junio C Hamano <gitster@pobox.com>:

> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nan=
ako3@bluebottle.com> writes:
>
>> How about making this behavior configurable?
>
> First, as a general principle, I'd like to avoid having commands that
> changes their behaviour drastically depending on who the user is.  It
> makes it harder for people experienced a bit more than totally new to
> help others.  If they are truly experts and are familiar about the
> configuration stash.quick, then they will be fine, but others would s=
ay
> "Well, it works for me -- 'git stash' itself won't stash but list.  W=
hy
> isn't it working for you, I don't know" and scratch head.

I see.  I usually am not the person who helps but am the=20
person who is helped in such a situation, and did not=20
consider this issue.

> Having said that, I reserve rights to change my mind later and start
> liking this approach as a compromise.

I will change the patch as you suggested and resubmit.  Let's=20
see if I can change your mind (^_^).

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
