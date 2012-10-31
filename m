From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v6 2/3] completion: add new __gitcompadd helper
Date: Wed, 31 Oct 2012 15:15:20 +0100
Message-ID: <20121031141520.GB26072@goldbirke>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
 <1350870342-22653-3-git-send-email-felipe.contreras@gmail.com>
 <20121030225839.GO12052@goldbirke>
 <CAMP44s0dctpjobNNRTOFcX4ir+nzenTZMNWFbEvBa-QU93psbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZ5h-00087T-WA
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935655Ab2JaOQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 10:16:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:60425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935623Ab2JaOQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:16:07 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MMHcb-1TSBcr3GOb-007rhn; Wed, 31 Oct 2012 15:15:21 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s0dctpjobNNRTOFcX4ir+nzenTZMNWFbEvBa-QU93psbA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:SUXiLtOGKdpKnbvvM9A133jJ04fMg34acaVwa6MHCpl
 HIbcIAHNrbwFq1N0qhkt6cVur72IHDBcScVB5Cqvs6C8E+10oH
 6xca6Rda1wjc76y1X2ytrHSGEbqrD8iap0PPxa/ZWtsD6tYNy1
 vTz5iknVdD/F+vSGs8HNnkBpZZUDcCC+wxqWxpdqy8XadStC+t
 H4l/QTsBmkD2EWV7t47iXCUA48AD/gT+r3DfMHpMTtuEgtLfk9
 OrkTJ3UTmuhHy+ovhwjn4Z+BIeC46r/qep0ejVniSVNKdhlyqo
 YVtUtgUVP0mlxgnZTIfd/+SE4mGgUXpsHrNqqOcg5aT16ov6+b
 PNZdjhSIsUwdwde3xBOHH8ZW9BeezWZjT95jzqmwK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208822>

On Wed, Oct 31, 2012 at 12:05:34AM +0100, Felipe Contreras wrote:
> On Tue, Oct 30, 2012 at 11:58 PM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
> > On Mon, Oct 22, 2012 at 03:45:41AM +0200, Felipe Contreras wrote:
> >> The idea is to never touch the COMPREPLY variable directly.
> >>
> >> This allows other completion systems override __gitcompadd, and do
> >> something different instead.
> >>
> >> Also, this allows the simplification of the completion tests (sepa=
rate
> >> patch).
> >
> > This doesn't apply anymore, does it?  The mentioned simplification =
is
> > done in the other series.
>=20
> Yeah, but you mentioned you didn't like all the COMPREPLY=3D() change=
s
> and it might be time to get rid of them.
>=20
> So this series supersedes that one.

COMPREPLY=3D() has nothing to do with it.  My point is that there is no
"separate patch" that performs the alleged simplification made
possible by this patch, therefore that sentence should have been
removed from the log message for the resubmission.
