From: "=?windows-1250?Q?David_Ond=F8ich?=" <david.ondrich@aveco.com>
Subject: Re: QNX support
Date: Wed, 26 Jun 2013 16:36:33 +0200
Message-ID: <7213649B-3168-4089-8592-B8FDE2F2F705@aveco.com>
References: <430B4DD0-B796-4DB2-861D-C1F81302A4D1@aveco.com> <7vmwuxv9ou.fsf@alter.siamese.dyndns.org> <1B04D3EE58602B43B7D34ECC7F9E321E060FA821@SANMAIL04.corp.amo-inc.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Kraai, Matt" <Matt.Kraai@amo.abbott.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 16:41:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urquq-0003ZD-FG
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 16:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab3FZOlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 10:41:44 -0400
Received: from debian.aveco.com ([194.149.122.58]:63367 "EHLO debian.aveco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab3FZOln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 10:41:43 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2013 10:41:42 EDT
Received: from macbook-do-w.aveco.com (MacBook-DO-W.aveco.com [172.16.2.243])
  (AUTH: PLAIN david.ondrich@aveco.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by debian.aveco.com with esmtp; Wed, 26 Jun 2013 16:36:36 +0200
  id 00005C45.51CAFC74.0000D65B
In-Reply-To: <1B04D3EE58602B43B7D34ECC7F9E321E060FA821@SANMAIL04.corp.amo-inc.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229042>

Hi,

sorry for long delay, I was busy on some important project so far. Howe=
ver, we=92ve found out really bad thing recently.

On Feb 21, 2013, at 7:04 PM, "Kraai, Matt" <Matt.Kraai@amo.abbott.com> =
wrote:
> Junio C Hamano writes:
>> "David Ond=F8ich" <david.ondrich@aveco.com> writes:
>>> I've read [1] recently, there's been some QNX port being
>>> initiated. Does that involve also old versions of QNX 4?
>=20
> No, I haven't been working on QNX 4 support.  I've been targeting QNX=
 6.3.2, with a little testing on QNX 6.5.0.  I doubt what I've done wou=
ld work on QNX 4 since it's so different from QNX 6.

It certainly wouldn't work, since there=92s limitation to 48 characters=
 for filename in filesystem =96 it can be beaten up by changes in git i=
ndex / pack / keep mechanism but it requires on-the-fly transformation =
when replicating a repository from / to other place. I've thought we wo=
uld be able to implement such translation but what came up was its cost=
 would be too high. It is definitely doable but for us it's currently t=
he showstopper.

dond