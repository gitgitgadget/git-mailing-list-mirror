From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitk: Replace "next" and "prev" buttons with down and up arrows.
Date: Thu, 23 Jan 2014 08:51:39 -0800
Message-ID: <xmqq38kewsfz.fsf@gitster.dls.corp.google.com>
References: <20131008193618.GE9464@google.com>
	<1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
	<52DE932E.7090008@xiplink.com>
	<20140122110448.GB7306@iris.ozlabs.ibm.com>
	<xmqqa9enydm4.fsf@gitster.dls.corp.google.com>
	<20140123110847.GA12814@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Lucas Sandery \[three am design\]" <lucas@threeamdesign.com.au>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 17:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6NX3-0001Ca-Fb
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 17:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbaAWQx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 11:53:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbaAWQxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 11:53:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C9965BEE;
	Thu, 23 Jan 2014 11:53:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Qzg0VmmZUZpHx+KeFEytmaYRe30=; b=pa23WZrI+G2U2sIRp6+V
	nvbRiwlvbP+aPaKwTbhywwUpmLCO5GXcYJmyvm19hW8RNd7egaJ/xqOepl2V8Wcd
	oXbvKMTJzgW943D2XzkXip40KL8IbU8OvIB1xeAQaiqrGdbmQG4y2cs2anmlG2cN
	nn+7+2cuffGnPsse4Y1Mhf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SzTXc2SYfZFpZgYJ439GjlM9AE4Iv4ThdkHZlimtrslFhk
	OgM5ItDmnAPq4GixJsNhVoP0H+swIVmlwVbUXEtM6jbSubNy34SQRvNuEuOCUZZW
	KY7ulWJ0VB+r1XzuR+5bory2t7aNKqalYWMj33rnefx7SrXskUftxB9TuNAbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 069D765BEC;
	Thu, 23 Jan 2014 11:53:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 193DB65BEA;
	Thu, 23 Jan 2014 11:53:22 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DEC6AEDA-844E-11E3-9DD1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240918>

Paul Mackerras <paulus@samba.org> writes:

> Yes, please pull.  I have just pushed one more:
>
> 	76d64ca gitk: Indent word-wrapped lines in commit display header

Thanks.
