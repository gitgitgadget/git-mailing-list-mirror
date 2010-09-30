From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 10:30:31 -0400
Message-ID: <18E0A903-D625-4C7A-A575-AC5C5EF448C9@gernhardtsoftware.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 16:30:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1K9j-0003Ga-KB
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 16:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab0I3Oag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 10:30:36 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:36315 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0I3Oaf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 10:30:35 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6E65F1FFC6B6; Thu, 30 Sep 2010 14:30:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C62A31FFC544;
	Thu, 30 Sep 2010 14:30:29 +0000 (UTC)
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157672>


On Sep 30, 2010, at 9:42 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

>  send-email: get_patch_subject doesn't need a prototype
>  send-email: file_declares_8bit_cte doesn't need a prototype
>  send-email: unique_email_list doesn't need a prototype
>  send-email: cleanup_compose_files doesn't need a prototype

None of these subroutines strictly need the prototype, but it does allo=
w Perl to warn us if we send incorrect arguments.  Why remove them?  Ar=
e they causing problems somewhere?

~~ Brian
