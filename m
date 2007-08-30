From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-archimport log entries more consistent
Date: Thu, 30 Aug 2007 14:46:49 -0700
Message-ID: <7v3ay08zli.fsf@gitster.siamese.dyndns.org>
References: <617indss2f.fsf@fencepost.gnu.org>
	<7vmyw9af3q.fsf@gitster.siamese.dyndns.org>
	<fc339e4a0708292019s3d4f6914h4f9efe6f1172c380@mail.gmail.com>
	<7vir6xacha.fsf@gitster.siamese.dyndns.org>
	<86myw9jwga.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQrqr-0007IG-QO
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761243AbXH3Vqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760862AbXH3Vqx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:46:53 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759500AbXH3Vqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:46:53 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EBFB12ADF5;
	Thu, 30 Aug 2007 17:47:12 -0400 (EDT)
In-Reply-To: <86myw9jwga.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Thu, 30 Aug 2007 09:47:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57075>

David Kastrup <dak@gnu.org> writes:

> ... but given that the previous format was
> not declared canonical at any point of time, the question is whether
> anyone will indeed notice before things break.

I tend to agree with you.  archimport is so specialized that if
you are not using it you would not care, and small population
who are using it and relying on the old behaviour would notice
breakaage right away, so "Let's see who screams" sounds like the
right thing to do.
