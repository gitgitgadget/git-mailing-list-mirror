From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Tue, 05 Jan 2010 17:04:18 -0800
Message-ID: <7vpr5ooxgt.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <7vskal5c11.fsf@alter.siamese.dyndns.org> <20100105115620.GA27121@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:04:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKKC-00068A-CZ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0AFBE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132Ab0AFBE0
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:04:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab0AFBEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:04:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 657B6AD48F;
	Tue,  5 Jan 2010 20:04:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=EBEInJfC7eTA6/dTIw6js3+9Dac=; b=YYgb3gUABnYUIkX/TGksTLK
	8UPA0ioyHwuQZ65mL71Jzoc1SRgCyPfAbUZGKkxiL8pUgkrtB6jJZMw8w8Al4fpE
	9Hinfen82ZhENIw8M/Vig/kAmtzmtfbcpkmkqC5IS/jsgGToI+kFk51a4Ib6pflE
	ZlE3KJKPCxwhIBnYbylo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=L42lyEGUgLhN8KSLnWflzBj9LUxBO8jndqBy08tk/mxyHmYmE
	6RXYPLCsH+TNAYAGlgoQAqWK+7ODKF4z33dybGGvXE5icgNc3UbWAbzYxFZg+49i
	0yEl13ha5TMT7BpYcG9HOn7+62wRfbhWSuL990W8+fOL/0fuCw3aoWjYAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43292AD48B;
	Tue,  5 Jan 2010 20:04:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39A68AD489; Tue,  5 Jan 2010
 20:04:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D6B64B0-FA5F-11DE-91CE-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136226>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> - Not using warning()

Ah, I forgot about locally fixing that one up.  Sorry, and thanks.
