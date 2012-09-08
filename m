From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Restore hostname logging in inetd mode
Date: Sat, 08 Sep 2012 11:57:20 -0700
Message-ID: <7v627ouyun.fsf@alter.siamese.dyndns.org>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Sat Sep 08 20:57:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQDj-0004Pj-76
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 20:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab2IHS5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 14:57:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab2IHS5X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 14:57:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9E071BB;
	Sat,  8 Sep 2012 14:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YTZ7x0MfsxWsP7NaUSo3TfmhLRw=; b=xUVrv1
	ygDZ/ubC4f7v2s1DTq6MfQwLaLQQGEzSsKvuNSlkwH+ns9xsuzzpz2G8H3mytnkS
	dKKQyVn3rE9nkY/HQ7cIPH69heSPe67nyh0lp6Gkhw3cFR4+PZ6wr/g8uaMQv/zU
	ApfvAW8bbVrAHEPBiTHXXvRHTRlY+UuVCaffs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V2Z/Ac6oYPIgwAs0oECpeGJvprxt1AL/
	DTAirL2z5kvChJW6jwWg9QimNZ+V3hf3rPNc5WLB3ms0h3VYJTDm896dBUHc7JQc
	eVsnvUZLKo35tDnBchNdpgJsDPLxbNN+pCwbpMOj2bcWVDqHO9Z5kCYZjq9ZbKc9
	2BQptmF1OkA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B92BE71BA;
	Sat,  8 Sep 2012 14:57:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B2A471B8; Sat,  8 Sep 2012
 14:57:22 -0400 (EDT)
In-Reply-To: <1347124173-14460-1-git-send-email-jengelh@inai.de> (Jan
 Engelhardt's message of "Sat, 8 Sep 2012 19:09:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 057A66B4-F9E7-11E1-AEC2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205025>

Please don't throw a pull request for a patch whose worth hasn't
been justified in a discussion on the list.  Thanks.
