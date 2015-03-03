From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An interesting opinion on DVCS/git
Date: Tue, 03 Mar 2015 15:24:57 -0800
Message-ID: <xmqqwq2x8y0m.fsf@gitster.dls.corp.google.com>
References: <54F2CD12.8050609@gmail.com>
	<CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com>
	<CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:25:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSwBb-0000mx-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112AbbCCXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:25:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756764AbbCCXZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:25:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5719C3E216;
	Tue,  3 Mar 2015 18:24:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2LNYnneBh1dE85bBhuHF+kttaT8=; b=HzKyXR
	cOOfJ7cahMmc9pl2RFv3JSPru5hN6+ExLIJ28XDyM3eQQwuT+N/ZAIy3p5K4br1e
	DMWiPowJ2yBOvJnUFT8bdAFCmhzVlOq4PufAkhu7CXJ4hgN9GBmCt9bacLOA7sM5
	Kwfu2zuhHqBgdfvt55uc9z0p6UX+tn2/5HDmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JXhm+GMkyK65so1WFehsulYJPruP8rx3
	d7IkaYSvjjBkvoeJtrqUJhjXXiQ/kiKH9t6jNOco2eH8oUudhigPW/FJImOm/E06
	UHUTwVzJDB0yPKJZWWoH8Qu7tE94Xo01m9MBAj031NzrRPsNY45YHwfXl0OniEBa
	wDJdyQMfkK0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D7483E215;
	Tue,  3 Mar 2015 18:24:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8B673E212;
	Tue,  3 Mar 2015 18:24:58 -0500 (EST)
In-Reply-To: <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 3 Mar 2015 14:49:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 822A6102-C1FC-11E4-8735-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264709>

Shawn Pearce <spearce@spearce.org> writes:

> We have heard this sort of feedback for years. But we have been unable
> to adequately write our own documentation or clean up our man pages to
> be useful to the average person who doesn't know why the --no-frobbing
> option doesn't disable the --frobinator option to the
> --frobbing-subcommand of git frob.  :(

IIU/RC, GSoC is not only about coding.  Perhaps doing a proper
technical editing of the manual pages could be a summer project, to
which GitHub or somebody more skilled than us developers can supply
mentorship?
