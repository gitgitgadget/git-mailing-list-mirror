From: Charles Bailey <charles@hashpling.org>
Subject: Re: Improvements to integer option parsing
Date: Mon, 22 Jun 2015 23:42:55 +0100
Message-ID: <7A2F4AE4-EB17-4FAE-A51A-7D6587FC5FCE@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org> <1434911144-6781-1-git-send-email-charles@hashpling.org> <xmqq7fqvfl9g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7AQw-0005Eb-2K
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbbFVWnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:43:01 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:53602 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbFVWm6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 18:42:58 -0400
Received: from hashpling.plus.com ([212.159.69.125]:62983 helo=[192.168.76.37])
	by host02.zombieandprude.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z7AQa-0005om-Bp; Mon, 22 Jun 2015 23:42:56 +0100
X-Mailer: iPhone Mail (12F70)
In-Reply-To: <xmqq7fqvfl9g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272433>


> On 22 Jun 2015, at 23:09, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Charles Bailey <charles@hashpling.org> writes:
>> 
>> - marginally improved the opterror message on failed parses
> 
> I'd queue with "s/a integer/a non-negative integer/".

Ha! That's what I had before I submitted, but then the source line got quite long (which could have been split) and the generated message got quite long as well so I cropped it. This was probably the source of the grammar mistake.

If you're happy with the longer message, I am happy with it too.
