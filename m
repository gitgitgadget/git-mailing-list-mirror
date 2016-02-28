From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v3 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Sun, 28 Feb 2016 09:03:31 +0100
Message-ID: <56D2A9D3.4050303@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de> <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 09:03:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZwKJ-0000An-NR
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 09:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbcB1IDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 03:03:34 -0500
Received: from moritzneeb.de ([78.47.1.106]:38052 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbcB1IDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 03:03:33 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 512171C02F;
	Sun, 28 Feb 2016 09:03:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456646612;
	bh=F0BPZvcle+TGtep4KCGZZgW/0lheYzDqXKs9qYvFm00=;
	h=Subject:References:Cc:To:From:Date:In-Reply-To:From;
	b=by70x66ggmi26KI9Vf4epDWWE+WU8Kv2lwSIL8tSatrlVhXJ0+Q4zA0L1NfqGR4zg
	 YIYApC6B6X6m0wB6lVMYubwBzsSs3XEMqSy17lBy3OfC3bDWqYRUSGMft/uvd1XAmZ
	 a4e81QY2f+RpiVBwGXHRky2VN8QlIGqUsdOQN7J4=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287760>

On 02/28/2016 06:07 AM, Moritz Neeb wrote:
> Changes since v2:
> 
> * Line splitting in notes_copy_from_stdin() is changed to string_list_split as
>   suggested by Eric Sunshine.
> * The behavior change in interactive cleaning from patch v2 is undone.
> * Some of the previous patches were broken because of some unexpected
>   whitespace. This should be fixed now.
> 

What I could not yet develop, is a feeling on "how often" to send out new versions of patches.
For a small patch like this it feels a bit weird to send out version after version, but maybe
that is a good practice? Now that I have implemented some (mainly textual) improvements that
came up through the review by Eric, would I rather send out a v4 or wait for comments by other
reviewers?

Thanks
