From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9600-cvsimport.sh: set HOME before checking for cvsps
 availability
Date: Wed, 26 Mar 2008 10:55:21 -0700
Message-ID: <7v8x05e5fa.fsf@gitster.siamese.dyndns.org>
References: <20080326173420.16383.qmail@4b0e1e5c705f62.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 18:57:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeZs1-0002OR-6B
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 18:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbYCZRzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 13:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYCZRzi
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 13:55:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733AbYCZRzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 13:55:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2415321B6;
	Wed, 26 Mar 2008 13:55:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 81F8A21B4; Wed, 26 Mar 2008 13:55:23 -0400 (EDT)
In-Reply-To: <20080326173420.16383.qmail@4b0e1e5c705f62.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Wed, 26 Mar 2008 17:34:20 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78293>

Gerrit Pape <pape@smarden.org> writes:

> From: Frank Lichtenheld <djpig@debian.org>
>
> This actually sounds like a bug in cvsps, which requires an existing
> home directory when asked for the usage through -h
>
>  $ HOME=/nonexistent cvsps -h
>  Cannot create the cvsps directory '.cvsps': No such file or directory

Thanks.

In the longer run, we probably would want to do something similar for all
tests to ensure a stable testing environment, don't we?  $HOME/.gitconfig
may affect the way tested programs behave otherwise.
