From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] avoid set-but-not-used warning
Date: Fri, 29 Apr 2011 09:28:06 -0700
Message-ID: <7vwridxbs9.fsf@alter.siamese.dyndns.org>
References: <874o5hv1f2.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:28:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqYY-00065Y-MR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760048Ab1D2Q2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:28:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759868Ab1D2Q2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:28:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED5ED5197;
	Fri, 29 Apr 2011 12:30:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=E1CxdtgtxyroVDjuQH8p
	UgPdLo3atkt7B3+rL1il9nZazEDRanBYLDLseEPyNAKFj198OtEM5ff6l4lMIij7
	iudwe2PX6qOxvLg4f9Vd4LOauTpzNQQvlwtyARnkJuuYgEF5mScSNIprJ5FUy4sL
	ep6DHbW0VPi9ld4dd+THLh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=CXdWD9qZygnwdG1WXaie3l62Gz3bNCLvmaHscaJR/1Kge+
	ddbK+hIznUzXXd1IvF1P7aowz4D3ipKS62a0AxViiv2ZoHHud1+HdAg6AMsi5dDX
	SUwv3lcba9xBtPZ2+EXPdBLPQH6QlVsfznFRFEO8rNsKG2oA5867QU70rx9UI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C94BC5196;
	Fri, 29 Apr 2011 12:30:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE9615195; Fri, 29 Apr 2011
 12:30:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F58F49D2-727D-11E0-91FE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172465>

Thanks.
