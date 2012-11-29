From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: fix warning for zsh
Date: Thu, 29 Nov 2012 10:02:15 -0800
Message-ID: <7vboegqod4.fsf@alter.siamese.dyndns.org>
References: <1354177257-5416-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:02:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8RV-0006Za-Pj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab2K2SCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:02:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2K2SCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:02:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24E0AAE21;
	Thu, 29 Nov 2012 13:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dZ4pEWUquo1RIW6yWFb9FI1S1EQ=; b=K+zTS7
	hzlk5EOA0BmURbAm6jDCWPLq61tvkmTjHWrB4re0848TDz8u7gyXi2IeXT2zZpsg
	ErQ2VwKf4InQmuraVbvDVWd5M6LbM+PMl59d3mq3ezVxouqg0NAZFihZMncrH7Rt
	Y1BjGFf3M8I5bwGkeQeaByq50JmXOF+eWfJIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jIp7r9yMnNL5rhO7vKHCuz4Xis1bbGrL
	PDUJXsp0KQMmttTLVScaprw15aT9E8KrY6676UOBzRXoar+S97nI9K8uSy/eJv4J
	lxgkyVs82N/yhSKoc0rptnH7SMZX1JUhxOBM1zldZ2HaunfrvenBB+9HcvlbFz+L
	Ha9qZSZLYno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13187AE20;
	Thu, 29 Nov 2012 13:02:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 885F9AE1F; Thu, 29 Nov 2012
 13:02:16 -0500 (EST)
In-Reply-To: <1354177257-5416-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 29 Nov 2012 09:20:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9029BC0-3A4E-11E2-BC1C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210852>

Will apply directly on 'master'; thanks.
