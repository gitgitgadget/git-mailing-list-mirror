From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: skip logo in atom feed when there is none
Date: Tue, 04 Jan 2011 16:45:48 -0800
Message-ID: <7v62u4dvpf.fsf@alter.siamese.dyndns.org>
References: <20110104050206.GA8280@burratino>
 <20110104050247.GB8280@burratino> <201101050125.52824.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 01:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaHW2-0005J0-E5
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab1AEAqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:46:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1AEAqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:46:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94AED3DD6;
	Tue,  4 Jan 2011 19:46:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTg6M9tyEzkrhuE1ryzdOKxRs2E=; b=NiFunF
	zQ2bH29tM5HlEaEt1D9UuXidBHCvvhaEP9ALKZIE0JIjXDIsGZHIvubk7/F54i6F
	KRs67tq6rwCPCO0ZJxKsZEzgrf9jUhhMf98QSJVyi1zta+OuBOy/3S6QwoU6G5HL
	66M9bbh0RUF4lZQ6PZrpajztoUDcApxKImm+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSMNRZXqHpMVo2Mz7yCseGnh1X9aq/j2
	/lng/nGsPNWEPGLCRfB0XLM6WLNGxbs+FGaooOpQtb6f4rHD1Xq5w0WOQLltTip9
	7Kq3eI9pmTCIKmLSrqjbHOpB3u02Km4m+jBmhpkftFOJlfmfk4+geqa4qxSg5Uka
	5x45o/04VVQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44BDA3DD0;
	Tue,  4 Jan 2011 19:46:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF1063DC8; Tue,  4 Jan 2011
 19:46:28 -0500 (EST)
In-Reply-To: <201101050125.52824.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 5 Jan 2011 01\:25\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F36D168-1865-11E0-A59D-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164533>

Thanks, all.
