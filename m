From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10] tag: support configuring --sort via .gitconfig
Date: Tue, 22 Jul 2014 10:32:54 -0700
Message-ID: <xmqq8unlguyh.fsf@gitster.dls.corp.google.com>
References: <1405547282-19815-1-git-send-email-jacob.e.keller@intel.com>
	<1406049919.30094.7.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:33:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9dw4-0002TR-LA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 19:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbaGVRdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 13:33:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55248 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888AbaGVRdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 13:33:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB18D2AFE1;
	Tue, 22 Jul 2014 13:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2L2xjTvIhtxMykMS+zWbU16Q/M=; b=Wn4clU
	HKLNp6q1qgZFi7TgsvaKePAWjEVnXWjhq1yBoSzkJHKSgTIixawRkb3OxM/vZbZe
	W7lxPZuo5y9/yyE6UZMRV06+qJWwDCcddWid9kuLl8Ky+xOzzsab1dINte8LIKoG
	Mc3GNgtEyvQLR29cZCVPk6qYfnDgrHOKBYjRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sqf1reG1c2m/TNiJYixAO386+t0J82JA
	xzl+5zHM6IGcbjkYnBIf0yihfmfdE3unaMe7J/znmfWABx/7DpPUU6BWQPckaILd
	A+9vPqi93CC0OJCm91PhHqef7mprr9kFvDFnZYSr3iZUwhUG1IwfNMc3Vg+vGM0Z
	KefjjOPxjAc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FB6C2AFDF;
	Tue, 22 Jul 2014 13:33:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A31382AFDA;
	Tue, 22 Jul 2014 13:32:56 -0400 (EDT)
In-Reply-To: <1406049919.30094.7.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Tue, 22 Jul 2014 17:25:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37E35DB0-11C6-11E4-B300-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254024>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> Just a ping on the status of this patch?

I wrote that v10 needs to be picked up in the last "What's cooking",
I think I did so already and pushed out the result somewhere between
'master' and 'pu'.
