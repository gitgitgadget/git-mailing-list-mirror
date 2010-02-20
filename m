From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: fix bug in symlink handling
Date: Sat, 20 Feb 2010 11:22:15 -0800
Message-ID: <7vsk8vk908.fsf@alter.siamese.dyndns.org>
References: <6682cfcf1002160044i7aacd1b0t7bb351380b1bd27c@mail.gmail.com>
 <20100220140500.GA23423@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Evan Powers <evan.powers@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Simon Hausmann <simon@lst.de>,
	Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 20:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiuuT-0007w3-02
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab0BTTWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:22:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0BTTWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:22:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB4649B9DC;
	Sat, 20 Feb 2010 14:22:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UZjQ7//1/mjBL+E7D9ZSDGVsXOE=; b=srtjCuQ18inugxrwQsy0Y71
	CKsUUItFb4G6KCDF5FSlxHNWGS67TwjzW6ojovbdguxgtN2yh2wQFH25lY6pw2KK
	cVH7gQ88UbbNYuqtOBbI3hAZ7f9XqFddO4oyf6hK0vK/ItxiXfS/pBPf71n+1ZaG
	8gOFTFKUPgjCVDUG9mgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=D2ViYCRxvumvSesMxsHTZ/VTDe/vo1QnSfAKLkQWc2Z7OtqDf
	eiDDZMEN/OetPvn0u/+TKxUETuCUHs1IQVPxdQ1rshmvpVyl+tAeN1+7a9e8nSQL
	MD+rSMcWTk1MVC/1faD/ub1Q+So+tbNqDda310Z4M2s3MWxdL6fdWoVI7s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5305F9B9DA;
	Sat, 20 Feb 2010 14:22:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 127259B9CF; Sat, 20 Feb
 2010 14:22:16 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4630B66A-1E55-11DF-A1B0-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140544>

Thanks; will apply to 'maint'.
