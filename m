From: Christoph Buchner <bilderbuchi@phononoia.at>
Subject: Re: Bug: git ls-files and ignored directories
Date: Sun, 03 Jun 2012 13:44:30 +0200
Message-ID: <4FCB4E1E.2010907@phononoia.at>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com> <20120531101451.C35C5B4C00D@dd24126.kasserver.com> <20120601093757.GE32340@sigill.intra.peff.net> <7vr4tz3tpw.fsf@alter.siamese.dyndns.org> <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com> <4FC9F24D.7000306@phononoia.at> <7vr4txz5j9.fsf@alter.siamese.dyndns.org>
Reply-To: bilderbuchi@phononoia.at
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 13:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb9Eb-0008SH-2V
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 13:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab2FCLoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 07:44:32 -0400
Received: from dd24126.kasserver.com ([85.13.143.154]:56697 "EHLO
	dd24126.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2FCLob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 07:44:31 -0400
Received: from [192.168.1.2] (chello080108007198.36.11.tuwien.teleweb.at [80.108.7.198])
	by dd24126.kasserver.com (Postfix) with ESMTPSA id ADEFFFC0015;
	Sun,  3 Jun 2012 13:44:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vr4txz5j9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199083>

Yes they do.
In my test repo, git compiled from current pu branch shows
git ls-files --exclude-standard -i
apps/devApps/projectGenerator/.svn/wrongly-committed-svn.txt
apps/devApps/projectGenerator/some-wrong-file.txt
while git 1.7.9.5 shows
apps/devApps/projectGenerator/some-wrong-file.txt

Thank you for fixing this! Which git release is planned to contain the 
fix (if that can be said yet)? I'm not familiar with your workflow..

thx,
christoph

(junio, sorry for sending the mail twice, I accidentally hit reply 
instead of reply all)

On 06/03/2012 12:56 AM, Junio C Hamano wrote:
> Christoph Buchner<bilderbuchi@phononoia.at>  writes:
>
>> @Jeff: Thank you for the clarification. I didn't want to appear pushy,
>> I just wanted to make sure that I did everything right and that my
>> mail won't get ignored/filtered because of some breach of protocol.
>>
>> @Junio, Duy: Thanks for starting/proposing work on this!
> The patches are queued to 'pu'.  Do they fix your issue?
