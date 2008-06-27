From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding a 'version' command to the server
Date: Fri, 27 Jun 2008 16:15:13 -0700
Message-ID: <7vej6io4fy.fsf@gitster.siamese.dyndns.org>
References: <7viqvupm3l.fsf@gitster.siamese.dyndns.org>
 <486572BC.9070201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 01:16:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNB5-00020F-U9
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 01:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765981AbYF0XPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 19:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765959AbYF0XPY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 19:15:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765420AbYF0XPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 19:15:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63C31E37B;
	Fri, 27 Jun 2008 19:15:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D3C00E37A; Fri, 27 Jun 2008 19:15:16 -0400 (EDT)
In-Reply-To: <486572BC.9070201@gmail.com> (Lea Wiemann's message of "Sat, 28
 Jun 2008 01:07:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8E71396-449E-11DD-9739-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86675>

Lea Wiemann <lewiemann@gmail.com> writes:

> Junio C Hamano wrote:
>
>> It is still possible to connect to older remote end with new clients, but
>> you have to explicitly ask for "git-upload-pack" by using --upload-pack=
>> option when running "git fetch"
>
> Now that the current git won't work with older servers anyway,...

Whoa, Wait.  Who said that?
