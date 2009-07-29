From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit
 notes
Date: Wed, 29 Jul 2009 11:56:25 -0700
Message-ID: <7v1vnzuxly.fsf@alter.siamese.dyndns.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <200907272026.46150.johan@herland.net> <20090727183517.GN11191@spearce.org>
 <200907280343.56586.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWEKU-0004mb-Cc
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 20:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbZG2S4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZG2S4f
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 14:56:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbZG2S4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 14:56:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DDA51569B;
	Wed, 29 Jul 2009 14:56:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E45615697; Wed, 29 Jul 2009
 14:56:26 -0400 (EDT)
In-Reply-To: <200907280343.56586.johan@herland.net> (Johan Herland's message
 of "Tue\, 28 Jul 2009 03\:43\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A00A76E-7C71-11DE-B52A-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124380>

Johan Herland <johan@herland.net> writes:

> Introduce a 'notemodify' subcommand of the 'commit' command. This subcommand
> is similar to 'filemodify', except that no mode is supplied (all notes have
> mode 0644), and the path is set to the hex SHA1 of the given "comittish".
>
> This enables fast import of note objects along with their associated commits,
> since the notes can now be named using the mark references of their
> corresponding commits.
>
> The patch also includes a test case of the added functionality.
>
> Signed-off-by: Johan Herland <johan@herland.net>

Thanks.

Replacing this will cascade to the rest of the series, right?
