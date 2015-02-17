From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/13] Allow reference values to be checked in a transaction
Date: Tue, 17 Feb 2015 11:29:04 -0800
Message-ID: <xmqqbnks2v7j.fsf@gitster.dls.corp.google.com>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNnpd-0003Zj-3f
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 20:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbbBQT3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 14:29:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752588AbbBQT3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 14:29:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 037E9376BA;
	Tue, 17 Feb 2015 14:29:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5VpdBW0dbgj6t7MwGRdF2HSp860=; b=PHYwRf
	Xgl5sE8Fav55f95O8N0RnfBUiGGNLxGsS/WbvTPI1s4cAraHXS+2HHYWire2kImK
	Sxg/gF+pmG7W/zCXtyPj5Ns3QCQZ1wb0P/6sbPLAAS7ZdpizZAfKQarb7gGtmYyR
	ML+NIcbFfWnzKNzoE3KjHP5runXbMCAvKsgd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+ypXdhK1/txXead4ytTwBCBIBTn3LhI
	wtLeGnealsVgUU0z7Lfexm4Rsb3zrz4Wiz1dJNqa8JR5nQNzIFUYd8D47XzOpSLm
	Eqi9ntFqINTd/gymyTdN0YGHeN4ruzYBlYeAU3URzhda4utTGu52hVTi87jjbqzN
	3V3q9f6+/kU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9AE0376B6;
	Tue, 17 Feb 2015 14:29:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6624E376B5;
	Tue, 17 Feb 2015 14:29:05 -0500 (EST)
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 17 Feb 2015 18:00:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C566C88-B6DB-11E4-9434-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263977>

All looked sensible from a cursory read.

Will replace, wait for a few days and will merge to 'next' unless I
hear otherwise from others.

Thanks.
