From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC]  test-lib.sh: preprocess to use PERL_PATH
Date: Fri, 22 Jun 2012 22:22:33 -0700
Message-ID: <7vsjdmli06.fsf@alter.siamese.dyndns.org>
References: <201206230704.38648.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 07:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiIoW-0004j8-PC
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 07:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab2FWFWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 01:22:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587Ab2FWFWg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2012 01:22:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51D4E50A9;
	Sat, 23 Jun 2012 01:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ebHSa6zFkukA
	x6lyTIo5n5T7OaQ=; b=QU80YJVsAG2QQhaz6SHNxlkh+9ZCLn2Me+SJ9RfUCTup
	Wu+xungd7zVeZdjWwF5DTnmn79v3e5BLJU42REt8zo45Sy3C1jK60DZFIZIjsHqu
	hZuuEIkcHDbeMhwalklYJLwyMZc2yf04bopDDHhDMzuEWhuUYUfV7VBwhYjEzLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OxjGk0
	hPj/bn+o0hjJkxV959zHKiJew4jMLq/fjXX2yPYQ9Onmhd58syygzicj39oU3dyS
	VtnLHU60j66U7uoDnEWBjOg0thYHatw5HIj88FL/EI7rL70yuCxwIgEZxoaEQYvc
	5U4OjcUsKvrCrmGOw1TGE03/vMqA/17y/wEI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47B6B50A8;
	Sat, 23 Jun 2012 01:22:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D038050A7; Sat, 23 Jun 2012
 01:22:34 -0400 (EDT)
In-Reply-To: <201206230704.38648.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 23 Jun 2012 07:04:37
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70849DD4-BCF3-11E1-A2B6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200491>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> All test cases found in t/*.sh must include test-lib instead of test-=
lib.sh

Please don't.  That is too much churning for too little gain, I am afra=
id.
