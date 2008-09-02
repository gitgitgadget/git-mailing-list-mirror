From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Move call_depth and index_only to struct
 merge_options
Date: Tue, 02 Sep 2008 15:39:33 -0700
Message-ID: <7vk5dui34q.fsf@gitster.siamese.dyndns.org>
References: <7v1w02l3jc.fsf@gitster.siamese.dyndns.org>
 <cover.1220392547.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaeYJ-0003YP-9n
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYIBWjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYIBWjl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:39:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYIBWjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:39:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A25815B58F;
	Tue,  2 Sep 2008 18:39:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 180E35B58A; Tue,  2 Sep 2008 18:39:35 -0400 (EDT)
In-Reply-To: <cover.1220392547.git.vmiklos@frugalware.org> (Miklos Vajna's
 message of "Wed, 3 Sep 2008 00:05:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07315DD6-7940-11DD-A0BE-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94730>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Sep 02, 2008 at 01:02:31PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> I found it a bit disturbing that "index_only" and "call_depth" were
>> not
>> part of merge_options structure.
>
> Here are two patches to do it, on top of current mv/merge-recursive.

I suspected that it always holds that "index_only === !!call_depth".

Shouldn't strbuf obuf be part of the merge_options structure that
describes the current call status?
