From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Tue, 07 Apr 2009 08:01:17 -0700
Message-ID: <op.ur0uofkh4oyyg1@localhost.localdomain>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com> <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <871vs5kjfw.fsf@krank.kagedal.org> <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
 <87skkligzb.fsf@krank.kagedal.org> <7v8wmd46p9.fsf@gitster.siamese.dyndns.org>
 <op.ur0czewh4oyyg1@localhost.localdomain> <878wmcj1fs.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "David Aguilar" <davvid@gmail.com>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"markus heidelberg" <markus.heidelberg@web.de>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	"Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 17:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrCpj-0003lx-TF
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 17:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbZDGPBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 11:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZDGPBv
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 11:01:51 -0400
Received: from spider.alvarezp.com ([66.150.225.106]:44216 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZDGPBv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 11:01:51 -0400
Received: from localhost.localdomain (201.160.155.130.cable.dyn.cableonline.com.mx [201.160.155.130])
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id n37F1NYr007929
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Tue, 7 Apr 2009 08:01:25 -0700
In-Reply-To: <878wmcj1fs.fsf@krank.kagedal.org>
User-Agent: Opera Mail/10.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115961>

On Tue, 07 Apr 2009 01:46:47 -0700, David K=E5gedal <davidk@lysator.liu=
=2Ese> wrote:

> "Octavio Alvarez" <alvarezp@alvarezp.ods.org> writes:
>
>> The difference between git diff and git reset is that git diff shoul=
d =20
>> take
>> a range of trees, not a range of commits as parameters. OTOH, git re=
set
>> doesn't know or care about trees, it needs commits.
>
> No, git diff doesn't take a range. It takes two trees (including the
> work "tree" and the index "tree"). The A..B syntax is nonsense for gi=
t
> diff, but I believe it supported for historical reasons.
>

Thanks.

I correct by s/range of// but the case persists.
