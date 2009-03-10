From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Tue, 10 Mar 2009 01:35:04 -0700
Message-ID: <7v1vt5bwsn.fsf@gitster.siamese.dyndns.org>
References: <49B5AF67.6050508@gmail.com>
 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com>
 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.10.0903100905050.14797@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgxSA-00062y-7T
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:36:46 +0100
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1LgxQo-0000Dr-UV
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:35:22 +0100
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1LgxQo-0000D3-TE
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:35:22 +0100
Received: from mail-forward2.uio.no ([129.240.10.71])
	by mail-mx2.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1LgxQo-0005Bw-S3
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:35:22 +0100
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1LgxQo-0003sB-Qq
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:35:22 +0100
Received: from mail-mx5.uio.no ([129.240.10.46])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1LgxQo-0003s8-Pa
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:35:22 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx5.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1LgxQn-0000cw-Hn
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbZCJIfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 04:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZCJIfO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 04:35:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZCJIfN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 04:35:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ECDE5A0040;
	Tue, 10 Mar 2009 04:35:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 96351A003F; Tue,
 10 Mar 2009 04:35:06 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0903100905050.14797@yvahk2.pbagnpgbe.fr>
 (Daniel Stenberg's message of "Tue, 10 Mar 2009 09:08:58 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E5D1E68-0D4E-11DE-8230-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 38A47E47FAEFBBC7DB0883621A2F82209B8F008B
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 54 total 2136898 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112793>

Daniel Stenberg <daniel@haxx.se> writes:

> On Mon, 9 Mar 2009, Junio C Hamano wrote:
>
>> The version of libcurl on my box is 7.18.something, and it does not
>> seem to ask for password when the URL has only username but not
>> colon-password. I also expected it to ask for password when
>> $HOME/.netrc has login but not password for a given machine, but
>> that does not seem to happen either. Perhaps the version is too old.
>
> No, that's entirely expected. libcurl has no "prompt the user if no
> password was given" logic but instead delegates that work to the
> application.
>
> There was once functionality for this (removed in October 2003) but it
> was broken and violated internal guidelines so we cut out and threw
> that code away.
>
> More recently there have been people interested in re-implementing
> this "the right way" but so far it hasn't been made and thus the
> application is left to perform this task.

It's always nice to find _the_ area expert around ;-)

I somehow misread the description on CURLOPT_NETRC that appears in
http://curl.haxx.se/libcurl/c/curl_easy_setopt.html:

	libcurl uses a user name (and supplied or prompted password)
	supplied with CURLOPT_USERPWD in preference to any of the options
	controlled by this parameter.

especially the "or prompted password" part to mean that unless supplied to
the library by the caller the library would prompt the user and obtain the
password.

Thanks for clarification.
