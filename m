From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t9001: use older Getopt::Long boolean prefix '--no'
 rather than '--no-'
Date: Thu, 23 Dec 2010 08:05:06 -0800
Message-ID: <7vlj3g326l.fsf@alter.siamese.dyndns.org>
References: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil> <jpN7nm-rtl4sNXi5qt9pXHOvlLOZP9xRq2h9eZev444l6GTi02jDn5C-Llxwsz3_tVhVKGvU5Vryto5cM6uchw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Dec 23 17:05:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVnfZ-0006y5-Gq
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 17:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0LWQF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 11:05:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab0LWQF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 11:05:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E1D029B1;
	Thu, 23 Dec 2010 11:05:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=r0b/p+zrRDlCUf7GWUf5j75L8TI=; b=MJsq/it6rHJlSOXmVjUHvgg
	gzB0iF5fDd1i7gAHZ7oyi+RvkHr41DAw8GFVKG3JXjhWJbRL2Bd3QMOOw/3pvCaG
	FuoUIqMmvxNPBkiG29pLBriUNCxvwZ4b0Tb6Hxbi3qkiQ/YXizm2PS6wqY1F0Hyq
	pLTXDv0pZSXecMWFZC9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uTICS7olF2MKGb5U+FtJVJ8lDC28phJxAXQXdhNTje0fE1Rv3
	lN6mFRYhOdJ9h7TB6LmVFq5GTiJj7v02XYfrbwdH1QdxiTRfaqwDKrJ0Lb4JoLeO
	LEDwb7Fwta84qGJ4ytQ1PZafquu86yNdyNFz2TeEUZ8dDXvWeZNlIEx0SU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 310F429A7;
	Thu, 23 Dec 2010 11:05:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C180299F; Thu, 23 Dec 2010
 11:05:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 851EE168-0EAE-11E0-9603-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164127>

This still leaves --no-bcc, --no-to and --no-cc in "no-foo overrides
sendemail.foo" tests, it seems.  Do they also need to be fixed?
