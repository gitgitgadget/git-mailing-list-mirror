From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2 2/2] blame: use different blame_date_width for different locale
Date: Tue, 22 Apr 2014 12:01:02 +0200
Message-ID: <87vbu1ptsx.fsf@fencepost.gnu.org>
References: <cover.1398010052.git.worldhello.net@gmail.com>
	<07e4dcdc98b5eb9c78b9ed53bf2adc3b33139b67.1398010052.git.worldhello.net@gmail.com>
	<7vbnvvllx4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:01:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcXWA-0008V3-Km
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 12:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbaDVKBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 06:01:30 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:58005 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407AbaDVKB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 06:01:27 -0400
Received: from localhost ([127.0.0.1]:57046 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WcXW1-0001qg-UO; Tue, 22 Apr 2014 06:01:26 -0400
Received: by lola (Postfix, from userid 1000)
	id 43D4FE0524; Tue, 22 Apr 2014 12:01:02 +0200 (CEST)
In-Reply-To: <7vbnvvllx4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Apr 2014 14:40:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246725>

Junio C Hamano <gitster@pobox.com> writes:

> This is not wrong per-se, but I am not sure if translators would
> understand that "years and months ago" may not be the longuest
> variant for their language and they are asked to use "89 seconds
> ago" if the translation of that is longer than the translation for
> "4 years, 11 months ago" in their language, with the given
> explanation.

What's with the 89?  And the other semi-magic numbers?  If we fear about
non-arabic number formatting, at least in French French the worst
offender may be quatre-vingt-quatorze ("four score and fourteen") or
quatre-vingt-dix-neuf ("four score and nineteen"), namely 94 or 99.  But
I think it's improbable to get worded formatting here anyway.  Or are
those the largest values with their respective granularity?

-- 
David Kastrup
