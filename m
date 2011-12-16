From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange behaviour with git-add, .gitignore and a tracked file
Date: Fri, 16 Dec 2011 15:42:30 -0800
Message-ID: <7vmxasf5i1.fsf@alter.siamese.dyndns.org>
References: <201112162258.04661.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: David =?iso-2022-jp?B?GyRCIUYbKEJCb21iZRskQiFHGyhC?= Roden 
	<bombe@pterodactylus.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 00:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbhQD-0000tN-NO
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 00:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742Ab1LPXme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 18:42:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab1LPXmc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 18:42:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E32A5DDA;
	Fri, 16 Dec 2011 18:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L32buiEn9aRk3925fBRMFOsS6nY=; b=N9s/57
	8XR9e4TJw8zeDHrPooT52/yMF+lz+037kccQ19Bb3k0KQQcNklc6ES5rAQ+zMcr2
	dCfv3FUK7mqs4Veg+koF4UNHl2OACUIldm0P7gaq7b7GOccpB2TYlszOO+e7tLss
	6M10dLm9ejhW9lW3osxvZYRBaHhBS6ZF1QrAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9L85rhf1iE/DE71K0RNGnXENAC3IaYE
	TCzPk14MDIvE+6z4hcs/LizybT6iy/6EhovSFgV79vDoNwNFrHjVwBP0OticsbDi
	7I7Od4s2QxkiVGJS+ohcsgb/sqNJKGQ17yFB8R4bQjUYi6jYsCAUNwBhmblH08fO
	3hXXnDQDPfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44E3E5DD8;
	Fri, 16 Dec 2011 18:42:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0FA45DD7; Fri, 16 Dec 2011
 18:42:31 -0500 (EST)
In-Reply-To: <201112162258.04661.bombe@pterodactylus.net> ("David
 =?iso-2022-jp?B?GyRCIUYbKEJCb21iZRskQiFHGyhC?= Roden"'s message of "Fri, 16
 Dec 2011 22:57:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F4F83B6-283F-11E1-8D34-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187336>

David ‘Bombe’ Roden  <bombe@pterodactylus.net> writes:

> This behaviour was reproduced with 1.7.7.4 (on OS X), 1.7.5.4, 1.7.1, 
> 1.7.8-247-g10f4eb6 (latest master as of a couple of hours ago) (all Linux).

Doesn't that suggest perhaps it could be a designed behaviour?

Perhaps to help users to realize that their .gitignore pattern may want to
be improved?
