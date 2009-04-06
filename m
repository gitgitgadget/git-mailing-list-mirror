From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 05 Apr 2009 23:18:27 -0700
Message-ID: <7vab6ucnkc.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com>
 <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <20090406055301.GA17080@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 08:20:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqiBy-0005RK-Hg
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 08:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZDFGSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 02:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbZDFGSj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 02:18:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZDFGSi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 02:18:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 353DAA867B;
	Mon,  6 Apr 2009 02:18:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2F64CA867A; Mon,
  6 Apr 2009 02:18:28 -0400 (EDT)
In-Reply-To: <20090406055301.GA17080@gmail.com> (David Aguilar's message of
 "Sun, 5 Apr 2009 22:53:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3105ADA-2272-11DE-B8B5-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115771>

David Aguilar <davvid@gmail.com> writes:

> Ah, I know the answer:
>
> http://kerneltrap.org/mailarchive/git/2008/11/12/4072144
> http://kerneltrap.org/mailarchive/git/2008/11/12/4067114
> http://kerneltrap.org/mailarchive/git/2008/11/2/3896104
>
> I did say it *seemed* appealing, not that it actually was ;)

Heh, I forgot all about that.

What is sad about it is that I back then predicted that we will regret
"diff --staged".

  http://kerneltrap.org/mailarchive/git/2008/11/11/4056664
