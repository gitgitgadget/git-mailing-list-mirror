From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git smart protocol via WebSockets - feedback wanted
Date: Tue, 05 Jun 2012 11:31:39 -0700
Message-ID: <7vpq9dobjo.fsf@alter.siamese.dyndns.org>
References: <jqlim2$6vt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Peijnik <stephan@peijnik.at>
X-From: git-owner@vger.kernel.org Tue Jun 05 20:31:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbyXj-0003dM-GS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab2FESbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab2FESbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:31:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5141E8E53;
	Tue,  5 Jun 2012 14:31:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+p32Xs4YSbidKhLR1pEYAWlrtxY=; b=Q/NCH2
	Jy9WDx8SgwQfOnjRG1mgrm9Yqxx03xEmI+hLXv4Sc9i814UCdxfH26jzmTyvGXlU
	P5oqUU1/ZmRz+ec1dcbUYNEKXgxPwQZerVigpYSxph8iDnfoSAbajRSk59Jml9Vb
	vtkuRmw/v6x4xW3RflwAxG/4cNiid+wWwOyOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mEPuCiVxrZKxTHSLu1K0U8nwle2gJlDi
	8gEyDknbuP0XQYq57lRFyN2UzmRjrPZdFbpknpBrqpfllh30aahvOUohChNwh1JI
	tZIb43zwPVrxMz8/JSkV3M8Dil4wZ1OzhVHBVPb2X0xEMyQuWgOMEMfiJqKY5ouR
	eTE+poYWq2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 480628E52;
	Tue,  5 Jun 2012 14:31:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D45158E4E; Tue,  5 Jun 2012
 14:31:41 -0400 (EDT)
In-Reply-To: <jqlim2$6vt$1@dough.gmane.org> (Stephan Peijnik's message of
 "Tue, 05 Jun 2012 20:20:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B21A53AC-AF3C-11E1-A414-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199276>

How does this compare with the smart-http support that tunnels the
git protocol over http (with some butchering)?
