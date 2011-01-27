From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase: give a better error message for bogus branch
Date: Wed, 26 Jan 2011 17:27:19 -0800
Message-ID: <7v39ofi1ag.fsf@alter.siamese.dyndns.org>
References: <20110127002711.GB32711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 27 02:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiGe5-0007WM-En
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 02:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab1A0B12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 20:27:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab1A0B11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 20:27:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEA6037A5;
	Wed, 26 Jan 2011 20:28:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5F5+bHL88gX8iEMewdDoeS+0+o=; b=Sd3OUv
	UcMpgGoxIATA0b4WvFi/9AZbi/EqgxqPS97A7tvevgii501zOE15HOIGOxTAN68y
	8FLl5JbPNuxNw4k8bi/lizA2TQqRNv9d4t7Wbbdy+9y0aX8CgmMKqKEkmI/+G+L2
	drbq4r042udXyGQGUZVuN2fNTEV28htTq5eKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUYXQxjzY+LTdlvS4NDedCPftSBmtdIY
	6Is1cKyyH6k8Hc9MAMVRIBYztMwqQW2gDO15SEISbizjwgimXEU1Hdtd26YCndfD
	m0XpuDrvTFa7itv/Buzi7Do8eAL3sE2Lt2xKrT/8N/IbGYAFxcKUpxHfDrHqdnlk
	Bu8Rrdt+x6E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9878C37A4;
	Wed, 26 Jan 2011 20:28:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ADD38379D; Wed, 26 Jan 2011
 20:28:11 -0500 (EST)
In-Reply-To: <20110127002711.GB32711@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 26 Jan 2011 19\:27\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B606DEB8-29B4-11E0-8363-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165568>

Thanks, both patches look very sensible.
