From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/19] new git check-ignore sub-command
Date: Fri, 28 Dec 2012 13:23:31 -0800
Message-ID: <7vpq1thnvw.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TohPF-0005Ze-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 22:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab2L1VXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 16:23:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab2L1VXe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 16:23:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B17EFAB95;
	Fri, 28 Dec 2012 16:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/J5+33IcVIdUIuYMKOWSZtmAc7w=; b=UPQFVQ
	/iiYXbStCN+BmBdFSBzPADXncq3iu/A2GSs1XpjvwCuCL//QEPW3MjvQ2WiXjjyb
	O8V+7Gdbsjb+ASBLSi2fBSsf275xm/jPvMkl6yd9oJXBrJgO3mEjEdSYx/LjVTo+
	ADXlzM9QMOCdHKsEuwrwiFMJvS0AF04o68H+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SqdoacKbaNQRoXsFAHP5fNUkAC1HbZHM
	kisVJfbNUQBZ+xrXDwHacVYo1zSYa06PC/no0aL/HNP4ZIuzlZ4/gfZX2IXgdO2Q
	UTM4b4o5sdDyrJzNf4no4d+Yn143UPnLFIhwPuz/W4Wp544gpdfCFZmJJC+iwjhT
	T0M+OfcppQ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F911AB94;
	Fri, 28 Dec 2012 16:23:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F284AB93; Fri, 28 Dec 2012
 16:23:33 -0500 (EST)
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D52F79FE-5134-11E2-8A83-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212267>

After skimming the series twice quickly, I found that the early part
of refactorings are excellently done.  Making existing private
functions into public needs a lot more careful thought on namings, I
think, though.

The end result looks promising.  Thanks for a pleasant read.
