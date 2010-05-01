From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Revert hunk?
Date: Sat, 01 May 2010 23:38:46 +0200
Message-ID: <4BDC9F66.5090305@kdbg.org>
References: <loom.20100501T215211-11@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Sat May 01 23:39:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8KOy-0000ww-2o
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 23:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab0EAVi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 17:38:59 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:19467 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752550Ab0EAVi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 17:38:58 -0400
Received: from [77.117.136.65] (77.117.136.65.wireless.dyn.drei.com [77.117.136.65])
	by bsmtp.bon.at (Postfix) with ESMTP id E7315CDF86;
	Sat,  1 May 2010 23:38:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <loom.20100501T215211-11@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146120>

Am 01.05.2010 21:54, schrieb Steve Folly:
> git gui has an option to revert changes, but that applies
> to the whole file. Is there an option to revert a line
> or hunk rather than the whole file?

Stage everything except that hunk or line, and then revert.

-- Hannes
