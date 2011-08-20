From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection
 threshold.
Date: Sat, 20 Aug 2011 07:19:56 -0400
Message-ID: <20110820111956.GA5893@arf.padd.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
 <1313706054-11740-2-git-send-email-vitor.hda@gmail.com>
 <7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
 <CAOpHH-VsoOSOH6ym2exCH=W4NmuKRw+f53HrwB47YD3u-iDe2w@mail.gmail.com>
 <20110819114719.GB15639@padd.com>
 <CAOpHH-WJWxeTSO5Dy6UR9pJh3w9hQSBuE7O1mY2KDAEsS9OAPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 16:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qum8c-0004k8-JI
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 16:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab1HTOCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 10:02:44 -0400
Received: from honk.padd.com ([74.3.171.149]:56219 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab1HTOCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 10:02:44 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id E11905B60;
	Sat, 20 Aug 2011 07:02:41 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BE2AE31615; Sat, 20 Aug 2011 07:19:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOpHH-WJWxeTSO5Dy6UR9pJh3w9hQSBuE7O1mY2KDAEsS9OAPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179761>

vitor.hda@gmail.com wrote on Fri, 19 Aug 2011 14:51 +0100:
> On Fri, Aug 19, 2011 at 12:47 PM, Pete Wyckoff <pw@padd.com> wrote:
> > I think you have to decide that 1 means 1 in this case.
> > Everything else can mean true. =A0That may suggest that using
> > --bool or --bool-or-int isn't possible in this case.
>=20
> But doing that kind of post-processing would require me to call
> git-config (at least) twice: first to check if it is a number with a
> possible "." in the middle or "%" at the end and a second time with
> the --bool option. I have no problem in doing this, but I think it
> increases the complexity without bringing major advantages.
>=20
> I will use --bool for detectCopiesHarder and will send you the new se=
t
> of patches tonight, unless we decide to also start using it for
> detectCopies and detectRenames.

I was imagining you would not use "--bool", and parse everything
yourself.  But I see your point, and letting "1" mean "-M1" as
opposed to "-M" is probably okay too.  I'm not particularly
worked up about which way that goes.

		-- Pete
