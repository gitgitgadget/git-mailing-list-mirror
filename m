From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add color.diff.{header,message} formats
Date: Sat, 17 May 2008 11:17:03 -0700
Message-ID: <7vej80dcdc.fsf@gitster.siamese.dyndns.org>
References: <1209980316-7340-1-git-send-email-madcoder@debian.org>
 <20080517130739.GA2326@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat May 17 20:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxQyx-0008Qr-EA
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 20:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbYEQSRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbYEQSRM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 14:17:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbYEQSRK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 14:17:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 685A45A5E;
	Sat, 17 May 2008 14:17:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D9FF95A5C; Sat, 17 May 2008 14:17:05 -0400 (EDT)
In-Reply-To: <20080517130739.GA2326@artemis.madism.org> (Pierre Habouzit's
 message of "Sat, 17 May 2008 15:07:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76B4CF06-243D-11DD-9440-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82355>

Pierre Habouzit <madcoder@debian.org> writes:

>   Hmmm it seems this patch has been somehow lost somewhere, is there
> anything wrong with it ?

It may not break anything, and I did not hear anybody on the list who said
this breaks soemthing.  But I did not hear anybody on the list who wanted
to have this except you, either.  At this stage of development, the
question we should be asking is not if there is anything wrong with it,
but if there is anything _good_ with it.

It looks rather widespread compared to a perceived benefit.  Perhaps after
a refactoring to make the parameter to pretty-print-commit a bit more
easily extensible, the patch might start looking more promising.  I dunno.
