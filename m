From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH v2] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 02:42:21 +0200
Message-ID: <6EDE159E-66C2-4CD8-B6D8-9960C681A3FB@joernhees.de>
References: <1374675701-10592-1-git-send-email-dev@joernhees.de> <7vd2q75zoo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, apelisse@gmail.com, felipe.contreras@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 02:42:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V29di-0005Fp-GQ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 02:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3GYAmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 20:42:32 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:43431 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab3GYAm3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 20:42:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id B609EE8C2AA;
	Thu, 25 Jul 2013 02:42:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3wzbR+bsR9SR; Thu, 25 Jul 2013 02:42:22 +0200 (CEST)
Received: from [192.168.1.3] (95-88-55-57-dynip.superkabel.de [95.88.55.57])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id 30648E8C28D;
	Thu, 25 Jul 2013 02:42:22 +0200 (CEST)
In-Reply-To: <7vd2q75zoo.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231123>


On 25 Jul 2013, at 01:02, Junio C Hamano <gitster@pobox.com> wrote:
> Joern Hees <dev@joernhees.de> writes:
>>=20
>> Changing shared_path to ".git/hg/.shared" will solve this problem
>=20
> Here you say "shared" and the code says "share"; which one is
> preferred (I know either would work, but we would want to be
> consistent).
>=20
> I'd vote for "shared", but I do not see a compelling reason to pick
> one over the other so=85?

ok, v3 coming...
