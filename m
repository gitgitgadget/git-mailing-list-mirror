From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Wed, 27 Feb 2008 16:19:03 -0800
Message-ID: <7vpruindag.fsf@gitster.siamese.dyndns.org>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
 <7v63waqasu.fsf@gitster.siamese.dyndns.org>
 <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com>
 <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:20:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWVK-0000Nb-HI
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbYB1ATa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 19:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbYB1ATa
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:19:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbYB1ATa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 19:19:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FF5A22B8;
	Wed, 27 Feb 2008 19:19:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D3C2B22B7; Wed, 27 Feb 2008 19:19:21 -0500 (EST)
In-Reply-To: <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Thu, 28 Feb 2008 00:16:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75329>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> My preference are in order:
>
> 1) define an official extension + the && [ -f "$repo" ]
> 2) the && [ -f "$repo"]
> 3) just remove this line

Sure.  (1) sounds sane and if you make the extension ".git",
then I do not think you need anything more ;-).  Jokes aside,
calling it .bundle or .bndl would be sane.

Opinions?
