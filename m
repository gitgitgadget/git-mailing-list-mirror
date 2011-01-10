From: Sam Vilain <sam@vilain.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Tue, 11 Jan 2011 10:42:22 +1300
Message-ID: <4D2B7D3E.7090400@vilain.net>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com> <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com> <4D2B3643.2070106@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Wyzer <john.wyzer@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 22:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPVZ-0002Oy-3T
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 22:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab1AJVm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 16:42:28 -0500
Received: from mx4.orcon.net.nz ([219.88.242.54]:52846 "EHLO mx4.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab1AJVm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 16:42:27 -0500
Received: from Debian-exim by mx4.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PcPVS-0003sj-7g
	for git@vger.kernel.org; Tue, 11 Jan 2011 10:42:26 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx4.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PcPVS-0003sb-4N
	for git@vger.kernel.org; Tue, 11 Jan 2011 10:42:26 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id CFD602E09B; Tue, 11 Jan 2011 10:42:25 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.1.83] (arcturus.lan [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9EAF82E094;
	Tue, 11 Jan 2011 10:42:22 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4D2B3643.2070106@gmx.de>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx4.orcon.net.nz on Tue, 11 Jan 2011 10:42:26 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Tue Jan 11 10:42:26 2011
X-DSPAM-Confidence: 0.5939
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164899>

On 11/01/11 05:39, John Wyzer wrote:
> Why not provide an alternative mode for the git:// protocoll that
> instead of retrieving a big packaged blob breaks this down to the
> smallest atomic objects from the repository? Those are not changing
> and should be able to survive partial transfers.
> While this might not be as efficient network traffic-wise it would
> provide a solution for those behind breaking connections.

To put this into numbers, for perl.git that might mean transferring 2GB
of data instead of 70MB of pack.

Sam
