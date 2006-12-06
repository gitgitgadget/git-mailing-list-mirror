X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git patch
Date: Wed, 06 Dec 2006 11:22:32 +0100
Organization: At home
Message-ID: <el65h9$tfj$2@sea.gmane.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <Pine.LNX.4.63.0612060053400.28348@wbgn013.biozentrum.uni-wuerzburg.de> <45761451.8020006@gmail.com> <Pine.LNX.4.63.0612060157020.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576937D.1070402@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 6 Dec 2006 10:25:28 +0000 (UTC)
Cc: lilypond-devel@gnu.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33429>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grtxm-0002Sd-LW for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760453AbWLFKZP convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006 05:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760457AbWLFKZO
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:25:14 -0500
Received: from main.gmane.org ([80.91.229.2]:47289 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760453AbWLFKZN
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:25:13 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrtxW-0006S8-Hz for git@vger.kernel.org; Wed, 06 Dec 2006 11:25:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 11:25:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 11:25:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> I think it would be more logical to show those diffs as part of
> git-status and perhaps git-commit, eg.
>=20
> =A0 git-commit --dry-run <commitoptions>
>=20
> shows the diff of what would be committed
>=20
> =A0 git-status --diff
>=20
> shows diffs of modified files in the working tree.
>=20
> This makes it more clear what each diff means.

I'd rather say

  git-commit --diff

or

  git-diff --commit

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

