From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 15:13:41 -0800
Message-ID: <20130131231341.GO27340@google.com>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <7vhalxdk2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 00:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U13Kd-0006m0-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 00:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab3AaXNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 18:13:50 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51642 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab3AaXNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 18:13:49 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so1953985pab.33
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZqAGswPyXR2A1XUN/affik3qMKfYOAHP9p7SCJa+Cqs=;
        b=AVBJ9NTZokeBQXXbPZ7bzqaT13RaIwVlebFSYPE8nkwpr616GcIWLxURUQZgsM34zO
         ZtNgsE/toP3ky9jj8Xpstt2XAgAmZcNN06KYGrRUNdEeSRXTjmMLAH3gF4tj2Y1/lGm1
         59C0pHnv5WDr9uqZSWLkyE1sYv/pwNbUpxtU/fpuWZmJ3IJFDpiZVyvOpVV95swR3cch
         g7mQvwecJWI+Qo1yXurxE2ufV1ACwDKFQYjXmFkzOBT4ZJQjM4/WNf1dolDnKsDp0DCp
         Np1/hrZt8ryIoz0j/llFOz9sPcK1njSz254iESlfPfE/ULV/EXM/dXA1KO2draeYMoat
         v7EQ==
X-Received: by 10.68.241.232 with SMTP id wl8mr26430656pbc.144.1359674027980;
        Thu, 31 Jan 2013 15:13:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ti9sm6294849pbc.16.2013.01.31.15.13.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 15:13:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhalxdk2q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215188>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Yes.  I have thought for years that it should be git-remote-helpers,
>> that "git help" should be tweaked to look for that, and that the
>> existing gitrepository-layout and friends should be replaced with
>> redirects.
>
> Because of the "git help" look up rules, we cannot have two pages
> that only differ at the dash (or absense of it) immediately after
> 'git'; e.g. one about the concept of 'frotz' in the context of Git,
> i.e. "man gitfrotz", and the other about the subcommand to perform
> 'frotz', i.e. "man git-frotz".  The way to refer to these two pages
> are both "git help frotz".

Exactly.  Hence the disambiguating dash-versus-nondash convention buys
us nothing.
