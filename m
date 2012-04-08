From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Sat, 07 Apr 2012 21:45:27 -0700
Message-ID: <7vehryygpk.fsf@alter.siamese.dyndns.org>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
 <7vobr4236g.fsf@alter.siamese.dyndns.org>
 <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
 <7vbon41ugg.fsf@alter.siamese.dyndns.org>
 <CAMP44s1m2exUVRTzcBJrY8hnWxF+uEt58AQOP5vKiA3tfeRXRQ@mail.gmail.com>
 <7vobr4ze5z.fsf@alter.siamese.dyndns.org>
 <CAMP44s0D1RXteHvCrsmaKVcfaK4SRArXf_nF7by2jJkgatkG-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 06:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGk0N-0007Wr-F6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 06:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab2DHEpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 00:45:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab2DHEpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 00:45:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DD9C7856;
	Sun,  8 Apr 2012 00:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMAOd4ntdyJZj048UTx2ao+FTgg=; b=kgosFB
	ad64aHNigKSopM2NjOM5gwzFAzUeIAmlAe0PDJpBT+7lX84OzidO2TUsxxpZm3/F
	v+ME/hhfHnZC96ou6/QPlX1+EX1+wt/7BeNfsFKIfDeNBwHEUshLC3xo/8pilGw/
	o8Xe+lF4Be5Gi85tkJAG9DRiMf+LLP0GnZApY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PUZ+RTWirPVspvtkdz0VV7ycgyykw6af
	F8DFbGOA5EPdFVgV3r2z4Sg5tp2EXwVts+nSmvJ+LPGgVxferfkPRYXmQL9382Wo
	ERMc3j4RrhcUEgS12bqdI2JEdQlrCY/ms9jZ/Gd9RELagBXYSYq9G9rRrKfT/Q4p
	LZaMJA/hIbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64AFD7855;
	Sun,  8 Apr 2012 00:45:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08A3C7854; Sun,  8 Apr 2012
 00:45:28 -0400 (EDT)
In-Reply-To: <CAMP44s0D1RXteHvCrsmaKVcfaK4SRArXf_nF7by2jJkgatkG-A@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 7 Apr 2012 14:46:29 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA6F2B80-8135-11E1-875C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194975>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So only From and Subject? Not Date?

I do not foresee MSA/MTA breaking a Date field; RFC2822 dates are
ASCII-only no?
