From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep -I bug
Date: Mon, 02 Feb 2009 20:30:43 -0800
Message-ID: <7v1vugf8gc.fsf@gitster.siamese.dyndns.org>
References: <20090202174257.GA8259@Ambelina.erc-wireless.uc.edu>
 <7vwsc8hgh4.fsf@gitster.siamese.dyndns.org>
 <20090202182601.GA173@Ambelina.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy O'Brien <obrien654j@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUCxd-0005Vc-0m
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZBCEax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZBCEav
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:30:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbZBCEat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:30:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77BF596328;
	Mon,  2 Feb 2009 23:30:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6364C96327; Mon,
  2 Feb 2009 23:30:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E6333B0-F1AB-11DD-84ED-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108143>

Jeremy O'Brien <obrien654j@gmail.com> writes:

> On Mon, Feb 02, 2009 at 09:54:31AM -0800, Junio C Hamano wrote:
>> Jeremy O'Brien <obrien654j@gmail.com> writes:
>> 
>> > I am running git version 1.6.1.2.309.g2ea3.
>> >
>> > When I use
>> >
>> > git grep -I "string_to_match"
>> >
>> > to ignore binary files in my grep, binary files are returned anyway.
>> 
>> One sanity check.  What does 'git grep --cached -I "string_to_match"' do
>> in that case?
>> 
>
> It works as expected. It is interesting that while my Linux install was
> affected by this bug, my Mac OS X install did not seem to be affected by
> it, while running the same version of git.

Perhaps your Mac OSX binary was built without external grep support.

Did the patch fix the issue, by the way?
