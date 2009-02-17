From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bash: update 'git svn' options
Date: Mon, 16 Feb 2009 18:24:19 -0800
Message-ID: <7vhc2tby24.fsf@gitster.siamese.dyndns.org>
References: <1234628513-4573-1-git-send-email-szeder@ira.uka.de>
 <1234628513-4573-2-git-send-email-szeder@ira.uka.de>
 <20090216155429.GA18525@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:26:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFek-0004EZ-Jf
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbZBQCY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 21:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbZBQCY0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:24:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZBQCYZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 21:24:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EA9132B4A1;
	Mon, 16 Feb 2009 21:24:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 443712B4A0; Mon,
 16 Feb 2009 21:24:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1809D786-FC9A-11DD-B304-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110294>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote:
>> 'git svn' got some new subcommands and otions in the last couple of
>> months.  This patch adds completion support for them.
>>=20
>> In particular:
>>=20
>>   * 'fetch', 'clone', etc.: '--ignore-paths=3D'
>>   * 'init' and 'clone': '--prefix=3D', '--use-log-author',
>>                         '--add-author-from'
>>   * 'dcommit': '--commit-url', '--revision'
>>   * 'log': '--color'
>>   * 'rebase': '--dry-run'
>>   * 'branch', 'tag', 'blame', 'migrate' subcommands and their option=
s
>>=20
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks, both.
