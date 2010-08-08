From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] test-lib: Add support for multiple test prerequisites
Date: Sun, 8 Aug 2010 11:15:12 +0200
Message-ID: <201008081115.12444.j6t@kdbg.org>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com> <1281129565-26124-2-git-send-email-avarab@gmail.com> <20100808015729.GA9284@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 11:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi1yi-0002Cf-H9
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 11:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab0HHJPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 05:15:18 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:39341 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab0HHJPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 05:15:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0D6AFCDF83;
	Sun,  8 Aug 2010 11:15:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B42E419F5C0;
	Sun,  8 Aug 2010 11:15:12 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100808015729.GA9284@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152896>

On Sonntag, 8. August 2010, Jonathan Nieder wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > Change the test_have_prereq function in test-lib.sh to support a
> > comma-separated list of prerequisites. This is useful for tests tha=
t
> > need e.g. both POSIXPERM and SANITY.
> >
> > The implementation was stolen from Junio C Hamano and Johannes Sixt=
,
> > the tests and documentation were not.
>
> I think you can sell it better. :)
>
> 	From: Johannes Sixt <j6t@kdbg.org>
> 	Subject: test-lib: Allow tests with multiple prerequisites

I think the patch has changed sufficiently, particularly in the subtle =
points,=20
that authorship should not be attributed to me anymore.

Thanks for your review!

-- Hannes
