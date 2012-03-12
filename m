From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 11:01:55 -0700
Message-ID: <7vzkblsnos.fsf@alter.siamese.dyndns.org>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312171257.GA25347@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Greg KH <greg@kroah.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 19:02:09 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S79ZQ-0002ID-Nm
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 19:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2CLSB7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 14:01:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057Ab2CLSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 14:01:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E26C465F4;
	Mon, 12 Mar 2012 14:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sWPKVXnU4Jdl4Gb25uLHi0vXO3k=; b=LgAgmc
	Z7VoXuGe3duwA5XEJzbagvIjq3w/mJT7HZV1w32tle4YDg0HVmkYWBmBf2ip3acv
	sMMMsFabYWix+g0HOOH0BWf2Mzz75USvoTrpRNHlqOzMe2k291wloIbh2y63gzKH
	KrCaMiKHRO2tNLUYKwWt1SDdxUg8A+hQhvc9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oor4fZ1idcwp/G1BH9HUTocO4aLz5/uV
	sJXuxLY0RfsaeXVSUFW3tCWZvGV+2ZEmGDSkaHDofetctsA/MeiIprbqRbBbExNE
	KykmuFvCcdwb/U8+Q3pImE2JWj/CIlPyyEhrh2o7zhbEYy3YuGOU9iaWkQTYDowE
	pIHzSnEwoaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D94B165F3;
	Mon, 12 Mar 2012 14:01:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68D2065F2; Mon, 12 Mar 2012
 14:01:56 -0400 (EDT)
In-Reply-To: <20120312171257.GA25347@kroah.com> (Greg KH's message of "Mon,
 12 Mar 2012 10:12:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74CCB966-6C6D-11E1-A534-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192913>

Greg KH <greg@kroah.com> writes:

> Does the flag propagate from 'git quiltimport'?

I didn't even know the script was shipped as part of the main
Porcelain until I looked.  I do not think anybody is maintaining it;
the last update was from the 1.6.2 era.

A tested patch from quilt stakeholders is very much welcomed.

Thanks for bringing the script to my attention.
