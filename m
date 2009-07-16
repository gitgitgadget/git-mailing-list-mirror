From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Thu, 16 Jul 2009 10:15:51 +0200
Message-ID: <adf1fd3d0907160115j24acf584ic4a8be6aa85b4606@mail.gmail.com>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
	 <1247731921-2290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 10:16:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRM8I-0005AQ-LU
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbZGPIPz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 04:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZGPIPy
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:15:54 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:45351 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZGPIPx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 04:15:53 -0400
Received: by bwz28 with SMTP id 28so1891775bwz.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 01:15:51 -0700 (PDT)
Received: by 10.204.119.76 with SMTP id y12mr8632920bkq.114.1247732151493; 
	Thu, 16 Jul 2009 01:15:51 -0700 (PDT)
In-Reply-To: <1247731921-2290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123387>

2009/7/16 Santi B=E9jar <santi@agolina.net>:
> Use the fork commit of the current branch (where
> the tip of upstream branch used to be) as the upstream parameter of
> "git rebase". Compute it walking the reflog to find the first commit
> which is an ancestor of the current branch.
>
> Signed-off-by: Santi B=E9jar <santi@agolina.net>
>
> Changed since v1:
> =A0- rename reflist to remoteref to better reflect its use
> =A0- (( $num + 1 ))

Arg! It should not be in the commit message! Sorry. Junio, can you
amend it if applied? Thanks

Santi
