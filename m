From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be
 sha1 based
Date: Fri, 28 Mar 2014 07:52:11 +0100
Message-ID: <53351C1B.6040609@viscovery.net>
References: <cover.1393257006.git.kirr@mns.spb.ru>	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>	<20140325092215.GB3777@mini.zxlink>	<xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>	<20140326195201.GB16002@mini.zxlink>	<xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>	<20140327142438.GE17333@mini.zxlink> <xmqq1txneavo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, kirr@mns.spb.ru,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 07:52:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTQeO-0000Ig-3q
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 07:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaC1GwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 02:52:19 -0400
Received: from so.liwest.at ([212.33.55.23]:45132 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbaC1GwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 02:52:18 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WTQeB-0002ms-Nf; Fri, 28 Mar 2014 07:52:12 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7A71916613;
	Fri, 28 Mar 2014 07:52:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq1txneavo.fsf@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245364>

Am 3/27/2014 19:48, schrieb Junio C Hamano:
>> From: Kirill Smelkov <kirr@mns.spb.ru>
>> Date: Mon, 24 Feb 2014 20:21:46 +0400
>> ...
> 
> By the way, in general I do not appreciate people lying on the Date:
> with an in-body header in their patches, either in the original or
> in rerolls.

format-patch is not very cooperative in this aspect. When I prepare a
patch series with format-patch, I find myself editing out the Date: line
from all patches it produces again and again. :-(

-- Hannes
