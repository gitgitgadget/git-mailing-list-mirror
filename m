From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] git-p4: Improve branch support
Date: Fri, 19 Aug 2011 11:02:59 -0700
Message-ID: <7v4o1d46uk.fsf@alter.siamese.dyndns.org>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:03:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuTPU-0002RH-MX
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab1HSSDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 14:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1HSSDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 14:03:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E51AD4E45;
	Fri, 19 Aug 2011 14:03:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=htrnvGDRfrYn6mZOlkFJR9dQAw0=; b=Nj1852akgz86EZohX492
	ElyxrVqEtXMssyPbooAuTFJ6+pT1VHAD6AXgLW0phPPCtobx74nTZNX5RUp02I3z
	L5VPkQmfs1ZocyVTLVZHzGxrVIEAiiS92ptSFmYxE6+4ZNi/8U6JlWVti0EOZvLH
	G7T98nhhG2irI+EKmxvkyAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AyB03Qy4VS0tH9XCKYMOlWf57lV6zlH+WZk4c5bbjAQZik
	qzbKDH/3Kwrnh0p07pI3JfsyLHBsT7u/CXYaBD3gnR45Z/A2XlKI+GAXrGpD382I
	9icIX9Wok/F5mF9KCD9EIHAeZn6N3J6z9mr1UvqYHF7X+CVeA5sh3YZ0J34NQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8D9E4E44;
	Fri, 19 Aug 2011 14:03:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53E4E4E43; Fri, 19 Aug 2011
 14:03:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A61F7BA-CA8D-11E0-BE84-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179712>

Even though this is labeled as v3, I do not see a corresponding v2 in
recent mail log. Is this an unrelated series that depends on v2 of your
"p4 rename/copy" topic?
