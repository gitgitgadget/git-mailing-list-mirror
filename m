From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Fix in Git.pm cat_blob crashes on large files
Date: Fri, 22 Feb 2013 13:20:02 -0800
Message-ID: <7vip5kcagt.fsf@alter.siamese.dyndns.org>
References: <1361566878-20117-1-git-send-email-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 22:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U902n-0005ZR-9c
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 22:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab3BVVUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 16:20:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab3BVVUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 16:20:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66DF5A4F6;
	Fri, 22 Feb 2013 16:20:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=RP2J6H
	hPn/QL8196RMkynugyiWdl0uBJQG6hWraFsb+SosEL3rbds7cqZ+ncGzRqqFtZTP
	C3E2mJ/T6wcJmRF2bXVF0DwtJnGpSiqcoYd/rDSiYLX2MbDpyXKH/MLAQ7xprDj/
	tNSdDFxPdSdjxJQeLNu9twubg675ZKXW5Wax4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UuNCu6C+N5x63/6vtnZxmogxAkS9S4nX
	3d7cvH2TtazpPvk/DTb8QbpGiBJ+KBm2CZ856z6VZvzXJgji7d4dzzKnlgtGwn6N
	GVdY0M27UpsUwPCaUQwKL7dhT9dsFH80qFtlsYfRweqYoQjgFbSFgLz9szqjcFeg
	rFmMfZksWBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CCB3A4F5;
	Fri, 22 Feb 2013 16:20:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D21E7A4F1; Fri, 22 Feb 2013
 16:20:06 -0500 (EST)
In-Reply-To: <1361566878-20117-1-git-send-email-stillcompiling@gmail.com>
 (Joshua Clayton's message of "Fri, 22 Feb 2013 13:01:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1602CF4-7D35-11E2-B5BB-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216864>

Thanks.
