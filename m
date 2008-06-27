From: Pascal Obry <pascal@obry.net>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 08:31:10 +0200
Organization: Home - http://www.obry.net
Message-ID: <4864892E.2060508@obry.net>
References: <1006.35704952783$1214525911@news.gmane.org> <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Jeske <jeske@willowmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC9C6-0000os-EM
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 10:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759481AbYF0ITg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 04:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759477AbYF0ITf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 04:19:35 -0400
Received: from qb-out-0506.google.com ([72.14.204.233]:36693 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759409AbYF0ITc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 04:19:32 -0400
Received: by qb-out-0506.google.com with SMTP id d8so906267qbc.37
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 01:19:31 -0700 (PDT)
Received: by 10.103.215.4 with SMTP id s4mr557854muq.13.1214554770826;
        Fri, 27 Jun 2008 01:19:30 -0700 (PDT)
Received: from ?10.10.127.229? ( [212.99.106.127])
        by mx.google.com with ESMTPS id u9sm5544122muf.12.2008.06.27.01.19.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 01:19:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86531>

Junio C Hamano a =E9crit :
> You would rebase ONLY WHEN the project as the whole (either "other pe=
ople
> in the project", or "yourself down the road one year from now") is
> interested mostly in the progress of 'master' D-E-F-G, and nobody car=
es
> whether you developed your A (or B or C) on top of E or G.  So the an=
swer

Or if you are using git-svn as nobody will ever see your local branches=
=2E=20
So rebasing is just the right way to go when tracking a Subversion tree=
=20
I would say.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
