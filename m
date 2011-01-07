From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mark gitk script executable
Date: Fri, 07 Jan 2011 12:45:10 -0800
Message-ID: <7vbp3s5tpl.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu>
 <7vlj2x8mr4.fsf@alter.siamese.dyndns.org> <20110107030119.GA32290@burratino>
 <7v4o9k7brc.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1101071526180.31807@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJBm-0000td-8h
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1AGUpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:45:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab1AGUpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:45:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B37B23D7D;
	Fri,  7 Jan 2011 15:46:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GARfEpwDm76xYZ22zRmYPNzii2w=; b=ullinG
	PxKNwKvFe/kbufKaQum8hPHK/FevxCUVXQhN880Z1FdtLoEfwW8bkZ4qycg7LJGW
	LZuDLqQ5vH7Pym/5tBcCplXnS/mVzH7qlxBBphP+0HDzCfEa6hhETYHtg9NNPRU3
	G1koYOluoqQO5MS96jNE0CTPcsa072xubyZB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xESyvjDRhOMDrL5FFxo3BUnCo5KWGXi2
	HKeyXgFvM7S3Xdco7fqBixVDpjZ4GffmG59V19hqPK4mcZ6xlHUkhRqZUS7wouml
	M/oV33od5/2hu32oNkHJY5+G8a1828BBPSC/9+XTA4w9dsZBWWViZa0QMc7JYY7c
	ykAe2C5QUBA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B3723D6E;
	Fri,  7 Jan 2011 15:45:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 328AE3D6B; Fri,  7 Jan 2011
 15:45:50 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1101071526180.31807@dr-wily.mit.edu> (Anders
 Kaseorg's message of "Fri\, 7 Jan 2011 15\:35\:04 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 216C3966-1A9F-11E0-8D3B-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164760>

Anders Kaseorg <andersk@MIT.EDU> writes:

> On Fri, 7 Jan 2011, Junio C Hamano wrote:
>> The change needs to come from gitk repository, so I'll leave it up to Paul
>> ;-)
>
> No, the script has always been executable in gitk.git.  The patch should 
> be applied directly to git.git to bring the two repositories in sync.

If that is the case perhaps the next pull will fix that ;-)
