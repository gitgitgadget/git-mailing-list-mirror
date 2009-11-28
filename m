From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] format-patch: improve pathspec usage
Date: Sat, 28 Nov 2009 11:47:14 -0800
Message-ID: <7vpr72fn3x.fsf@alter.siamese.dyndns.org>
References: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 20:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETGS-0007vo-K9
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbZK1TrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbZK1TrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:47:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbZK1TrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:47:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 828CDA2685;
	Sat, 28 Nov 2009 14:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qRiOAb70638r+A7Z+gNCFjCtyho=; b=OmPpAE
	XfaosIDc3k5f/AdutenCzziiqp2ruojITHjAtLHhN61940nYjcxOThE17LuLI/tI
	D5aMkyOsfyEjkFTV0hGOXIc+CnlML1G9YvmEOREQ1tWJfIZKgrTElsRzjNXfpksr
	Mp2nDlJb5wLtcQJM80nRPc1nD0dINb/8UH73M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7pfYxqret8WqYjYQf9q9k/QsjG6jsBS
	nPVXRZZe/vfbhiitIKXZyLEAAeoa/26axCb7Nhi4M/hB0E98u30L6Xrf4mGOUgkO
	9TLuwoB3WgdwOt6GSJ5e2nhKAperFiPnEEd2fKQ9QYGEKUHxKhjHO8VEXdWMDgfF
	2WLqYBIpKlg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62696A2684;
	Sat, 28 Nov 2009 14:47:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 74181A2683; Sat, 28 Nov 2009
 14:47:16 -0500 (EST)
In-Reply-To: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat\, 28 Nov 2009 13\:40\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D69CE3A4-DC56-11DE-82F8-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133971>

Thanks; I think I have queued the equivalent already and pushed out last
night.

I think making the full-diff default is a regression without an ability to
turn it off and is a bit premature without a solid discussion in the
documentation.
