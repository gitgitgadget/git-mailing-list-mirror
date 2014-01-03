From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: notice gc processes run by other users
Date: Thu, 02 Jan 2014 16:15:11 -0800
Message-ID: <xmqq61q1or8w.fsf@gitster.dls.corp.google.com>
References: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
	<02BCE0EB-ADA1-48F9-BD00-369FFDB5E372@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kyle <kiltnaked@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 01:15:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VysQ6-0003Py-3M
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 01:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbaACAPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 19:15:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494AbaACAPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 19:15:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52DDF60677;
	Thu,  2 Jan 2014 19:15:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=bfV1lB
	sMFcfFX3l5zHcjOnBCHecNIShsi6i/lDsM8yRUknDQB0VfUZOMvz7kh77ZKeGIC0
	wWPBZgWVOcp57chekcH1PH4yr77QRqzsy13wtrYYhqhGAKPGAEBsBcxAgra78jEF
	tLNVUDlSJuItSMpqfXdnw6hHwEmAaqR3i4bKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jlXk+iSZ9eHsebfU/yFlt2g6Zj7ZgCJ4
	CcnIEC+g1cIRfNyrPRiQCuOn1dH/7MBJhG2u2o4fFEy9uM3usdRnLIWFiTlBFOIo
	JHyw04Ppsixw0m4bk60rkTbZfTXU7DS+P4jdZfJFIDgSXVUV2LQxN92z2v+SEXk4
	7SR7sBvpoJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40ACE60676;
	Thu,  2 Jan 2014 19:15:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9544860675;
	Thu,  2 Jan 2014 19:15:13 -0500 (EST)
In-Reply-To: <02BCE0EB-ADA1-48F9-BD00-369FFDB5E372@gmail.com> (Kyle's message
	of "Thu, 2 Jan 2014 16:11:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D98CB64-740C-11E3-914F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239898>

Thanks.
