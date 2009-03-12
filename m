From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 11:31:05 -0700
Message-ID: <7vbps6lhjq.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:33:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhpi9-0004uL-Qy
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbZCLSbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 14:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbZCLSbQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:31:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbZCLSbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 14:31:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 53E7F52A3;
	Thu, 12 Mar 2009 14:31:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B650F52A1; Thu,
 12 Mar 2009 14:31:07 -0400 (EDT)
In-Reply-To: <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
 (John Tapsell's message of "Thu, 12 Mar 2009 13:18:21 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6A354EE-0F33-11DE-9EDA-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113102>

John Tapsell <johnflux@gmail.com> writes:

> I'm saying that:
>
> git checkout -b origin/mybranch  origin/mybranch
>
> Is probably a mistake by the user.  We should warn the user and point
> them in the right direction.

Given Finn Arne Gangstad's use case in a nearby thread, I do not think you
can so easily declare that it is a mistake by the user.

We have traditionally encouraged people to track remote origin/<name> with
matching local <name>, but in a workflow that interact with multiple
remotes, one obvious way to map would be to track remote origin/<name>
with local origin/<name> branch.  You can say remotes/origin/<name> when
you mean the remote tracking one, and say heads/origin/<name> when you
mean the local one, in order to disambiguate in such a setting.
