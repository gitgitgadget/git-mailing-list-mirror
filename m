From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Mon, 07 Dec 2009 12:05:25 -0800
Message-ID: <7vmy1u35yy.fsf@alter.siamese.dyndns.org>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v7hsz9qxj.fsf@alter.siamese.dyndns.org> <20091207163338.GA27516@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHjqb-0006eH-1i
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbZLGUF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758774AbZLGUF2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:05:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbZLGUF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:05:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78EC4A4A80;
	Mon,  7 Dec 2009 15:05:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=WJ5xkmve8Wmo1Ow0FD11ZpZbmLw=; b=oXzkAnFi8Y8HSoS3v9AmlGW
	MCaMkoOZF7bX7ODg4nNb6O4qqD6BDKC7ylAOETX9/G6xkD16OAGlWuyEdMCmwLG8
	CDIgpifaHsx0HFpRD4vq0LTur+miRf2jFvVmIzUKhBHU3Mc7pINs2vC4+y8HYlSG
	qUAi+haH5XWtV2YqFGio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vYlY3RReZbsGNqlstzVCaPufokGtvEUS8YbDZHm5qz7YozRBP
	4CxZbGy12OQnNbagkj5olBgd9sftUTgVLuYzpuh2I/M9VR0mTQwz8dJKgNFTUSqe
	9M3D01G/RhR9PHKs1v3SB60A9a/2AGywwcnsbDWpD+rpm9wu05EUKfu/rU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53AFFA4A7C;
	Mon,  7 Dec 2009 15:05:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5EF35A4A78; Mon,  7 Dec 2009
 15:05:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE936896-E36B-11DE-9555-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134775>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Sun, Dec 06, 2009 at 11:36:08PM -0800, Junio C Hamano wrote:
>> I queued to ease the discussion in 'pu'.  I had to fix-up some conflicts
>> while doing so.  Please sanity check the result.
>
> The conflict resolution seems sane. 
>
> Sorry about leaving lots of codingstyle stuff unfixed.

No problem at all, and thanks.
