From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tests in Cygwin
Date: Thu, 07 May 2009 17:02:40 -0700
Message-ID: <7viqkccvhb.fsf@alter.siamese.dyndns.org>
References: <83prfbhasp.fsf@kalahari.s2.org>
	<4A01E64C.7050703@SierraAtlantic.com>
	<7vvdoet13g.fsf@alter.siamese.dyndns.org>
	<4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Fri May 08 02:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2DY8-00071x-9b
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbZEHACl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbZEHACl
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:02:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35349 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZEHACk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:02:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508000240.FCXR20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 May 2009 20:02:40 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oo2g1b0094aMwMQ03o2goC; Thu, 07 May 2009 20:02:40 -0400
X-Authority-Analysis: v=1.0 c=1 a=X5qfkU2QAAAA:8 a=BRPLW8mHVbSvhZietDkA:9
 a=8SrPCaEnH_o7ZBmryhP1c2t6qZEA:4 a=APNzIMUK1msA:10
X-CM-Score: 0.00
In-Reply-To: <4A030277.2000708@SierraAtlantic.com> (Don Slutz's message of "Thu\, 07 May 2009 11\:47\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118545>

Don Slutz <Don.Slutz@SierraAtlantic.com> writes:

> test_have_prereq () {
> -       save_IFS=$IFS
> -       IFS=+
> -       set -- $*
> -       IFS=$save_IFS
> -       for prerequisite
> +       for prerequisite in $(echo $*)

Ah, that's clever.
