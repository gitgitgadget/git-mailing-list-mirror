From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http-push: refactor request url creation
Date: Thu, 29 Jan 2009 09:25:22 -0800
Message-ID: <7vk58ef2il.fsf@gitster.siamese.dyndns.org>
References: <4981C43B.9030409@gmail.com>
 <alpine.DEB.1.00.0901291608330.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 18:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSafI-0006dw-4Q
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 18:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZA2RZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 12:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbZA2RZa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 12:25:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZA2RZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 12:25:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 754922A067;
	Thu, 29 Jan 2009 12:25:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C12C42A05A; Thu,
 29 Jan 2009 12:25:24 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901291608330.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 29 Jan 2009 16:10:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D28F9FAC-EE29-11DD-B95C-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107705>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 29 Jan 2009, Tay Ray Chuan wrote:
>
>> Currently, functions that deal with objects on the remote repository have to
>> allocate and
>> do strcpys to generate the URL.
>
> That is a funny way to wrap the commit message :-)

That's format=flowed in action, isn't it?
