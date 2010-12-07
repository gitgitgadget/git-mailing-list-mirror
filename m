From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/6] web--browse: better support for chromium
Date: Tue, 07 Dec 2010 15:38:18 -0800
Message-ID: <7vy681m9w5.fsf@alter.siamese.dyndns.org>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291657790-3719-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 00:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ77G-0003lA-B7
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 00:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0LGXib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 18:38:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0LGXib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 18:38:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8056936E8;
	Tue,  7 Dec 2010 18:38:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4q2IEhT2WHD5kLOtR3I4JeUa+3A=; b=JwAb8TJ1mu8CWwGQnHAZTXi
	6qiIk3M9A249kv/UBD4FxHm07n+T8R9jlxTDowfn8kkVvyj3Eb1DWW4UQDBmniqS
	eRke/bl+gnFoxjf8xl5pP99b7bcYQ5F2MuNyBbnU2Bl1z8Xnpcnww7F0FV2K9//2
	ztzi+Q8GXvdkgCoHgI1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=l8bI0rH3b13VGdg/gDtM9/glwDuqfMeuRIB72DCKdqrb6LDbx
	wXWHbAobbVd/6lbUpyT7ds0bUdjzZWP/mf34DB0//BhGgZrP5wwaypFHB5PbcsTX
	rT7QZrpBE08CPyD3/9d4BxnA6iXTumWXsfgANMWZzH0O00vS930gKdl7no=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E34D36E6;
	Tue,  7 Dec 2010 18:38:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A1FEA36DF; Tue,  7 Dec 2010
 18:38:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24B39828-025B-11E0-9CD9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163149>

Up to this point of the series, I think v3 is a regression compared to
what is queued on 'pu'.
