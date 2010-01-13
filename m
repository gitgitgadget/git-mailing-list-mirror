From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] lib-rebase: Provide clearer debugging info about
 what the editor did
Date: Tue, 12 Jan 2010 22:55:50 -0800
Message-ID: <7vd41etrwp.fsf@alter.siamese.dyndns.org>
References: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
 <cover.1263310175.git.mhagger@alum.mit.edu>
 <a6ef19853c00263c2875026cb438ce46d3fcf950.1263310175.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9D-0000sE-32
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab0AMG4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931Ab0AMG4A
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab0AMGz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:55:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E2FD90014;
	Wed, 13 Jan 2010 01:55:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0xACQywBxTzQT595ulUsz6mCyVQ=; b=tlLA+FcEJ2pH6NCvWJ5ip8/
	zDtkrhv/dDhcrVhRhLqg6oIdOcaTlaeQIKkcDJmp663B114DXoiyQV5rN8ZYSKJX
	yFUJ1zljPuspjxY3BgQWxbKLL1w+HWnJojf+LC0XXQTrsBalYFFqMxPNYIljes8o
	8fH4bqHb2K4LCCk20Fec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QmSabpJZVLG97VKXHO7z5r11UFsu1yYJdJGps5JSSc2awUsdQ
	iTiYX9a3CTn6Eu0g24olH7ye4nca3UNwhtyjLgvzKSW4QGl7wjfW0nDblus0EEYl
	OAPb+UfLEY2tYIY/8oxuANJ+k5KATszkZYWMPBOKbklnnb9qUUi9kGC054=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED3D990012;
	Wed, 13 Jan 2010 01:55:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 412289000F; Wed, 13 Jan
 2010 01:55:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B28C2C26-0010-11DF-B8E7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136776>

Very nice; thanks.
