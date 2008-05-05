From: Wincent Colaiuta <win@wincent.com>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 5 May 2008 12:33:25 +0200
Message-ID: <C836878F-7163-4AE2-91A4-E6A0F0AF3914@wincent.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <86k5i9d91w.fsf@blue.stonehenge.com> <20080505065259.GA25070@old.davidb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon May 05 12:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsy1b-0005Zg-B5
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 12:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYEEKdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 06:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYEEKdj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 06:33:39 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:45382 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYEEKdj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 06:33:39 -0400
Received: from cuzco.lan (228.pool85-53-21.dynamic.orange.es [85.53.21.228])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m45AXU5K007820
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 5 May 2008 06:33:32 -0400
In-Reply-To: <20080505065259.GA25070@old.davidb.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81266>

El 5/5/2008, a las 8:52, David Brown escribi=F3:
> On Sun, May 04, 2008 at 03:00:11PM -0700, Randal L. Schwartz wrote:
>
>> Ahh, oddly enough, it does exactly the same on HFS+, but *not* UFS, =
=20
>> which is
>> why I hadn't noticed it yet, since all of my things I mirror are on =
=20
>> my UFS
>> partition, just in case they have case-colliding names.
>
> Anyone know if 'case sensitive' HFS+ does name mangling?  Perhaps =20
> ZFS can
> also be formed as case sensitive.

I believe case-sensitive HFS+ also mangles names.

I for one am pretty disappointed that Apple has chosen to bring across =
=20
this undesirable behaviour from their legacy file system to a =20
completely new one, when this would have been a perfect opportunity =20
for them to break with the bad design decisions of the past. It's =20
still pre-release, of course, so I guess there's still hope that their =
=20
final version might not preserve this flaw.

Wincent
