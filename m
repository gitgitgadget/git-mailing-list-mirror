From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] git p4 test: remove bash-ism of combined
 export/assignment
Date: Thu, 16 Aug 2012 20:08:50 -0700
Message-ID: <7vboiaxlj1.fsf@alter.siamese.dyndns.org>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
 <1345160114-27654-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2CwN-0000k2-1D
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933635Ab2HQDIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:08:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933161Ab2HQDIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:08:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F109DA6;
	Thu, 16 Aug 2012 23:08:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Xs5DF5
	dHg4Ov8WWE6TOgFx7F1m1IPD4xBYjBmvjLMaWB+B95MUX7HnNVk1yJGq0+uXkrUi
	bKqi4KyyPO+kGjWQxbTpOJCHSLR9qAAMy2sDt6WWG98K02f1t03aQGdKH21tlw2T
	nrwX/gTuJUIIUyT0Wj3gUmq2RTxlJCLl3GPBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bn4PS+/0P4SUuqk9p3KlVoHtvUnUvm0/
	faRhzq8ITxGOJFmLMie1rhf9YijRrmaQjPzyRd51GTIqy4+y5ut6o3Jj4Ku0kW2R
	IM9wPMSIUnX+Z89lAc6KxNDTMW6sekGOOGUd/TvbiUuZEQsPQxMQyyxOlvstrNIp
	P2NIOgkyLVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B219DA5;
	Thu, 16 Aug 2012 23:08:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34C809DA4; Thu, 16 Aug 2012
 23:08:52 -0400 (EDT)
In-Reply-To: <1345160114-27654-2-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Thu, 16 Aug 2012 19:35:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF5F1A2C-E818-11E1-84A9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
