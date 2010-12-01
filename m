From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] cvsimport.txt: document the mapping between config
 and options
Date: Tue, 30 Nov 2010 17:43:10 -0800
Message-ID: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
References: <4CF2ADC9.8020504@drmicha.warpmail.net>
 <317523448870044a68311f811b42bd9461b90d43.1290973138.git.git@drmicha.warpmail.net> <7v7hfv3mli.fsf@alter.siamese.dyndns.org> <4CF4AE49.7090406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 02:43:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNbjA-0000vl-Sv
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 02:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab0LABnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 20:43:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0LABnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 20:43:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25F412A55;
	Tue, 30 Nov 2010 20:43:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F1avnkdtify4ROx3DEF16VZ4fyk=; b=kt+Gjb
	EHY6bwp+wju3T7o8OIF3aC95TPFd6L6CFk2+8/8nriSzO2h5aI8TbLDeZ4lxj7GR
	1BUaNGt0i+2U7+6FHrbXe2ZdelkrEJj7+B984HBoDI8u6dufYllRRSXl3xsfbIVc
	grPFYcCDLmfpdp7JkavhJSgmbkF0FknTDWYNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uu0WbHtuvu6P+yegRyqpfbWMGaTbJU0e
	A9izlgwzIHHlpksu+rs+YV+9OYJOxf9xCqQTmjLJWiUtleYHxcMAdL86GeYb5GYB
	wq/bjkXl8ma5eh6IEtqOtNvGKwkVroYKy+uXcvJGbbvVmROPIocDWyQyQBvpkj7u
	cY66VYo6rKU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 037D72A54;
	Tue, 30 Nov 2010 20:43:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 272CD2A2F; Tue, 30 Nov 2010
 20:43:30 -0500 (EST)
In-Reply-To: <4CF4AE49.7090406@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 30 Nov 2010 08\:56\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 687A7F8C-FCEC-11DF-9251-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162494>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> How about using a naming scheme like:
>
> [cvsimport]
> 	r = origin
> 	capital-r = yes

I think we can live with that.  If it is easier to implement, that's very
good.
