From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-status -- trying to understand all possible states
Date: Wed, 02 Apr 2014 10:31:45 +0200
Message-ID: <vpqd2h0gmj2.fsf@anie.imag.fr>
References: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org>
	<20140401222002.GD6851@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Toy <michael@toyland.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeKi-0000xS-5q
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301AbaDBIb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 04:31:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44981 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758295AbaDBIbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 04:31:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s328VjfH025012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Apr 2014 10:31:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s328VjYo004874;
	Wed, 2 Apr 2014 10:31:45 +0200
In-Reply-To: <20140401222002.GD6851@google.com> (Jonathan Nieder's message of
	"Tue, 1 Apr 2014 15:20:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Apr 2014 10:31:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s328VjfH025012
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397032306.04289@4NFczJ/UjuXj42+OZxiFUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245701>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  - Please use --porcelain (implied by -z in the absence of another
>    format option) instead of --short.  --short is meant to be human
>    readable and details of the output might change some day.

It already does: part of the output may be translated to non-english.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
