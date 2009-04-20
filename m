From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 04/12] send-email: Verification for --smtp-server and --smpt-server-port
Date: Mon, 20 Apr 2009 08:40:44 -0700 (PDT)
Message-ID: <49ec977c.16078e0a.6aa7.288a@mx.google.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvvdU-0007oy-FT
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 17:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbZDTPkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 11:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbZDTPkr
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 11:40:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:7922 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbZDTPkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 11:40:46 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1912164wff.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=rGmNUfYO679JJj0miTbr1s55/pyboZWVpsE4wwdjEsA=;
        b=w5FtKXXQU6jrNDLbW7wArgjLlSbIrsdidBaHD7s+oEqZCfVXT+e55b4IQALQhCyViH
         bjA3raG6Kbz0jAS+4/IMs/3ON9BlGMUCA5VoIhekyscQyEP9sOOVkPhKn6LWE1H9imXr
         GBYHnp38jMMrEd688N+iEgNUsZlrkgyPHbXig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=Sf0xbia4OIHsFPpf8uHNputCvPGY6sEXyV+WzVa/3r/B6nq4tNambnlXr16GDJKMo0
         6yo2HiRUpBUpcBMX0+VFAfzkhecN8w6pZ3lkuGA1vA4ukIlfJOQ+tDHPWR/Ljx/xuD56
         bdaEIrBtFGolYTlT+uuDfMjb0Qo481aQnQuyw=
Received: by 10.142.156.19 with SMTP id d19mr4491267wfe.6.1240242045653;
        Mon, 20 Apr 2009 08:40:45 -0700 (PDT)
Received: from gmail.com (97-116-107-50.mpls.qwest.net [97.116.107.50])
        by mx.google.com with ESMTPS id 22sm17068427wfg.23.2009.04.20.08.40.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 08:40:44 -0700 (PDT)
In-Reply-To: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117000>

On Mon, Apr 20, 2009 at 09:59, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sorry, I should have checked myself.  defined-or "//" is 5.8.1 or later.

>From what I've read:

	http://perldoc.perl.org/perl581delta.html#Future-Directions

The defined-OR only exists for 5.8.1 in patch form, and it's only directly
supported in 5.10.0:

	http://perldoc.perl.org/perldelta.html#Defined-or-operator

:-(
