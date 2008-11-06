From: Yang Zhang <yanghatespam@gmail.com>
Subject: Re: How to rebase for git svn?
Date: Thu, 06 Nov 2008 15:05:46 -0500
Message-ID: <49134E1A.9090908@gmail.com>
References: <4911EF4C.8030703@gmail.com> <20081106095500.GA9587@untitled> <bd6139dc0811060215j1ad7ee0ahd0b568283da06cb@mail.gmail.com> <20081106102425.GA4192@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 06 21:07:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyB8F-0007J8-Uh
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 21:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbYKFUFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 15:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYKFUFu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 15:05:50 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:43612 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYKFUFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 15:05:49 -0500
Received: by qw-out-2122.google.com with SMTP id 3so506004qwe.37
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FrAmKAqPaPYdnv4EyTdyDsUfPFcNHhPZPNL/NzIK84k=;
        b=UWLfdLdQdSdMu6JUzymwJNSi7imn58tCcQ9D5iZqwgEfUq1Y63PNXVYz4rQ7U7XffM
         zsKpQOGvnHw/PET5h8L36xmVdygRuNxo8RJGEc6EnQ/OIMNJ9Dvzpqfq/ED+BHfQjeff
         Rpr17qsSotExO3qbsRVW3bb+4BixYsYSUzXb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZuPxx3ATeH+GF+2aOD36DlRoHPdMisC5IS508U5XRSXrFqKQOslx/Yxgx7PtANNEjQ
         ccRLHl/oRK7cElraikNT57+WVh7OM7SjNcLbZ0zXU704bPVTRoPWQDRYzvYmDzRIodlm
         W3/wuCQWY1HAkrmBQHfu8Nsb1BT8dNhBQ/bd4=
Received: by 10.215.12.6 with SMTP id p6mr2863184qai.282.1226001947689;
        Thu, 06 Nov 2008 12:05:47 -0800 (PST)
Received: from harvard.csail.mit.edu ( [18.26.1.77])
        by mx.google.com with ESMTPS id 5sm4777175yxt.1.2008.11.06.12.05.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Nov 2008 12:05:45 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081106102425.GA4192@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100263>

Bj=F6rn Steinbrink wrote:
> On 2008.11.06 11:15:21 +0100, Sverre Rabbelier wrote:
>> On Thu, Nov 6, 2008 at 10:55, Eric Wong <normalperson@yhbt.net> wrot=
e:
>>> Yang Zhang <yanghatespam@gmail.com> wrote:
>>>> Thanks in advance for any help!
>>> Try passing --rebase or --squash with "git pull" to keep history li=
near
>>> for SVN.
>> Consider doing the following:
>> git config alias.repull "pull --rebase"
>> And then using 'git repull' instead of 'git pull'.
>=20
> Or set branch.<name>.rebase in your config and just use "git pull" ;-=
)
> Setting branch.autosetuprebase might also be useful in that case.
>=20
> You should be careful to make sure that the other side does not lag
> behind WRT svn, though. Otherwise, you end up rebasing commits that
> corresponds to svn revisions. Bad.
>=20
> Bj=F6rn

git pull --rebase doesn't seem to be working either....

http://assorted.svn.sourceforge.net/viewvc/assorted/sandbox/trunk/src/g=
it/gitsvn.bash?revision=3D1064&view=3Dmarkup
--=20
Yang Zhang
http://www.mit.edu/~y_z/
