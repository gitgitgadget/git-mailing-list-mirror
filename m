From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] config: Make git_config() more flexible
Date: Wed, 18 Feb 2009 14:01:38 -0800
Message-ID: <7vvdr7tnel.fsf@gitster.siamese.dyndns.org>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <7viqn7v47s.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902181330o298fce1am31d9d15145956d78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZuVh-0002F6-4A
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 23:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbZBRWBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbZBRWBq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:01:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbZBRWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 17:01:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AE62B9AF89;
	Wed, 18 Feb 2009 17:01:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BD859AF88; Wed,
 18 Feb 2009 17:01:40 -0500 (EST)
In-Reply-To: <94a0d4530902181330o298fce1am31d9d15145956d78@mail.gmail.com>
 (Felipe Contreras's message of "Wed, 18 Feb 2009 23:30:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB057DBE-FE07-11DD-9798-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110585>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> What I'm trying to do is "Make git_config() don't return an error when
> there's no repo config file if there are other config files
> available"... I thought there was no short way to say that =/

git_config(): not having a per-repo config file is not an error

Please drop the full-stop at the end of the Subject: line, by the way.
