From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix to push --progress. The --progress flag was not
 being passed into tranport.c from send-pack.h, making the --progress flag
 unusable
Date: Wed, 13 Oct 2010 10:49:09 -0700
Message-ID: <7vr5fum19m.fsf@alter.siamese.dyndns.org>
References: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65S5-0000GW-GL
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab0JMRtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:49:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab0JMRtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:49:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60025DE8B0;
	Wed, 13 Oct 2010 13:49:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQf41t2vfKZui5RqaVjw/Mt0g2A=; b=jTBIa4
	1P9rEQFCppr1qaUNBHbGHEk5gJ3p5zBz5Ty78YAQobyuFDBPKpDe3ZVxWsBb9VNI
	tHsfn29AhOi35nLbVl0GyJvNmChAGKGM0ATff142b18d53h5NglfHsKgq5HQ8k/C
	ZAdybF7QF98k58xueE8BmHHyu/TkaXJyT7y/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwqNNmWn7RrxKezWOdpgABsO+dm3Uw7a
	GJByqpK7kM21rdupL2P5M1t+9ifhSfWc4UJrsVtwJjRDpWlQWGPGPdgfupdRBOzn
	pIdxUrNxjdVvw/X6D5IJ70vf9onADPUTXyDXwEvatYNU9rOHuajiBX9lvh7ZKOPZ
	e/8+nbPy+g0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE96DE8AF;
	Wed, 13 Oct 2010 13:49:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81544DE8AC; Wed, 13 Oct
 2010 13:49:10 -0400 (EDT)
In-Reply-To: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
 (Chase Brammer's message of "Tue\, 12 Oct 2010 16\:21\:20 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30B676F2-D6F2-11DF-AC90-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158952>

Chase Brammer <cbrammer@gmail.com> writes:

> The result of this is external tools and tools writing standard error

Thanks for leaving a record in the list archive, but (1) what Jonathan
said, plus (2) Please do something about that overlong Subject: line.
