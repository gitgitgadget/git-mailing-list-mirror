From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Sun, 06 Dec 2009 16:30:09 -0800
Message-ID: <7vzl5vbp7y.fsf@alter.siamese.dyndns.org>
References: <m2d42w5fqq.fsf@igel.home>
 <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
 <7vbpif4rn2.fsf@alter.siamese.dyndns.org> <m2r5rb9hes.fsf@igel.home>
 <7vzl5ysm11.fsf@alter.siamese.dyndns.org>
 <20091204193355.GC4629@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRVz-0004Cy-Oz
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934434AbZLGAav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 19:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934473AbZLGAaT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:30:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932831AbZLGAaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:30:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B40F3A45FA;
	Sun,  6 Dec 2009 19:30:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YRfYn2kOHu8s1KQ1Je8RVOLg1pg=; b=xhaW8nMqrUeYIU3EfPowFcE
	LouvOZm9wN07jlo69nkBsb5gi4Ge4TtK7z2MEG8IttTLH/RsPullvCBWEfoWVAD+
	Kigi8Dpwm4qrN6RNzuO9XcDAcgnUiXpJIcR1H4+JS3oemfigqMbPeWdVuWOlSEat
	HZRCtZdcpY0GqCD7jpIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nD4AVZRX+GRFVHZv66I5wtVgfRzSJtdkWDRdDVsjzQfBzjvp3
	fgfjc4wbb80ewHBqki1aGFGeAomIhl8AXF7CSQmu3V0W1AN5U4PC6oPdMBzyQuXz
	tyIc4sMjkoOJvZ6qgZYLuJS2N+A0CgKdtSOPQ1PmjEKh+Gowj9AaYlLT4E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7663CA45F9;
	Sun,  6 Dec 2009 19:30:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 07E3FA45F6; Sun,  6 Dec 2009
 19:30:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B108F110-E2C7-11DE-A5F7-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134701>

Todd Zullinger <tmz@pobox.com> writes:

> Something like this perhaps?  I tested it with 1.6.5.4 on Fedora 10,
> 12 and CentOS 5.4 but it could surely use more eyes and testing to
> ensure it works as it should and doesn't have unintended negative
> effects on make clean and such.

Thanks (and thanks Andreas for pointing out a yet another distro that is
different).  I think the patch makes sense.

> This does set MAN_BASE_URL unconditionally, pointing to kernel.org.

I'd change this to point at "file://$(htmldir)/", though.
