From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] imap-send: create target mailbox if it is missing
Date: Fri, 01 Aug 2014 15:30:36 -0700
Message-ID: <xmqqppgju9kj.fsf@gitster.dls.corp.google.com>
References: <alpine.LSU.2.00.1407312034410.25674@hermes-1.csi.cam.ac.uk>
	<alpine.LSU.2.00.1408010915500.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:30:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLLe-0006N3-TB
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbaHAWar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 18:30:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59605 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaHAWaq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 18:30:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1338D2EDC7;
	Fri,  1 Aug 2014 18:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ado6ImIvxmjs246QkBnodu53pho=; b=rvMZ9A
	/w0W+PmA4yZ+/QETiB6uD9Ld/wguHnmDwW2yvugObToUImsEQ5cm4WX1XWpR+pA5
	le/y3iJR21WmlZ7pMss+MtBmjwcsKNV/sQ8CwZRUQ0WtHXNww9DJPbmLLQTSyY35
	/tIdjPmxCV5LqYxCpdNFMJCDzUg5k9x3xke1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ma9TatVTXTpknfZ1wa2wKQhyrn+nBTmk
	1olOsPrcj/A/lhh7FomIUH506mAKU7TLXecDIgst+52m5wyHrYXBrbVENvSO+dbf
	G+SxgYNownFAXrj4jJjEy/K/R2QyY2PSOv4lUbHxeHTMPbRN3d2XPVqjg5Gz1ih3
	xfyzRfHVISI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A2812EDC6;
	Fri,  1 Aug 2014 18:30:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9FA642EDBC;
	Fri,  1 Aug 2014 18:30:37 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.00.1408010915500.23775@hermes-1.csi.cam.ac.uk>
	(Tony Finch's message of "Fri, 1 Aug 2014 09:15:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75FEDF5E-19CB-11E4-9E0B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254676>

Tony Finch <dot@dotat.at> writes:

> Some MUAs delete their "drafts" folder when it is empty, so
> git imap-send should be able to create it if necessary.

Thanks for an update; queued.
