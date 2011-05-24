From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #10; Mon, 23)
Date: Mon, 23 May 2011 20:22:12 -0700
Message-ID: <7vhb8kail7.fsf@alter.siamese.dyndns.org>
References: <7v8vtxrlq1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Eric Wong <normalperson@yhbt.net>,
	Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 24 05:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOiCZ-00063t-BD
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 05:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1EXDWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 23:22:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1EXDWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 23:22:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46EB25625;
	Mon, 23 May 2011 23:24:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kZadXVNiqirVf+PM55bpecRDBrc=; b=oCA2YR
	4ulfX2QmKp43CEYjzeuEJEPBRy+agCuuXPwoATowoxDZGBthEC0iXgtmkJnDsufZ
	9+KyxriuxhzXECAVa/yz22d0z8s7QiAP6UnY6o2CuCLx8cgZZsGqxZCA87xGygTE
	t2DRb6KGBN8hfgwEJMPNEFjc5uw2sgKQAKAOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TxT4dQin7PrM/ImXjnpb3BNQfORowh5i
	KaFe0f8c0rGccF5JgoWdZG4WTcglKc6c06maxwTlbL2YOFQyHCKoi1i3DEtGrh2/
	RDeT5aoI0to1stei1ebjkF6DJ0EiP94N40hBg0iB+6GjKb8MxFS+qc6g/0OC5Z2R
	Wrk9QpzxEDw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB2A15617;
	Mon, 23 May 2011 23:24:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 366B45609; Mon, 23 May 2011
 23:24:21 -0400 (EDT)
In-Reply-To: <7v8vtxrlq1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 May 2011 17:22:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55EAEF6C-85B5-11E0-A220-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174312>

Just a friendly reminder to people who are in charge of various
subsystems. I'd like to close the "feature enhancement and new bugfixes"
phase of this cycle at the end of this month, so please plan to throw a
"pull this" direction at me soonish.

It is very much more preferrable to see subsystems more or less in a good
shape as the rest of the system by 1.7.6-rc0, rather than "now the main
part is quite good at -rc2, do subsystem folks have anything for me to
pull?" as we used to do in previous cycles.

Thanks.
