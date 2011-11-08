From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [fyi] patches used by git distributors
Date: Tue, 08 Nov 2011 12:45:45 -0800
Message-ID: <7vfwhyxs06.fsf@alter.siamese.dyndns.org>
References: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
 <7vmxc6xs73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 21:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNsYL-0002th-9k
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 21:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab1KHUpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 15:45:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531Ab1KHUps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 15:45:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA6866A54;
	Tue,  8 Nov 2011 15:45:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twxdz9dJa3W2TDrqfepXCXUYRyk=; b=nHP0Qs
	/Wg95+DRr9TbevLPqK+U/lMrfoukUs4VGYX9vwdazld8xkaLbBlqGnSFNzeh0YqN
	005EVoMG6cY6Mm6+k7hA4dZG6ksqbHQXvbdIzz4jhEApnbxKNYek0t6tlPbIxlCQ
	2TDj6RkKWEwq69F5xMi9pLDUHA+j2IrQw/a+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLP69/GaROEvCqyREJS9b9xn85xtXfBF
	BvImfGoqG0EQ7bc9GUK6uOM1kcCeQb1joOCShLrMsRqJYzxCyCRhqesqabT44Nuw
	n7QXhIhH/rd16OTRkWiROYo3yErPNx5R5VLbINQQyz78QnQ7nW/IILknvIzN1wbb
	XN8SX4U0tZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B04A06A53;
	Tue,  8 Nov 2011 15:45:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C0D96A52; Tue,  8 Nov 2011
 15:45:47 -0500 (EST)
In-Reply-To: <7vmxc6xs73.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 08 Nov 2011 12:41:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2C5F5D8-0A4A-11E1-84E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185107>

Junio C Hamano <gitster@pobox.com> writes:

-ECANNOTPARSE, sorry.

... That is, work-around should be made when a _particular_
recipient wants to extract a tarball that stores more hardlinks to the same
inode than the filesystem the recipient _happens_ to be trying to extract
it on supports.
