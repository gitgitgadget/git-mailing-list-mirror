From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 19:41:23 +0100
Message-ID: <53C42453.1090109@ramsay1.demon.co.uk>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>	<1405140276-32162-4-git-send-email-dturner@twitter.com>	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>	<53C41456.2000006@ramsay1.demon.co.uk> <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6lBt-00053p-5F
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 20:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316AbaGNSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 14:41:30 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:46970 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752490AbaGNSl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 14:41:28 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 3EC06AC40B4;
	Mon, 14 Jul 2014 19:41:40 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id E50ACAC40B3;
	Mon, 14 Jul 2014 19:41:39 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Mon, 14 Jul 2014 19:41:39 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253507>

On 14/07/14 18:51, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> that the merge commit 7608c87e fails. Looking at the details of the
>> merge resolution, made me think of Duy's split index work.
> 
> Yes, there is a deliberately dropped hunk from dt/cache-tree-repair
> in that merge, because the topic relied on being able to say "here
> is the file descriptor, write the index to it", which no longer is
> available with the split-index topic.

Ah, OK. Sounds like everything is under control then.

Thanks.

ATB,
Ramsay Jones
