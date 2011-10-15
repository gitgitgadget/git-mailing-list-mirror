From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare
 3 on Windows
Date: Sat, 15 Oct 2011 13:14:16 -0700
Message-ID: <7vty79vrdn.fsf@alter.siamese.dyndns.org>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
 <1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
 <7vobxix0pk.fsf@alter.siamese.dyndns.org> <4E996012.8090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCQP-0006o3-4X
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab1JOWJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:09:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab1JOWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 18:09:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9DC35B15;
	Sat, 15 Oct 2011 18:09:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=TUe6E8v/Lb3yBlc+GBpWnKJQjpA=; b=Tp+iZixfC2MeLc5QkWmC
	SrwvnBppJnj8lJJB3CpLlTeOBO85zv1V/7zFu0WnMlfWwwef0qP0R4HAP1fpXF5g
	sNpQr6TNTlCN/HwE51wpJstx43nC3VAOYe8GuP4Yo6vD9L2RnzpoERaVttp1IHvS
	IU0xdpYjka1sWEWPcngWpxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cvS3LmF81E1tZs78FLOhSBCXK/QIpGBHteKN8ODBsfbxCk
	o0Q3u3RZt6hxeuSn6q8KQXCEyTxgUpsJG3uOtZELPvzoFr2e0Ntu+q1KG6diAYNr
	U4uBbz7rin0deX+urxXxeY3PcuyDizwsKTd+tjKImcs0f8EE/5WRNynPmI8Nw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D935B13;
	Sat, 15 Oct 2011 18:09:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77D3B5B12; Sat, 15 Oct 2011
 18:09:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6180B2B2-F77A-11E0-8C3D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183675>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On 15.10.2011 07:50, Junio C Hamano wrote:
>
>> Hmm, does this only apply to Windows, or are there other platforms on
>> which BC3 supplies bcomp for the exact same reason? What I am trying to
>
> BC3 is only available for Linux and Windows, so it only applies to
> Windows currently.

Who asked anything about "currently"?
