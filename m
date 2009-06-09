From: Junio C Hamano <gitster@pobox.com>
Subject: Re: EasyGit Integration
Date: Tue, 09 Jun 2009 14:36:09 -0700
Message-ID: <7veittjdiu.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<20090609212748.GD13781@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 23:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME8zT-00075o-0E
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 23:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbZFIVgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755749AbZFIVgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 17:36:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65438 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbZFIVgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 17:36:08 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609213611.JLBY25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Tue, 9 Jun 2009 17:36:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1xc91c00M4aMwMQ04xc9jB; Tue, 09 Jun 2009 17:36:10 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=609rUi2NPo9pCix4vm0A:9
 a=wOCZITAad_ks5sdA-uzkLgQHawMA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <20090609212748.GD13781@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Tue\, 9 Jun 2009 23\:27\:48
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121227>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.06.09 11:59:08 -0700, Scott Chacon wrote:
>> * adds 'git resolved' for 'git add', which I hear all the time as
>> being confusing
>
> Is "resolve" a plain alias, like "stage", or smart in deciding which
> files it accepts? My gut feeling is that a plain alias might cause
> trouble again when users get lazy and start to do "git resolve ." and
> wonder why that adds new files.
>
> Iff such a "resolve" command is added, it should IMHO only serve the
> purpose of changing the status of index entries marked as "unstaged",
> and do nothing else that "add" can do.

Very good point (modulo s/unstaged/unmerged/ I think).
