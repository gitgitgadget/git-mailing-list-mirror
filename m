From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] Move fetch_ref from http-push.c and http-walker.c to http.c
Date: Mon, 10 Dec 2007 21:09:05 -0800
Message-ID: <7vve75hl72.fsf@gitster.siamese.dyndns.org>
References: <1197322571-25023-5-git-send-email-mh@glandium.org>
	<1197328105-4843-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:09:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xNC-0001qQ-T2
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbXLKFJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 00:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbXLKFJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:09:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbXLKFJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 00:09:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BBDBD226A;
	Tue, 11 Dec 2007 00:09:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD022266;
	Tue, 11 Dec 2007 00:09:07 -0500 (EST)
In-Reply-To: <1197328105-4843-1-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Tue, 11 Dec 2007 00:08:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67788>

Mike Hommey <mh@glandium.org> writes:

> Make the necessary changes to be ok with their difference, and rename the
> function http_fetch_ref.

Sorry, but I cannot parse "ok with their difference" part...
