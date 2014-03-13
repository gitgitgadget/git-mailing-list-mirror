From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] connect.c: SP after "}", not TAB
Date: Thu, 13 Mar 2014 10:54:26 -0700
Message-ID: <xmqqzjkuhtm5.fsf@gitster.dls.corp.google.com>
References: <1394711131-14703-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:54:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9pz-0005c6-Da
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbaCMRya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:54:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213AbaCMRy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 13:54:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8230B73823;
	Thu, 13 Mar 2014 13:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OCg+Ye6XwSGTQhbQuxLGq1gB+s8=; b=r5zXvT
	icqa1DAWU8wBc0ttZAEeR/U5Od8jyDeugz3EX00g7RDo4hmE2Qv8XneDeAhdQdvf
	sn1NyBmEs4DZ/i+wI7lRfhJiC0IgJzbzBellWtEx+EX3pP0LXpj1wk9MTvlpVm8j
	Cj/DoqEKqez/7toFYJkBDG9kx0ctIUn63vWJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqd2B5eL1uS+ypmo1Vc4vawvk/m/If5i
	4AGeho3YI1sSLxXttqxrs4eoy0ACq2puyDVF1kuvPDTQFKi32x892yTbNWkXOA5A
	gVL7fHY3q+2/JnFEoxhl3+ZZj2trt2o1CsUYdK018isg6Y/rLbgDmC4yCTWTVOVC
	NnWk9NiIPEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BB5773820;
	Thu, 13 Mar 2014 13:54:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2CF87381E;
	Thu, 13 Mar 2014 13:54:28 -0400 (EDT)
In-Reply-To: <1394711131-14703-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 13
 Mar 2014 18:45:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85DD2884-AAD8-11E3-9496-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244040>

Thanks ;-)
