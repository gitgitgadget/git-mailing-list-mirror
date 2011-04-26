From: Jonas Gehring <jonas.gehring@boolsoft.org>
Subject: Re: [PATCH/RFC] Implemented return value for rev-list --quiet
Date: Wed, 27 Apr 2011 01:31:30 +0200
Message-ID: <4DB755D2.10303@boolsoft.org>
References: <4DB748F5.4050300@boolsoft.org> <7vwrigbor6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QErhH-0004gY-EC
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 01:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab1DZX3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 19:29:22 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:49686 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1DZX3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 19:29:22 -0400
Received: from [109.193.12.52] (helo=[192.168.10.4])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <jonas.gehring@boolsoft.org>)
	id 1QErh1-0001vL-5l; Wed, 27 Apr 2011 01:29:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Lanikai/3.1.9
In-Reply-To: <7vwrigbor6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-Df-Sender: jonas.gehring@boolsoft.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172135>

On 04/27/2011 01:02 AM, Junio C Hamano wrote:
> Given two commits A and X, "rev-list --objects A..X" is a way to make sure
> that everything between A and X exists.

Thank you for this explanation, this really cleared up the intended
usage of --quiet for me. I wanted to use it for ancestry testing of two
commits, noticed the hard-coded return value of '0' in cmd_rev_list()
and thought that the implementation is probably missing.

After some additional digging, I realized that git-merge-base is the
right tool for my task.

Regards,
Jonas
