From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/6] object: add one bit to let creation of private 
 types (OBJ_MAX + n)
Date: Sun, 22 Feb 2009 17:47:55 -0800
Message-ID: <7v3ae5yldg.fsf@gitster.siamese.dyndns.org>
References: <e29894ca0902221006u77fdaa89s9cc01fb27bffce0b@mail.gmail.com>
 <7vocwuxrgb.fsf@gitster.siamese.dyndns.org>
 <e29894ca0902221035s54e005adg586409754966cfcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 02:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbPws-0007PU-NM
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 02:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZBWBsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 20:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbZBWBsE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 20:48:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbZBWBsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 20:48:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE47B9C5C1;
	Sun, 22 Feb 2009 20:48:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 41C1B9C5BE; Sun,
 22 Feb 2009 20:47:56 -0500 (EST)
In-Reply-To: <e29894ca0902221035s54e005adg586409754966cfcc@mail.gmail.com>
 (=?utf-8?Q?Marc-Andr=C3=A9?= Lureau's message of "Sun, 22 Feb 2009 20:35:05
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00A3A282-014C-11DE-A15E-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111071>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> One option is to reuse the struct tag, by adding a "light" flag, but =
I
> am not fond of this idea.
>
> Second option is to create a custom tag list in builtin-tag.c, not
> reusing object_list. I guess this is better then.  What do you think?

My preference is, as was indicated in my reply to 5/6, the latter.
