From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] Add built-in diff patterns for MATLAB code
Date: Tue, 15 Nov 2011 13:47:48 +0100
Message-ID: <df238a1919b7c7d05749b4aa637fe2c7@isy.liu.se>
References: <1321191764-11972-1-git-send-email-hendeby@isy.liu.se>
 <201111151337.07013.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 15 13:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQIQs-0007sl-PO
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 13:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab1KOMrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 07:47:53 -0500
Received: from muon.isy.liu.se ([130.236.48.25]:52873 "EHLO muon.isy.liu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab1KOMrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 07:47:52 -0500
Received: from webmail.isy.liu.se (localhost [127.0.0.1])
	by muon.isy.liu.se (Postfix) with ESMTP id C9E9C9C4;
	Tue, 15 Nov 2011 13:47:48 +0100 (MET)
In-Reply-To: <201111151337.07013.trast@student.ethz.ch>
X-Sender: hendeby@isy.liu.se
User-Agent: RoundCube Webmail/0.5.1
X-ISY-LIU-SE-MailScanner-Information: Please contact postmaster@isy.liu.se for more information
X-ISY-LIU-SE-MailScanner-ID: C9E9C9C4.A7BC8
X-ISY-LIU-SE-MailScanner: Found to be clean
X-ISY-LIU-SE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-ISY-LIU-SE-MailScanner-From: hendeby@isy.liu.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185457>

 On Tue, 15 Nov 2011 13:37:06 +0100, Thomas Rast wrote:
> Gustaf Hendeby wrote:
>> +PATTERNS("matlab",
>> +	 
>> "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
>> +	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\|\\||&&"),
>
> Shouldn't you, for matlab, ensure that ./ "sticks" as a single word
> since it is an operator?  At least we used the same logic for the C 
> ||
> and && operators, which you copied.

 Good point Thomas, I forgot all about the .-operators.  I will add 
 \.[*/^'] as words, are there any other ones to consider?  Thanks for 
 paying attention!

 /Gustaf
