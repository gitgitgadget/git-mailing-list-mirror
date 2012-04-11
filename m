From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] git-rebase: add keep_empty flag
Date: Wed, 11 Apr 2012 14:08:54 -0700
Message-ID: <7vsjgaht7d.fsf@alter.siamese.dyndns.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:09:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4mr-0007LI-5N
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933362Ab2DKVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:09:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933341Ab2DKVI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:08:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD446614;
	Wed, 11 Apr 2012 17:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dDnKAO10/kD0N2JhTzJEEdVRB40=; b=CpYpcF
	C4Kv2DQFtBWua0eCwOGpxEQIlVIwKilLT/f2BMe7bhZ4V3jNJkU8t3w8ENBc4/BR
	VAXtzYPLfI5+2+bqW8fsY4GVi/JivTRThbtvu8wk19Dukw1deSiH0DRuhJMGNiEa
	AHvPqHZs97QsSg7cHi5atpPFo1QcPT8KlWQ9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eneEVRdVKbGUcXOs7MC9a+eoyZ9kU7B0
	kkuu+389MsyfdrlTRhXBr2R+LMkbqU3dR7HjxRWW4hvNjjJRSnZ381mWXAXYVsW/
	Xq+j8+bvH34WBKCgyYPOMfy9zUXZKBxzY/B0NGrI2wTX6sWLg2AGba4/7m8RHIVJ
	6a37P9zSV5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E460D6613;
	Wed, 11 Apr 2012 17:08:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 419A16612; Wed, 11 Apr 2012
 17:08:56 -0400 (EDT)
In-Reply-To: <1334175716-11391-5-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Wed, 11 Apr 2012 16:21:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CB95FD8-841A-11E1-80E7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195255>

This looks quite nice, but it seems that the change breaks at least t3416
and t3404.  Has this series been tested?
