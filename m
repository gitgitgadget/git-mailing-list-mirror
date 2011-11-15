From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Add built-in diff patterns for MATLAB code
Date: Tue, 15 Nov 2011 14:14:34 +0100
Message-ID: <201111151414.34141.trast@student.ethz.ch>
References: <1321191764-11972-1-git-send-email-hendeby@isy.liu.se> <201111151337.07013.trast@student.ethz.ch> <df238a1919b7c7d05749b4aa637fe2c7@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue Nov 15 14:14:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQIqX-00041h-HT
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 14:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab1KONOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 08:14:36 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:58352 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab1KONOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 08:14:36 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 15 Nov
 2011 14:14:32 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 15 Nov
 2011 14:14:34 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <df238a1919b7c7d05749b4aa637fe2c7@isy.liu.se>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185458>

Gustaf Hendeby wrote:
>  On Tue, 15 Nov 2011 13:37:06 +0100, Thomas Rast wrote:
> > Gustaf Hendeby wrote:
> >> +PATTERNS("matlab",
> >> +	 
> >> "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
> >> +	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\|\\||&&"),
> >
> > Shouldn't you, for matlab, ensure that ./ "sticks" as a single word
> > since it is an operator?  At least we used the same logic for the C 
> > ||
> > and && operators, which you copied.
> 
>  Good point Thomas, I forgot all about the .-operators.  I will add 
>  \.[*/^'] as words, are there any other ones to consider?  Thanks for 
>  paying attention!

Uh, I'm afraid it's been years since I did matlab.  But

  http://www.mathworks.ch/help/techdoc/matlab_prog/f0-40063.html

seems to indicate you forgot '.\'.

Please also update the testcases to whether this splits correctly,
e.g., by changing './' to '/'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
